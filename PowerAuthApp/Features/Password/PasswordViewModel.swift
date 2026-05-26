import Dependencies
import Foundation

@Observable
@MainActor
final class PasswordViewModel {
    var password: String = ""
    var isLoading = false
    var error: AuthError?
    var navigateToResult = false

    @ObservationIgnored
    @Dependency(\.authService) var authService

    var hasMinLength: Bool { password.count >= 8 }
    var hasUppercase: Bool { password.contains(where: \.isUppercase) }
    var hasNumberOrSymbol: Bool { password.contains(where: { $0.isNumber || $0.isPunctuation || $0.isSymbol }) }
    var isValid: Bool { hasMinLength && hasUppercase && hasNumberOrSymbol }

    func confirmTapped() {
        Task { @MainActor in
            isLoading = true
            defer { isLoading = false }
            do {
                try authService.persistActivation(with: password)
                let status = try await authService.fetchActivationStatus()
                if status == .active {
                    navigateToResult = true
                } else {
                    error = .unknown
                }
            } catch let authError as AuthError {
                error = authError
            } catch {
                self.error = .unknown
            }
        }
    }
}
