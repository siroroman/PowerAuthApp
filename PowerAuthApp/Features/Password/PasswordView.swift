import SwiftUI

struct PasswordView: View {
    @Bindable var viewModel: PasswordViewModel

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
                        text: $viewModel.password,
                        style: .secure
                    )
                    .padding(.top, 36)

                    passwordRules
                        .padding(.top, 24)
                }
                .padding(.horizontal, 32)

                Spacer()

                PrimaryButton(title: "Confirm", action: viewModel.onConfirm)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
            }
        }
    }

    private var passwordRules: some View {
        VStack(alignment: .leading, spacing: 12) {
            PasswordRuleView(met: viewModel.hasMinLength, label: "At least 8 characters")
            PasswordRuleView(met: viewModel.hasUppercase, label: "One uppercase letter")
            PasswordRuleView(met: viewModel.hasNumberOrSymbol, label: "One number or symbol")
        }
    }
}

#Preview {
    PasswordView(viewModel: PasswordViewModel())
}
