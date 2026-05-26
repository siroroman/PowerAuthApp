import SwiftUI

struct PasswordView: View {
    @Bindable var viewModel: PasswordViewModel

    var body: some View {
        ZStack {
            Colors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    StepHeader(
                        step: .localized(.passwordStep),
                        title: .localized(.passwordTitle),
                        subtitle: .localized(.passwordSubtitle)
                    )
                    .padding(.top, 48)

                    InputField(
                        placeholder: .localized(.passwordPlaceholder),
                        text: $viewModel.password,
                        style: .secure
                    )
                    .padding(.top, 36)

                    passwordRules
                        .padding(.top, 24)
                }
                .padding(.horizontal, 32)

                Spacer()

                PrimaryButton(title: .localized(.passwordConfirm), isDisabled: !viewModel.isValid || viewModel.isLoading, action: viewModel.confirmTapped)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
            }

            if viewModel.isLoading {
                LoadingHUD()
            }

            if let error = viewModel.error {
                ErrorAlert(
                    title: .localized(.errorTitlePasswordFailed),
                    message: error.localizedDescription,
                    onDismiss: { viewModel.error = nil }
                )
            }
        }
        .navigationDestination(isPresented: $viewModel.navigateToResult) {
            ResultView(viewModel: {
                let vm = ResultViewModel()
                vm.onDone = viewModel.onDone
                return vm
            }())
        }
        .navigationBackDisabled()
    }

    private var passwordRules: some View {
        VStack(alignment: .leading, spacing: 12) {
            PasswordRuleView(met: viewModel.hasMinLength, label: .localized(.passwordRuleLength))
            PasswordRuleView(met: viewModel.hasUppercase, label: .localized(.passwordRuleUppercase))
            PasswordRuleView(met: viewModel.hasNumberOrSymbol, label: .localized(.passwordRuleSymbol))
        }
    }
}

#Preview {
    PasswordView(viewModel: PasswordViewModel())
}
