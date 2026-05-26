import Foundation

@Observable
final class ResultViewModel {
    var onDone: () -> Void = {}

    func doneTapped() {
        onDone()
    }
}
