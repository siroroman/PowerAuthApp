import SwiftUI

struct ErrorAlert: View {
    let title: String
    let message: String
    var primaryLabel: String = String.localized(.errorActionTryAgain)
    var onPrimary: (() -> Void)? = nil
    var onDismiss: () -> Void = {}

    var body: some View {
        ZStack {
            Colors.label.opacity(0.45)
                .background(.ultraThinMaterial)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                errorGlyph
                    .padding(.bottom, 18)

                Text(title)
                    .font(.system(size: 18, weight: .medium))
                    .tracking(-0.2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Colors.label)
                    .padding(.bottom, 8)

                Text(message)
                    .font(.system(size: 14))
                    .lineSpacing(7)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Colors.secondaryLabel)
                    .padding(.bottom, 22)

                VStack(spacing: 8) {
                    if let onPrimary {
                        Button(action: onPrimary) {
                            Text(primaryLabel)
                                .font(.system(size: 15, weight: .medium))
                                .tracking(0.2)
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 12).fill(Colors.label))
                        }
                        .buttonStyle(.plain)
                    }

                    Button(action: onDismiss) {
                        Text(.errorActionClose)
                            .font(.system(size: 14))
                            .tracking(0.2)
                            .foregroundColor(Colors.secondaryLabel)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Colors.background)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(Colors.secondaryLabel, lineWidth: 1)
                                    )
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 28)
            .padding(.bottom, 16)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Colors.background)
                    .shadow(color: .black.opacity(0.22), radius: 32, x: 0, y: 24)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(.black.opacity(0.04), lineWidth: 1)
                    )
            )
            .padding(.horizontal, 32)
        }
    }

    private var errorGlyph: some View {
        ZStack {
            Circle()
                .strokeBorder(Colors.label, lineWidth: 1.5)
                .frame(width: 44, height: 44)

            VStack(spacing: 3) {
                RoundedRectangle(cornerRadius: 1)
                    .fill(Colors.label)
                    .frame(width: 2, height: 10)
                Circle()
                    .fill(Colors.label)
                    .frame(width: 2.2, height: 2.2)
            }
        }
    }
}

#Preview {
    ZStack {
        Colors.background.ignoresSafeArea()
        ErrorAlert(
            title: "Invalid activation code",
            message: "The code you entered doesn't match our records. Check the format and try again."
        )
    }
}
