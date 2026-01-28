import SwiftUI

struct RecordDetailView: View {

    let record: ConsciousRecord

    private var bg: Color {
        (record.emotion?.color ?? Color("BackgroundBlue")).opacity(0.12)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                Text(record.date, style: .date)
                    .font(.caption)

                Group {
                    Text("Antes del impulso")
                        .font(.headline)

                    Text("Disparadores: \(record.triggers)")
                    Text("Señales corporales: \(record.bodySignals)")
                    Text("Emoción dominante: \(record.dominantEmotion)")
                    Text("Intensidad: \(record.impulseIntensity)")
                    Text("Impulso: \(record.impulseType)")
                }

                if let action = record.actionTaken {
                    Divider()

                    Text("Después")
                        .font(.headline)

                    Text("Conducta: \(action)")
                    Text("Emoción posterior: \(record.emotionAfter ?? "")")
                    Text("Pensamientos: \(record.thoughtsAfter ?? "")")
                }

                Divider()

                Group {
                    Text("Comprensión")
                        .font(.headline)

                    Text("Alternativa útil: \(record.helpfulAlternative)")
                    Text("Próxima vez: \(record.nextTimeDecision)")
                }
            }
            .padding()
        }
        .navigationTitle("Registro")
        .kontrolEmotionBackground(record.emotion?.color ?? .blue)
    }
}
