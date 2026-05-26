protocol AuthServiceProtocol: AnyObject {
    var isConfigured: Bool { get }
    var hasValidActivation: Bool { get }

    func configure() throws
    func createActivation(with code: String) async throws -> String
    func persistActivation(with password: String) throws
    func fetchActivationStatus() async throws -> ActivationStatus
}
