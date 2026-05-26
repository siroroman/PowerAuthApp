enum ActivationStatus: String, Sendable, Equatable {
    case created
    case pendingCommit
    case active
    case blocked
    case removed
    case deadlock
    case unknown
}
