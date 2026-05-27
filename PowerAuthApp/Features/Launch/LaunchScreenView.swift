import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            Colors.background.ignoresSafeArea()

            Image("AppIconImage")
                .resizable()
                .frame(width: 160, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 36, style: .continuous))

            VStack {
                Spacer()
                Text(.launchTagline)
                    .font(.system(size: 10, weight: .medium))
                    .tracking(2)
                    .textCase(.uppercase)
                    .foregroundStyle(Colors.tertiaryLabel)
                    .padding(.bottom, 56)
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
