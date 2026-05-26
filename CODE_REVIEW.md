# Code Review — PowerAuthApp

**Date:** 2026-05-26
**Branch:** `master`
**Effort:** Extra-high (5 angles x 8 candidates, 1-vote verify, sweep)

---

## Summary

15 findings across concurrency, navigation, UX, and project configuration. The most critical cluster involves **AuthService lacking actor isolation** (data races under Swift Concurrency), **view models created inline without `@State`** (state loss on re-render), and **buttons not disabled during loading** (concurrent SDK operations on double-tap).

---

## Findings

### 1. AuthService has no actor isolation — data race on mutable `powerAuthSDK`

| | |
|---|---|
| **File** | `AuthService/AuthService.swift:6` |
| **Severity** | Critical |
| **Status** | Plausible |

`AuthService` is `@Observable` with a mutable `powerAuthSDK` property, accessed from `@MainActor` view models and from arbitrary SDK callback threads inside `withCheckedThrowingContinuation`. Under concurrent access, `@Observable`'s tracking infrastructure can corrupt. Swift 6 strict concurrency would flag this as a compile error.

**Fix:** Add `@MainActor` to `AuthService`, or make it an `actor`.

---

### 2. `LandingPageViewModel()` created inline in `body` — recreated on state change

| | |
|---|---|
| **File** | `App/ContentView.swift:9` |
| **Severity** | Critical |
| **Status** | Confirmed |

`LandingPageView(viewModel: LandingPageViewModel())` appears inside `body` with no `@State` wrapper. When `isLaunching` flips to `false` at 1.5s, `body` re-evaluates and constructs a brand-new `LandingPageViewModel`. Any in-flight navigation, loading state, or error is silently discarded.

**Fix:** Store the view model as `@State private var landingVM = LandingPageViewModel()`.

---

### 3. Confirm buttons not disabled during `isLoading` — double-tap spawns concurrent SDK calls

| | |
|---|---|
| **File** | `Features/Activation/ActivationView.swift:32`, `Features/Password/PasswordView.swift:33` |
| **Severity** | High |
| **Status** | Confirmed |

`isDisabled` checks only `code.isEmpty` / `!viewModel.isValid`, not `isLoading`. `LoadingHUD` doesn't block touches. A second tap while `createActivation` or `persistActivation` is in-flight spawns a concurrent `Task` on the same SDK instance.

**Fix:** Change to `isDisabled: viewModel.code.isEmpty || viewModel.isLoading` (and equivalent in `PasswordView`).

---

### 4. No retry path after `persistActivation` succeeds but status check fails

| | |
|---|---|
| **File** | `Features/Password/PasswordViewModel.swift:26` |
| **Severity** | High |
| **Status** | Confirmed |

`persistActivation` commits to keychain, then `fetchActivationStatus` may fail or return non-`.active`. The `ErrorAlert` shows only a Close button (no `onPrimary` at any call site). The user is stuck — dismissing resets the error but provides no way to retry the status check, and re-entering a password would double-persist.

**Fix:** Add an `onPrimary` retry handler that re-calls `fetchActivationStatus`, or accept `pendingCommit` as a success state.

---

### 5. View models created inside `navigationDestination` closures — new instance on re-render

| | |
|---|---|
| **File** | `Features/Landing Page/LandingPageView.swift:49`, `Features/Activation/ActivationView.swift:52`, `Features/Password/PasswordView.swift:51` |
| **Severity** | High |
| **Status** | Plausible |

`ActivationViewModel`, `PasswordViewModel`, and `ResultViewModel` are all constructed inside `navigationDestination` closures. SwiftUI may re-evaluate these during parent state changes, creating fresh view models and losing mid-flow state.

**Fix:** Store child view models as `@State` properties on the parent view.

---

### 6. `fetchActivationStatus` called immediately after `persistActivation` — timing issue

| | |
|---|---|
| **File** | `Features/Password/PasswordViewModel.swift:27` |
| **Severity** | Medium |
| **Status** | Plausible |

`persistActivation` commits locally but the server may not have transitioned to `.active` yet. The immediate `fetchActivationStatus` can return `.pendingCommit`, causing `error = .unknown` despite a successful activation.

**Fix:** Accept `.pendingCommit` as a valid post-persist status, or add a short retry/poll loop.

---

### 7. Activation code input uses `.secure` style instead of `.code`

| | |
|---|---|
| **File** | `Features/Activation/ActivationView.swift:22` |
| **Severity** | Medium |
| **Status** | Confirmed |

