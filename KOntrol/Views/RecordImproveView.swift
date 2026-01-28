import SwiftUI
import SwiftData

struct RecordImproveView: View {

    let emotion: Emotion
    @State var draft: RecordDraft

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Form {
            Section("Comprensión") {
                TextField("Qué habría ayudado", text: $draft.helpfulAlternative)
                TextField("Qué haré distinto la próxima vez", text: $draft.nextTimeDecision)
            }

            Button("Guardar registro") {
                saveRecord()
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Comprender")
    }

    private func saveRecord() {
        let record = ConsciousRecord(
            triggers: draft.triggers,
            bodySignals: draft.bodySignals,
            dominantEmotion: draft.dominantEmotion,
            impulseIntensity: draft.impulseIntensity,
            impulseType: draft.impulseType,
            actionTaken: draft.actionTaken.isEmpty ? nil : draft.actionTaken,
            emotionAfter: draft.emotionAfter.isEmpty ? nil : draft.emotionAfter,
            thoughtsAfter: draft.thoughtsAfter.isEmpty ? nil : draft.thoughtsAfter,
            helpfulAlternative: draft.helpfulAlternative,
            nextTimeDecision: draft.nextTimeDecision,
            emotion: emotion
        )

        context.insert(record)
        dismiss()
    }
}
