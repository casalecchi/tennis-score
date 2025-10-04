import SwiftUI

struct Card<Content: View>: View {
    var maxWidth: CGFloat = 400
    var maxHeight: CGFloat? = 200
    var cornerRadius: CGFloat = 16
    @ViewBuilder var content: () -> Content

    var body: some View {
        content().cardStyle(maxWidth: maxWidth, maxHeight: maxHeight, cornerRadius: cornerRadius)
    }
}

#if DEBUG
struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card {
            VStack(alignment: .leading, spacing: 8) {
                Text("Título").font(.headline)
                Text("Descrição do card…").font(.subheadline)
            }
        }
        .padding()
    }
}
#endif
