import SwiftUI

enum ButtonVariant {
    case dark
    case ghost
}

struct PrimaryButton: View {
    let title: String
    var variant: ButtonVariant = .dark
    var isDisabled: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .tracking(0.2)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .foregroundColor(isDisabled ? Colors.background : (variant == .dark ? .white : Colors.label))
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(isDisabled ? Colors.tertiaryLabel : (variant == .dark ? Colors.label : Color.white))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .strokeBorder(
                                    variant == .ghost ? Colors.separator : Color.clear,
                                    lineWidth: 1
                                )
                        )
                )
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
    }
}

#Preview {
    VStack(spacing: 16) {
        PrimaryButton(title: "Start activation", variant: .dark) {}
        PrimaryButton(title: "Confirm", variant: .ghost) {}
    }
    .padding(32)
    .background(Colors.background)
}
