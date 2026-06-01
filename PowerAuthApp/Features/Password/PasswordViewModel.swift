import Dependencies
import Foundation

@Observable
@MainActor
final class PasswordViewModel {
    var password: String = ""
    var isLoading = false
    var error: AuthError?
    var navigateToResult = false
    var onDone: () -> Void = {}

    @ObservationIgnored
    @Dependency(\.authService) var authService

    var hasMinLength: Bool { password.count >= 8 }
    var hasUppercase: Bool { password.contains(where: \.isUppercase) }
    var hasNumberOrSymbol: Bool { password.contains(where: { $0.isNumber || $0.isPunctuation || $0.isSymbol }) }
    var isValid: Bool { hasMinLength && hasUppercase && hasNumberOrSymbol }

    private func fetchStatusWithRetry() async throws -> ActivationStatus {
        var attempts = 0
        while true {
            let status = try await authService.fetchActivationStatus()
            if status != .pendingCommit || attempts >= 2 {
                return status
            }
            attempts += 1
            try await Task.sleep(for: .seconds(2))
        }
    }

    func confirmTapped() {
        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                try authService.persistActivation(with: password)
                password = ""
                let status = try await fetchStatusWithRetry()
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
