import SwiftUI

struct KeyIconView: View {
    var size: CGFloat = 60

    var body: some View {
        Canvas { context, canvasSize in
            let s = canvasSize.width
            func sc(_ v: CGFloat) -> CGFloat { v * s / 100 }

            // Background squircle
            context.fill(
                Path(roundedRect: CGRect(origin: .zero, size: canvasSize), cornerRadius: sc(22)),
                with: .color(Colors.label)
            )

            // Rotate key glyph -45° around center
            context.concatenate(
                CGAffineTransform(translationX: s / 2, y: s / 2)
                    .rotated(by: -.pi / 4)
                    .translatedBy(x: -s / 2, y: -s / 2)
            )

            // Bow ring: cx=32 cy=50 r=14 stroke=5
            let bx = sc(32), by = sc(50), r = sc(14), sw = sc(5)
            context.fill(
                Path(ellipseIn: CGRect(x: bx - r - sw / 2, y: by - r - sw / 2,
                                       width: (r + sw / 2) * 2, height: (r + sw / 2) * 2)),
                with: .color(Colors.background)
            )
            context.fill(
                Path(ellipseIn: CGRect(x: bx - r + sw / 2, y: by - r + sw / 2,
                                       width: (r - sw / 2) * 2, height: (r - sw / 2) * 2)),
                with: .color(Colors.label)
            )

            // Shaft: x=46 y=47 w=30 h=6 rx=1.4
            context.fill(
                Path(roundedRect: CGRect(x: sc(46), y: sc(47), width: sc(30), height: sc(6)),
                     cornerRadius: sc(1.4)),
                with: .color(Colors.background)
            )

            // Tooth 1: x=64 y=53 w=5 h=8 rx=1
            context.fill(
                Path(roundedRect: CGRect(x: sc(64), y: sc(53), width: sc(5), height: sc(8)),
                     cornerRadius: sc(1)),
                with: .color(Colors.background)
            )

            // Tooth 2: x=71 y=53 w=5 h=6 rx=1
            context.fill(
                Path(roundedRect: CGRect(x: sc(71), y: sc(53), width: sc(5), height: sc(6)),
                     cornerRadius: sc(1)),
                with: .color(Colors.background)
            )
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    VStack(spacing: 28) {
        KeyIconView(size: 200)

        HStack(alignment: .bottom, spacing: 18) {
            ForEach([96, 64, 40] as [CGFloat], id: \.self) { s in
                VStack(spacing: 8) {
                    KeyIconView(size: s)
                    Text("\(Int(s))pt")
                        .font(.system(size: 10).monospaced())
                        .foregroundColor(Colors.tertiaryLabel)
                }
            }
        }
    }
    .padding(40)
    .background(Colors.background)
}
