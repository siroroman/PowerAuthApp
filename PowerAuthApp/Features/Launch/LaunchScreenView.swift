import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            Colors.background.ignoresSafeArea()

            VStack(spacing: 18) {
                RoundedRectangle(cornerRadius: 3)
                    .fill(Colors.label)
                    .frame(width: 16, height: 16)

                Text("Power Auth App")
                    .font(.system(size: 15, weight: .medium))
                    .tracking(3)
                    .textCase(.uppercase)
                    .foregroundColor(Colors.label)
            }

            VStack {
                Spacer()
                Text("Secure Activation")
                    .font(.system(size: 10, weight: .medium))
                    .tracking(2)
                    .textCase(.uppercase)
                    .foregroundColor(Colors.tertiaryLabel)
                    .padding(.bottom, 56)
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
