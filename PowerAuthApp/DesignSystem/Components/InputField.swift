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

    @Environment(\.scenePhase) private var scenePhase
    @FocusState private var isFocused: Bool
    @State private var isRevealed = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(Colors.inputBackground)
                .stroke(isFocused ? Colors.label : Colors.separator, lineWidth: 1.5)

            HStack(spacing: 0) {
                inputField
                if style == .secure {
                    Button(action: {
                        isRevealed.toggle()
                        isFocused = true
                    }) {
                        Image(systemName: isRevealed ? "eye.slash" : "eye")
                            .font(.system(size: 16))
                            .foregroundStyle(Colors.secondaryLabel)
                    }
                    .padding(.trailing, 18)
                }
            }
        }
        .frame(height: style == .code ? 64 : 60)
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase != .active {
                isRevealed = false
            }
        }
    }

    @ViewBuilder
    private var inputField: some View {
        switch style {
        case .standard:
            TextField(placeholder, text: $text)
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(Colors.label)
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
            .font(Fonts.inputSmall)
            .tracking(2)
            .foregroundStyle(Colors.label)
            .padding(.leading, 18)
            .focused($isFocused)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .keyboardType(.asciiCapable)

        case .code:
            TextField(placeholder, text: $text)
                .font(.system(size: 16, weight: .medium).monospaced())
                .tracking(3)
                .foregroundStyle(Colors.label)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 18)
                .focused($isFocused)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.characters)
                .keyboardType(.asciiCapable)
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
    .background(Colors.background)
}
