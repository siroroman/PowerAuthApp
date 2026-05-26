import Foundation

enum AuthError: Error, LocalizedError, Sendable {
    case notConfigured
    case activationFailed(String)
    case persistFailed(String)
    case statusFetchFailed(String)
    case unknown

    var errorDescription: String? {
        switch self {
        case .notConfigured: "PowerAuth SDK is not configured"
        case .activationFailed(let msg): "Activation failed: \(msg)"
        case .persistFailed(let msg): "Persist failed: \(msg)"
        case .statusFetchFailed(let msg): "Status fetch failed: \(msg)"
        case .unknown: "An unknown error occurred"
        }
    }
}
