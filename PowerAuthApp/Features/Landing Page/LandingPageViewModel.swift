import Dependencies
import Foundation

@Observable
@MainActor
final class LandingPageViewModel {
    var isLoading = false
    var error: AuthError?
    var navigateToActivation = false
    var navigateToResult = false

    @ObservationIgnored
    @Dependency(\.authService) var authService

    func startTapped() {
        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                try authService.configure()
                guard authService.isConfigured else {
                    error = .notConfigured
                    return
                }
                if authService.hasValidActivation {
                    navigateToResult = true
                } else {
                    navigateToActivation = true
                }
            } catch let authError as AuthError {
                error = authError
            } catch {
                self.error = .unknown
            }
        }
    }
}
