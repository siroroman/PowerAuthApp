import SwiftUI

struct AppIconView: View {
    var size: CGFloat = 240

    var body: some View {
        Canvas { context, canvasSize in
            let s = canvasSize.width

            // Background
            context.fill(
                Path(roundedRect: CGRect(origin: .zero, size: canvasSize), cornerRadius: s * 0.22),
                with: .color(Colors.label)
            )

            // H — left vertical
            context.fill(
                Path(roundedRect: CGRect(x: s * 0.28, y: s * 0.26, width: s * 0.07, height: s * 0.48), cornerRadius: s * 0.015),
                with: .color(Colors.background)
            )

            // H — right vertical
            context.fill(
                Path(roundedRect: CGRect(x: s * 0.65, y: s * 0.26, width: s * 0.07, height: s * 0.48), cornerRadius: s * 0.015),
                with: .color(Colors.background)
            )

            // H — crossbar
            context.fill(
                Path(roundedRect: CGRect(x: s * 0.28, y: s * 0.46, width: s * 0.44, height: s * 0.08), cornerRadius: s * 0.015),
                with: .color(Colors.background)
            )

            // Brand dot
            context.fill(
                Path(roundedRect: CGRect(x: s * 0.78, y: s * 0.78, width: s * 0.06, height: s * 0.06), cornerRadius: s * 0.01),
                with: .color(Colors.success)
            )
        }
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: size * 0.22))
    }
}

#Preview {
    VStack(spacing: 28) {
        AppIconView(size: 200)

        HStack(alignment: .bottom, spacing: 18) {
            ForEach([96, 64, 40], id: \.self) { s in
                VStack(spacing: 8) {
                    AppIconView(size: CGFloat(s))
                    Text("\(s)pt")
                        .font(.system(size: 10).monospaced())
                        .foregroundColor(Colors.tertiaryLabel)
                }
            }
        }
    }
    .padding(40)
    .background(Colors.background)
}
