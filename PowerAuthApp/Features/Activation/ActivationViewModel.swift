import Foundation
import Dependencies

@Observable
@MainActor
final class ActivationViewModel {
    var code: String = ""
    var isLoading = false
    var error: AuthError?
    var navigateToPassword = false

    @ObservationIgnored
    @Dependency(\.authService) var authService

    func confirmTapped() {
        Task { @MainActor in
            isLoading = true
            defer { isLoading = false }
            do {
                try await authService.createActivation(with: code)
                navigateToPassword = true
            } catch let authError as AuthError {
                error = authError
            } catch {
                self.error = .unknown
            }
        }
    }
}
