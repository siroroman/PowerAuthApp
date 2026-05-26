import Foundation
import SwiftUI

extension String {
    static func localized(_ key: AppStringKey) -> String {
        NSLocalizedString(key.rawValue, comment: "")
    }
}

extension Text {
    init(_ key: AppStringKey) {
        self.init(SwiftUI.LocalizedStringKey(key.rawValue))
    }
}
