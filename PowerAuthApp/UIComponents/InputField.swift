import SwiftUI

enum FieldStyle {
    case standard
    case secure
    case code
}

struct InputField: View {
    let placeholder: String
    @Binding var text: String
    var style: FieldStyle = .standard

    @FocusState private var isFocused: Bool
    @State private var isRevealed = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(Theme.field)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .strokeBorder(
                            isFocused ? Theme.ink : Theme.hairline,
                            lineWidth: 1.5
                        )
                )

            HStack(spacing: 0) {
                inputField
                if style == .secure {
                    Button(action: { isRevealed.toggle() }) {
                        Image(systemName: isRevealed ? "eye.slash" : "eye")
                            .font(.system(size: 16))
                            .foregroundColor(Theme.muted)
                    }
                    .padding(.trailing, 18)
                }
            }
        }
        .frame(height: style == .code ? 64 : 60)
    }

    @ViewBuilder
    private var inputField: some View {
        switch style {
        case .standard:
            TextField(placeholder, text: $text)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(Theme.ink)
                .padding(.horizontal, 18)
                .focused($isFocused)

        case .secure:
            Group {
                if isRevealed {
                    TextField(placeholder, text: $text)
                } else {
                    SecureField(placeholder, text: $text)
                }
            }
            .font(.system(size: 22, weight: .regular))
            .tracking(4)
            .foregroundColor(Theme.ink)
            .padding(.leading, 18)
            .focused($isFocused)

        case .code:
            TextField(placeholder, text: $text)
                .font(.system(size: 22, weight: .medium).monospaced())
                .tracking(3)
                .foregroundColor(Theme.ink)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 18)
                .focused($isFocused)
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        InputField(placeholder: "Email", text: .constant(""), style: .standard)
        InputField(placeholder: "Password", text: .constant("Password1"), style: .secure)
        InputField(placeholder: "XXXX – XXXX – XXXX", text: .constant("4921 – 7K3M –"), style: .code)
    }
    .padding(32)
    .background(Theme.background)
}
