import SwiftUI

struct ActivationView: View {
    @Bindable var viewModel: ActivationViewModel

    var body: some View {
        ZStack {
            Colors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    StepHeader(
                        step: "Step 1 of 3",
                        title: "Enter activation\ncode",
                        subtitle: "Format: XXXX–XXXX-XXXX-XXXX"
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
                    title: "Confirm",
                    isDisabled: viewModel.code.isEmpty,
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
                    title: "Activation failed",
                    message: error.localizedDescription,
                    onDismiss: { viewModel.error = nil }
                )
            }
        }
        .navigationDestination(isPresented: $viewModel.navigateToPassword) {
            PasswordView(viewModel: PasswordViewModel())
        }
        .navigationBackDisabled()
    }
}

#Preview {
    NavigationStack {
        ActivationView(viewModel: ActivationViewModel())
    }
}
