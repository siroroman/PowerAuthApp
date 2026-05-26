import SwiftUI

struct PasswordView: View {
    var onBack: () -> Void = {}
    var onConfirm: () -> Void = {}

    @State private var password = ""

    var body: some View {
        ZStack {
            Colors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                navigationBar

                VStack(alignment: .leading, spacing: 0) {
                    StepHeader(
                        step: "Step 2 of 3",
                        title: "Set a password",
                        subtitle: "You'll use this to sign in from now on."
                    )
                    .padding(.top, 48)

                    InputField(
                        placeholder: "Password",
                        text: $password,
                        style: .secure
                    )
                    .padding(.top, 36)

                    passwordRules
                        .padding(.top, 24)
                }
                .padding(.horizontal, 32)

                Spacer()

                PrimaryButton(title: "Confirm", action: onConfirm)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
            }
        }
    }

    private var navigationBar: some View {
        HStack {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Colors.label)
                    .frame(width: 36, height: 36)
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 8)
    }

    private var passwordRules: some View {
        let hasMinLength = password.count >= 8
        let hasUppercase = password.contains(where: \.isUppercase)
        let hasNumberOrSymbol = password.contains(where: { $0.isNumber || $0.isPunctuation || $0.isSymbol })

        return VStack(alignment: .leading, spacing: 12) {
            PasswordRule(met: hasMinLength, label: "At least 8 characters")
            PasswordRule(met: hasUppercase, label: "One uppercase letter")
            PasswordRule(met: hasNumberOrSymbol, label: "One number or symbol")
        }
    }
}

private struct PasswordRule: View {
    let met: Bool
    let label: String

    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(met ? Colors.label : Color.clear)
                    .frame(width: 16, height: 16)
                if met {
                    Image(systemName: "checkmark")
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(.white)
                } else {
                    Circle()
                        .strokeBorder(Colors.separator, lineWidth: 1)
                        .frame(width: 16, height: 16)
                }
            }
            Text(label)
                .font(.system(size: 13))
                .foregroundColor(met ? Colors.label : Colors.secondaryLabel)
        }
    }
}

#Preview {
    PasswordView()
}
