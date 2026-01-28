import SwiftUI

struct RecordBeforeView: View {

    let emotion: Emotion
    let onFinish: () -> Void

    @State private var draft = RecordDraft()

    var body: some View {
        NavigationStack {
            Form {
                Section("Antes del impulso") {

                    TextField("Disparadores", text: $draft.triggers)
                    TextField("Señales corporales", text: $draft.bodySignals)
                    TextField("Emoción dominante", text: $draft.dominantEmotion)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Intensidad del impulso: \(draft.impulseIntensity)")
                        Slider(
                            value: Binding(
                                get: { Double(draft.impulseIntensity) },
                                set: { draft.impulseIntensity = Int($0) }
                            ),
                            in: 0...10,
                            step: 1
                        )
                    }

                    TextField("Impulso principal", text: $draft.impulseType)
                }
            }
            .navigationTitle("Antes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Siguiente") {
                        RecordAfterView(
                            emotion: emotion,
                            onFinish: onFinish,
                            draft: draft
                        )
                    }
                }
            }
        }
    }
}
