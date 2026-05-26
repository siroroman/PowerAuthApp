# PowerAuthApp

An iOS app built as a homework assignment for Wultra. It integrates the [PowerAuth Mobile SDK](https://github.com/wultra/powerauth-mobile-sdk-spm) and walks the user through a three-step activation flow: entering an activation code, setting a password, and confirming the resulting activation status.

---

## Activation Flow

![Activation flow](activation-flow.png)

**Landing → activation code → password → status**

| Screen | What happens |
|---|---|
| **Landing** | Entry point. If the device is already activated, the user lands directly on the Status screen. Otherwise, tapping *Start activation* initialises the SDK and navigates forward. |
| **Activation code** | The user types their one-time activation code (`XXXX-XXXX-XXXX-XXXX`). Tapping *Confirm* calls `createActivation(withName:activationCode:)` on the SDK. On success the app moves to the Password screen. |
| **Password** | The user creates a password that satisfies three inline rules (8+ characters, one uppercase letter, one number or symbol). Tapping *Confirm* calls `persistActivation(withPassword:)` to commit the activation to the keychain, then polls `fetchActivationStatus()` until the server transitions to `.active`. |
| **Status** | Displays *Status: Active* and a *Done* button that returns the user to the Landing screen. |

Loading and error states are present on every screen: a full-screen spinner blocks interaction while an async operation is in flight, and a modal error dialog appears on failure.

---

## Architecture

### Layer overview

```
PowerAuthApp
├── App/                   – App entry point, root NavigationStack
├── AuthService/           – SDK wrapper + protocol + types
├── Features/
│   ├── Launch/            – Animated splash screen
│   ├── Landing Page/      – Entry screen, SDK init trigger
│   ├── Activation/        – Activation code input
│   ├── Password/          – Password creation + persist
│   └── Result/            – Activation confirmed screen
├── DesignSystem/
│   ├── Components/        – InputField, PrimaryButton, ErrorAlert, LoadingHUD, …
│   ├── Colors.swift
│   └── Fonts.swift
└── Localization/          – AppStringKey enum + Localizable.xcstrings (EN + CS)
```

---

## SDK Configuration

| Key | Value |
|---|---|
| Base endpoint URL | `https://stable-mtoken-dev.wultra.app/enrollment-server` |
| Instance ID | `romansiro.PowerAuthApp` (bundle identifier) |
| Configuration | see `PowerAuthConfig.swift` |

---

## Requirements

- Xcode 16+
- iOS 17+ deployment target
- Swift 6
- Dependencies resolved via Swift Package Manager (automatic on first build)

### Dependencies

| Package | Purpose |
|---|---|
| [powerauth-mobile-sdk-spm](https://github.com/wultra/powerauth-mobile-sdk-spm) `1.9.6` | PowerAuth2 SDK |
| [swift-dependencies](https://github.com/pointfreeco/swift-dependencies) | Dependency injection |
