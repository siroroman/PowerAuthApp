import Foundation
import Dependencies

@Observable
@MainActor
final class ActivationViewModel {
    var code: String = ""
    var isLoading = false
    var error: AuthError?
    var navigateToPassword = false
    private(set) var fingerprint: String = ""

    @ObservationIgnored
    @Dependency(\.authService) var authService

    func confirmTapped() {
        Task { @MainActor in
            isLoading = true
            defer { isLoading = false }
            do {
                fingerprint = try await authService.createActivation(with: code)
                navigateToPassword = true
            } catch let authError as AuthError {
                error = authError
            } catch {
                self.error = .unknown
            }
        }
    }
}
