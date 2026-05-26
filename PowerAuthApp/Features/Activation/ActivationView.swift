import SwiftUI

struct ActivationView: View {
    @Bindable var viewModel: ActivationViewModel

    var body: some View {
        ZStack {
            Colors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    StepHeader(
                        step: .localized(.activationStep),
                        title: .localized(.activationTitle),
                        subtitle: .localized(.activationSubtitle)
                    )
                    .padding(.top, 48)

                    InputField(
                        placeholder: "",
                        text: $viewModel.code,
                        style: .secure
                    )
                    .padding(.top, 40)
                }
                .padding(.horizontal, 32)

                Spacer()

                PrimaryButton(
                    title: .localized(.activationConfirm),
                    isDisabled: viewModel.code.isEmpty || viewModel.isLoading,
                    action: viewModel.confirmTapped
                )
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
            }

            if viewModel.isLoading {
                LoadingHUD()
            }

            if let error = viewModel.error {
                ErrorAlert(
                    title: .localized(.errorTitleActivationFailed),
                    message: error.localizedDescription,
                    onDismiss: { viewModel.error = nil }
                )
            }
        }
        .navigationDestination(isPresented: $viewModel.navigateToPassword) {
            PasswordView(viewModel: {
                let vm = PasswordViewModel()
                vm.onDone = viewModel.onDone
                return vm
            }())
        }
        .navigationBackDisabled()
    }
}

#Preview {
    NavigationStack {
        ActivationView(viewModel: ActivationViewModel())
    }
}
