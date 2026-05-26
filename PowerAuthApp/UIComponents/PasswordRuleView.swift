import SwiftUI

struct PasswordRuleView: View {
    let met: Bool
    let label: String

    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(met ? Colors.label : Color.clear)
                    .frame(width: 16, height: 16)
                if met {
                    Image(systemName: "checkmark")
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(.white)
                } else {
                    Circle()
                        .strokeBorder(Colors.separator, lineWidth: 1)
                        .frame(width: 16, height: 16)
                }
            }
            Text(label)
                .font(.system(size: 13))
                .foregroundColor(met ? Colors.label : Colors.secondaryLabel)
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 12) {
        PasswordRuleView(met: true, label: "At least 8 characters")
        PasswordRuleView(met: true, label: "One uppercase letter")
        PasswordRuleView(met: false, label: "One number or symbol")
    }
    .padding(32)
    .background(Colors.background)
}
