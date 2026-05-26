import Foundation

@Observable
@MainActor
final class ResultViewModel {
    var onDone: () -> Void = {}

    func doneTapped() {
        onDone()
    }
}
