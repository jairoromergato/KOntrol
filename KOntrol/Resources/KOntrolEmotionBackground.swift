
import SwiftUI

extension View {
    /// Fondo OPACO con tinte de emoción (no deja que se cuele el azul de atrás)
    func kontrolEmotionBackground(_ color: Color) -> some View {
        self.background {
            ZStack {
                Color.white               // base opaca
                color.opacity(0.22)       // tinte de la emoción
            }
            .ignoresSafeArea()
        }
    }
}
