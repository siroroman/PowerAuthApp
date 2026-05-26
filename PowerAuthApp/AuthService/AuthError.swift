import Foundation

enum AuthError: Error, LocalizedError, Sendable {
    case notConfigured
    case activationFailed(String)
    case persistFailed(String)
    case statusFetchFailed(String)
    case unknown

    var errorDescription: String? {
        switch self {
        case .notConfigured: .localized(.authErrorNotConfigured)
        case .activationFailed(let msg): msg
        case .persistFailed(let msg): msg
        case .statusFetchFailed(let msg): msg
        case .unknown: .localized(.authErrorUnknown)
        }
    }
}
