import Dependencies
import Foundation

@Observable
@MainActor
final class LandingPageViewModel {
    var isLoading = false
    var error: AuthError?
    var navigateToActivation = false

    @ObservationIgnored
    @Dependency(\.authService) var authService

    func startTapped() {
        Task { @MainActor in
            isLoading = true
            defer { isLoading = false }
            do {
                try authService.configure()
                if authService.isConfigured {
                    navigateToActivation = true
                } else {
                    error = .notConfigured
                }
            } catch let authError as AuthError {
                error = authError
            } catch {
                self.error = .unknown
            }
        }
    }
}
