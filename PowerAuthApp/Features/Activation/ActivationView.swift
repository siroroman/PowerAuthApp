import SwiftUI

struct ActivationView: View {
    var onBack: () -> Void = {}
    var onConfirm: () -> Void = {}

    @State private var code = ""

    var body: some View {
        ZStack {
            Colors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    StepHeader(
                        step: "Step 1 of 3",
                        title: "Enter activation\ncode",
                        subtitle: "Format: XXXX – XXXX – XXXX"
                    )
                    .padding(.top, 48)

                    InputField(
                        placeholder: "XXXX – XXXX – XXXX",
                        text: $code,
                        style: .code
                    )
                    .padding(.top, 40)
                }
                .padding(.horizontal, 32)

                Spacer()

                PrimaryButton(title: "Confirm", action: onConfirm)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
            }
        }
    }
}

#Preview {
    ActivationView()
}
