import Foundation

@Observable
final class PasswordViewModel {
    let fingerprint: String
    var password: String = ""
    var onBack: () -> Void = {}
    var onConfirm: () -> Void = {}

    init(fingerprint: String = "") {
        self.fingerprint = fingerprint
    }

    var hasMinLength: Bool { password.count >= 8 }
    var hasUppercase: Bool { password.contains(where: \.isUppercase) }
    var hasNumberOrSymbol: Bool { password.contains(where: { $0.isNumber || $0.isPunctuation || $0.isSymbol }) }
    var isValid: Bool { hasMinLength && hasUppercase && hasNumberOrSymbol }
}
