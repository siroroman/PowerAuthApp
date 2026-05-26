import SwiftUI

struct PasswordView: View {
    var onBack: () -> Void = {}
    var onConfirm: () -> Void = {}

    @State private var password = ""

    var body: some View {
        ZStack {
            Colors.background.ignoresSafeArea()

            VStack(spacing: 0) {
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

    private var passwordRules: some View {
        let hasMinLength = password.count >= 8
        let hasUppercase = password.contains(where: \.isUppercase)
        let hasNumberOrSymbol = password.contains(where: { $0.isNumber || $0.isPunctuation || $0.isSymbol })

        return VStack(alignment: .leading, spacing: 12) {
            PasswordRuleView(met: hasMinLength, label: "At least 8 characters")
            PasswordRuleView(met: hasUppercase, label: "One uppercase letter")
            PasswordRuleView(met: hasNumberOrSymbol, label: "One number or symbol")
        }
    }
}


#Preview {
    PasswordView()
}
