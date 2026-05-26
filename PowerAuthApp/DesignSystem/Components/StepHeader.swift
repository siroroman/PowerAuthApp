import SwiftUI

struct StepHeader: View {
    let step: String
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(step.uppercased())
                .font(.system(size: 11, weight: .medium))
                .tracking(1.4)
                .foregroundColor(Colors.tertiaryLabel)
                .padding(.bottom, 14)

            Text(title)
                .font(.system(size: 28, weight: .medium))
                .tracking(-0.4)
                .lineSpacing(4)
                .foregroundColor(Colors.label)

            Text(subtitle)
                .font(.system(size: 14.5))
                .lineSpacing(8)
                .foregroundColor(Colors.secondaryLabel)
                .padding(.top, 14)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    VStack(spacing: 40) {
        StepHeader(
            step: "Step 1 of 3",
            title: "Enter activation\ncode",
            subtitle: "Format: XXXX – XXXX – XXXX"
        )
        StepHeader(
            step: "Step 2 of 3",
            title: "Set a password",
            subtitle: "You'll use this to sign in from now on."
        )
        StepHeader(
            step: "Step 3 of 3",
            title: "Status: Active",
            subtitle: "Activation complete. Your device is ready."
        )
    }
    .padding(32)
    .background(Colors.background)
}
