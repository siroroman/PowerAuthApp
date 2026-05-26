import Foundation

@Observable
final class ResultViewModel {
    var onBack: () -> Void = {}
}
