import SwiftUI
import SwiftData

struct EmotionDetailView: View {

    let emotion: Emotion
    @State private var showAdd = false

    var body: some View {
        VStack(spacing: 28) {

            Spacer()

            Text(emotion.name)
                .font(.largeTitle.bold())
                .foregroundColor(emotion.color)

            VStack(spacing: 16) {

                NavigationLink {
                    HistoryView(emotion: emotion)
                } label: {
                    emotionButton(title: "Historial")
                }

                Button {
                    // Aquí luego meteremos la gráfica
                } label: {
                    emotionButton(title: "Evolución")
                }

                Button {
                    showAdd = true
                } label: {
                    emotionButton(
                        title: "Añadir registro",
                        emphasized: true
                    )
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .navigationTitle(emotion.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showAdd) {
            NavigationStack {
                SelectSecondaryEmotionView(
                    primaryEmotion: nil,
                    fixedEmotion: emotion,
                    onComplete: { showAdd = false }
                )
            }
        }
        .kontrolEmotionBackground(emotion.color)
    }

    // MARK: - Botón reutilizable
    private func emotionButton(
        title: String,
        emphasized: Bool = false
    ) -> some View {
        Text(title)
            .font(emphasized ? .headline.bold() : .headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                emotion.color.opacity(emphasized ? 1 : 0.85)
            )
            .cornerRadius(18)
    }
}
