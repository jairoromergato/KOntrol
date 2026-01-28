import SwiftUI

struct RecordBeforeView: View {

    let emotion: Emotion
    let onFinish: () -> Void

    @State private var draft = RecordDraft()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Form {
            Section("Antes del impulso") {

                TextField("Que te paso para esa emocion", text: $draft.triggers)
                TextField("Que señal corporal notastes", text: $draft.bodySignals)
                TextField("Que emocion predomino", text: $draft.dominantEmotion)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Que intensidad tuvo: \(draft.impulseIntensity)")
                    Slider(
                        value: Binding(
                            get: { Double(draft.impulseIntensity) },
                            set: { draft.impulseIntensity = Int($0) }
                        ),
                        in: 0...10,
                        step: 1
                    )
                }

                TextField("cual fue tu impulso principal", text: $draft.impulseType)
            }
        }
        .navigationTitle("Antes")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // ✅ Botón ATRÁS (cierra el modal y vuelve a la 3ª emoción)
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Label("Atrás", systemImage: "chevron.left")
                }
            }

            // ✅ Botón SIGUIENTE (Before -> After)
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink("Siguiente") {
                    RecordAfterView(
                        emotion: emotion,
                        onFinish: onFinish,
                        draft: draft
                    )
                }
            }
        }
        .scrollContentBackground(.hidden)
        .kontrolEmotionBackground(emotion.color)
    }
}
