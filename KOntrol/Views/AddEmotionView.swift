import SwiftUI
import SwiftData

struct AddEmotionView: View {

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var selectedEmotion: EmotionPreset?

    var body: some View {
        NavigationStack {
            List {
                ForEach(EmotionPreset.allCases) { preset in
                    Button {
                        selectedEmotion = preset
                    } label: {
                        HStack(spacing: 12) {
                            Circle()
                                .fill(Color(hex: preset.colorHex))
                                .frame(width: 14, height: 14)

                            Text(preset.title)

                            Spacer()

                            if selectedEmotion == preset {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Añadir emoción")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        saveEmotion()
                    }
                    .disabled(selectedEmotion == nil)
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func saveEmotion() {
        guard let preset = selectedEmotion else { return }

        let emotion = Emotion(
            name: preset.title,
            colorHex: preset.colorHex,
            iconName: preset.iconName
        )

        context.insert(emotion)
        dismiss()
    }
}
