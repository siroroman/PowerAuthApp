import SwiftUI

struct LandingPageView: View {
    @Bindable var viewModel: LandingPageViewModel

    var body: some View {
        ZStack {
            Colors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: 0) {
                    Text("Activate your\ndevice.")
                        .font(Fonts.hero)
                        .tracking(-0.6)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Colors.label)

                    Text("You'll need the activation code we sent to your registered email — takes about a minute.")
                        .font(.system(size: 15))
                        .lineSpacing(8)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Colors.secondaryLabel)
                        .padding(.top, 18)
                        .padding(.horizontal, 16)
                }

                Spacer()

                PrimaryButton(title: "Start activation", action: viewModel.startTapped)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
            }

            if viewModel.isLoading {
                LoadingHUD()
            }

            if let error = viewModel.error {
                ErrorAlert(
                    title: "Setup failed",
                    message: error.localizedDescription,
                    onPrimary: { viewModel.error = nil },
                    onDismiss: { viewModel.error = nil }
                )
            }
        }
        .navigationDestination(isPresented: $viewModel.navigateToActivation) {
            ActivationView(viewModel: ActivationViewModel())
        }
    }
}

#Preview {
    NavigationStack {
        LandingPageView(viewModel: LandingPageViewModel())
    }
}
