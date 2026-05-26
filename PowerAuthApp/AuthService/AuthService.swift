import PowerAuth2

final class AuthService: AuthServiceProtocol {

    private var powerAuthSDK: PowerAuthSDK?

    var isConfigured: Bool { powerAuthSDK != nil }

    var hasValidActivation: Bool { powerAuthSDK?.hasValidActivation() ?? false }

    func configure() throws {
        let config = PowerAuthConfiguration(
            instanceId: PowerAuthConfig.instanceId,
            baseEndpointUrl: PowerAuthConfig.baseEndpointUrl,
            configuration: PowerAuthConfig.configuration
        )
        guard config.validate() else {
            throw AuthError.notConfigured
        }
        powerAuthSDK = PowerAuthSDK(configuration: config)
    }

    func createActivation(with code: String) async throws -> String {
        guard let sdk = powerAuthSDK else { throw AuthError.notConfigured }
        return try await withCheckedThrowingContinuation { continuation in
            sdk.createActivationWithName("PowerAuthApp", activationCode: code) { result, error in
                if let error {
                    continuation.resume(throwing: AuthError.activationFailed(error.localizedDescription))
                } else if let fingerprint = result?.activationFingerprint {
                    continuation.resume(returning: fingerprint)
                } else {
                    continuation.resume(throwing: AuthError.unknown)
                }
            }
        }
    }

    func persistActivation(with password: String) throws {
        guard let sdk = powerAuthSDK else { throw AuthError.notConfigured }
        do {
            try sdk.persistActivation(withPassword: password)
        } catch {
            throw AuthError.persistFailed(error.localizedDescription)
        }
    }

    func fetchActivationStatus() async throws -> ActivationStatus {
        guard let sdk = powerAuthSDK else { throw AuthError.notConfigured }
        return try await withCheckedThrowingContinuation { continuation in
            sdk.fetchActivationStatus { status, error in
                if let error {
                    continuation.resume(throwing: AuthError.statusFetchFailed(error.localizedDescription))
                } else if let status {
                    continuation.resume(returning: Self.mapState(status.state))
                } else {
                    continuation.resume(throwing: AuthError.unknown)
                }
            }
        }
    }

    private static func mapState(_ state: PowerAuthActivationState) -> ActivationStatus {
        switch state {
        case .created:      return .created
        case .pendingCommit: return .pendingCommit
        case .active:       return .active
        case .blocked:      return .blocked
        case .removed:      return .removed
        case .deadlock:     return .deadlock
        @unknown default:   return .unknown
        }
    }
}
