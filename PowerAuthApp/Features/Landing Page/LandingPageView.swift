import SwiftUI

struct LandingPageView: View {
    var onStart: () -> Void = {}

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

                PrimaryButton(title: "Start activation", action: onStart)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
            }
        }
    }
}

#Preview {
    LandingPageView()
}
