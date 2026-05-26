import SwiftUI

struct LoadingHUD: View {
    var message: String? = nil

    var body: some View {
        ZStack {
            Colors.label.opacity(0.45)
                .background(.ultraThinMaterial)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                ProgressView()
                    .tint(Colors.label)
                    .scaleEffect(1.2)

                if let message {
                    Text(message)
                        .font(Fonts.body)
                        .foregroundColor(Colors.label)
                }
            }
            .padding(28)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Colors.background)
                    .shadow(color: .black.opacity(0.22), radius: 32, x: 0, y: 24)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(.black.opacity(0.04), lineWidth: 1)
                    )
            )
        }
    }
}

#Preview("Without message") {
    LoadingHUD()
}

#Preview("With message") {
    LoadingHUD(message: "Activating…")
}
