//
//  CardStyle.swift
//  TennisScore
//
//  Created by Felipe Casalecchi on 21/09/25.
//

import SwiftUI

struct CardStyle: ViewModifier {
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
    func cardStyle(
        maxWidth: CGFloat = 400,
        maxHeight: CGFloat? = 200,
        cornerRadius: CGFloat = 16
    ) -> some View {
        modifier(CardStyle(maxWidth: maxWidth, maxHeight: maxHeight, cornerRadius: cornerRadius))
    }
}

//#if DEBUG
//struct CardStyle_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            Text("Hello").cardStyle()
//            Text("Custom").cardStyle(maxWidth: 300, maxHeight: nil, cornerRadius: 24)
//        }
//        .padding()
//        .background(Color.gray.opacity(0.1))
//    }
//}
//#endif
