import Foundation

@Observable
final class ActivationViewModel {
    var code: String = ""
    var onBack: () -> Void = {}
    var onConfirm: () -> Void = {}
}
