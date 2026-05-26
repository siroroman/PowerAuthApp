import SwiftUI

struct ResultView: View {
    @Bindable var viewModel: ResultViewModel

    var body: some View {
        ZStack {
            Colors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    StepHeader(
                        step: "Step 3 of 3",
                        title: "Status: Active",
                        subtitle: "Activation complete. Your device is ready."
                    )
                    .padding(.top, 48)
                }
                .padding(.horizontal, 32)

                Spacer()
            }
        }
        .navigationBackDisabled()
    }
}

#Preview {
    ResultView(viewModel: ResultViewModel())
}
