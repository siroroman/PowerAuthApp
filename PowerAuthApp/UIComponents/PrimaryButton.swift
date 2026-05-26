import SwiftUI

enum ButtonVariant {
    case dark
    case ghost
}

struct PrimaryButton: View {
    let title: String
    var variant: ButtonVariant = .dark
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .tracking(0.2)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .foregroundColor(variant == .dark ? .white : Theme.ink)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(variant == .dark ? Theme.ink : Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .strokeBorder(
                                    variant == .ghost ? Theme.hairline : Color.clear,
                                    lineWidth: 1
                                )
                        )
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 16) {
        PrimaryButton(title: "Start activation", variant: .dark) {}
        PrimaryButton(title: "Confirm", variant: .ghost) {}
    }
    .padding(32)
    .background(Theme.background)
}
