import SwiftUI

struct LandingPageView: View {
    @Bindable var viewModel: LandingPageViewModel

    var body: some View {
        ZStack {
            Colors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: 0) {
                    Text(.landingTitle)
                        .font(Fonts.hero)
                        .tracking(-0.6)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Colors.label)

                    Text(.landingSubtitle)
                        .font(.system(size: 15))
                        .lineSpacing(8)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Colors.secondaryLabel)
                        .padding(.top, 18)
                        .padding(.horizontal, 16)
                }

                Spacer()

                PrimaryButton(title: .localized(.landingCTA), action: viewModel.startTapped)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
            }

            if viewModel.isLoading {
                LoadingHUD()
            }

            if let error = viewModel.error {
                ErrorAlert(
                    title: .localized(.errorTitleSetupFailed),
                    message: error.localizedDescription,
                    onDismiss: { viewModel.error = nil }
                )
            }
        }
        .navigationDestination(isPresented: $viewModel.navigateToActivation) {
            ActivationView(viewModel: {
                let vm = ActivationViewModel()
                vm.onDone = { viewModel.navigateToActivation = false }
                return vm
            }())
        }
        .navigationDestination(isPresented: $viewModel.navigateToResult) {
            ResultView(viewModel: {
                let vm = ResultViewModel()
                vm.onDone = { viewModel.navigateToResult = false }
                return vm
            }())
        }
    }
}

#Preview {
    NavigationStack {
        LandingPageView(viewModel: LandingPageViewModel())
    }
}
