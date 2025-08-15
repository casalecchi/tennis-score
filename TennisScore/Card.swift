import SwiftUI

struct CardChrome: ViewModifier {
    var maxWidth: CGFloat = 400
    var maxHeight: CGFloat? = 200
    var cornerRadius: CGFloat = 16

    @Environment(\.colorScheme) private var scheme

    func body(content: Content) -> some View {
        let isDark = (scheme == .dark)
        let mainShadowOpacity = isDark ? 0.22 : 0.12
        let nearShadowOpacity = isDark ? 0.10 : 0.06

        content
            .padding()
            .frame(maxWidth: .infinity, maxHeight: maxHeight)
            .frame(maxWidth: maxWidth)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(Color(.systemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(Color.white.opacity(0.25), lineWidth: 1)
            )
            .shadow(color: .black.opacity(mainShadowOpacity), radius: 12, x: 0, y: 6)
            .shadow(color: .black.opacity(nearShadowOpacity), radius: 4, x: 0, y: 2)
    }
}

extension View {
    func cardChrome(
        maxWidth: CGFloat = 400,
        maxHeight: CGFloat? = 200,
        cornerRadius: CGFloat = 16
    ) -> some View {
        modifier(CardChrome(maxWidth: maxWidth, maxHeight: maxHeight, cornerRadius: cornerRadius))
    }
}
