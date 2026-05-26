import SwiftUI

struct ResultView: View {
    @Bindable var viewModel: ResultViewModel

    var body: some View {
        ZStack {
            Colors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    StepHeader(
                        step: .localized(.resultStep),
                        title: .localized(.resultTitle),
                        subtitle: .localized(.resultSubtitle)
                    )
                    .padding(.top, 48)
                }
                .padding(.horizontal, 32)

                Spacer()

                PrimaryButton(title: .localized(.resultDone), action: viewModel.doneTapped)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
            }
        }
        .navigationBackDisabled()
    }
}

#Preview {
    ResultView(viewModel: ResultViewModel())
}
