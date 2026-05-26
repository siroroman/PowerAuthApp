import SwiftUI

struct ResultView: View {
    var onBack: () -> Void = {}

    var body: some View {
        ZStack {
            Colors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                navigationBar

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
}

#Preview {
    ResultView()
}