`InputField(placeholder: "", text: $viewModel.code, style: .secure)` masks the activation code as dots. The subtitle says "Format: XXXX-XXXX-XXXX-XXXX", indicating the code should be visible. The `.code` style (monospaced, centered) exists for this purpose.

**Fix:** Change `style: .secure` to `style: .code`.

---

### 8. `PasswordView` shows "Activation failed" error title for password-stage errors

| | |
|---|---|
| **File** | `Features/Password/PasswordView.swift:44` |
| **Severity** | Medium |
| **Status** | Confirmed |

`ErrorAlert` uses `errorTitleActivationFailed` for persist and status-fetch errors. After completing the activation code step, a password rejection shows "Activation failed" — semantically wrong and confusing.

**Fix:** Add a `errorTitlePasswordFailed` localization key and use it in `PasswordView`.

---

### 9. `Assets.xcassets` deleted but build settings still reference `AppIcon` / `AccentColor`

| | |
|---|---|
| **File** | `PowerAuthApp.xcodeproj/project.pbxproj:395` |
| **Severity** | Medium |
| **Status** | Confirmed |

`ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon` and `ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor` point to assets that no longer exist. The app installs with a blank/placeholder icon.

**Fix:** Re-add `Assets.xcassets` with the app icon assets, or remove the build settings.

---

### 10. `ResultViewModel` missing `@MainActor` — `onDone` mutates `@MainActor` state

| | |
|---|---|
| **File** | `Features/Result/ResultViewModel.swift:4` |
| **Severity** | Medium |
| **Status** | Confirmed |

`onDone` closures capture `@MainActor`-isolated state (e.g., `viewModel.navigateToActivation = false`). `doneTapped()` calls `onDone()` without an actor hop. Works in practice (called from SwiftUI buttons on main thread), but violates actor isolation under Swift 6.

**Fix:** Add `@MainActor` to `ResultViewModel`.

---

### 11. `InputField` loses keyboard focus when toggling secure/revealed

| | |
|---|---|
| **File** | `DesignSystem/Components/InputField.swift:55` |
| **Severity** | Medium |
| **Status** | Confirmed |

Toggling `isRevealed` swaps `SecureField` for `TextField`. SwiftUI destroys the old field, clearing `@FocusState`. The keyboard dismisses and the user must tap again to resume typing.

**Fix:** Programmatically set `isFocused = true` after toggling `isRevealed`, or use a single `TextField` with `textContentType(.password)` and custom masking.

---

### 12. `DependencyValues.authService` typed as concrete `AuthService`, not `AuthServiceProtocol`

| | |
|---|---|
| **File** | `AuthService/AuthService.swift:81` |
| **Severity** | Low-Medium |
| **Status** | Confirmed |

The dependency property returns `AuthService` (the class), not `AuthServiceProtocol`. Tests cannot inject a mock conforming only to the protocol. The protocol abstraction is entirely bypassed.

**Fix:** Change the dependency type to `AuthServiceProtocol` (requires `DependencyKey` adjustment).

---

### 13. `InputField` styles have no keyboard type, autocorrect, or autocapitalization overrides

| | |
|---|---|
| **File** | `DesignSystem/Components/InputField.swift:68` |
| **Severity** | Low-Medium |
| **Status** | Confirmed |

The `.code` style shows a default keyboard with autocorrect. The `.secure` style (when revealed as `TextField`) also has autocorrect active, potentially exposing password content to the keyboard dictionary.

**Fix:** Add `.autocorrectionDisabled()`, `.textInputAutocapitalization(.never)`, and appropriate `.keyboardType()` per style.

---

### 14. `PowerAuthAppTests` target configured but source file deleted — empty test bundle

| | |
|---|---|
| **File** | `PowerAuthApp.xcodeproj/project.pbxproj:122` |
| **Severity** | Low-Medium |
| **Status** | Confirmed |

The test target exists with build configurations and dependencies but has an empty source file list. Running tests produces 0 tests / 0 failures, giving false confidence.

**Fix:** Either remove the test target from the project or add test source files.

---

### 15. `configure()` unconditionally replaces `powerAuthSDK` — no guard against re-initialization

| | |
|---|---|
| **File** | `AuthService/AuthService.swift:14` |
| **Severity** | Low-Medium |
| **Status** | Plausible |

`startTapped()` calls `configure()` every time. If triggered multiple times (rapid taps before navigation), the SDK instance is silently replaced. Any in-progress activation on the old instance becomes orphaned.

**Fix:** Add `guard powerAuthSDK == nil else { return }` at the top of `configure()`.
