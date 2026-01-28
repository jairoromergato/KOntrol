import SwiftUI

struct RecordAfterView: View {

    let emotion: Emotion
    let onFinish: () -> Void

    @State var draft: RecordDraft

    var body: some View {
        Form {
            Section("Después de la conducta") {

                TextField("Que conducta/accion hicistes", text: $draft.actionTaken)
                TextField("Que sentistes despues de hacerla", text: $draft.emotionAfter)
                TextField("Que pensamientos tubistes despues", text: $draft.thoughtsAfter)
            }
        }
        .navigationTitle("Después")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink("Siguiente") {
                    RecordImproveView(
                        emotion: emotion,
                        onFinish: onFinish,
                        draft: draft
                    )
                }
            }
        }
        // ✅ fondo por emoción
        .scrollContentBackground(.hidden)
        .kontrolEmotionBackground(emotion.color)
    }
}
