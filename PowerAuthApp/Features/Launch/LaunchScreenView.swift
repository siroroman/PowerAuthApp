import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            Colors.background.ignoresSafeArea()

            KeyIconView(size: 160)

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
