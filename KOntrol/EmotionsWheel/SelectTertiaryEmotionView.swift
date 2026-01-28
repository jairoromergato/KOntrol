import SwiftUI
import SwiftData

struct SelectTertiaryEmotionView: View {

    @Environment(\.modelContext) private var context

    let primaryEmotion: PrimaryEmotion?
    let fixedEmotion: Emotion?
    let secondaryTitle: String
    let tertiaryOptions: [String]
    let onComplete: () -> Void

    @State private var selectedTertiary: String?
    @State private var recordEmotion: Emotion?
    @State private var showRecordFlow = false

    var body: some View {
        VStack(spacing: 16) {

            Text(primaryTitle)
                .font(.title.bold())
                .foregroundColor(emotionColor)

            Text(secondaryTitle)
                .foregroundColor(.secondary)

            if tertiaryOptions.isEmpty {
                Text("No hay un matiz más concreto para esta opción. Puedes continuar.")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 12)

                Button {
                    startRecordFlow()
                } label: {
                    Text("Continuar")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(emotionColor)
                        .cornerRadius(16)
                }

            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(tertiaryOptions, id: \.self) { option in
                            Button {
                                selectedTertiary = option
                                startRecordFlow()
                            } label: {
                                HStack {
                                    Text(option)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    if selectedTertiary == option {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(emotionColor)
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(emotionColor.opacity(0.12))
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.top, 4)
                }
            }

            Spacer(minLength: 0)
        }
        .padding()
        .navigationTitle("Más concreto")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showRecordFlow) {
            if let recordEmotion {
                NavigationStack {
                    RecordBeforeView(
                        emotion: recordEmotion,
                        onFinish: {
                            showRecordFlow = false
                            self.recordEmotion = nil
                            onComplete()
                        }
                    )
                }
            }
        }
        .kontrolEmotionBackground(emotionColor)
    }

    private var primaryTitle: String {
        fixedEmotion?.name ?? primaryEmotion?.rawValue ?? ""
    }

    private var emotionColor: Color {
        fixedEmotion?.color ?? primaryEmotion?.themeColor ?? .blue
    }

    private func startRecordFlow() {
        recordEmotion = resolvedEmotion()
        showRecordFlow = true
    }

    private func resolvedEmotion() -> Emotion {
        if let fixedEmotion { return fixedEmotion }

        guard let primaryEmotion else {
            let fallback = Emotion(name: "Emoción", colorHex: "#4D96FF", iconName: "sparkles")
            context.insert(fallback)
            return fallback
        }

        let name = primaryEmotion.rawValue
        let descriptor = FetchDescriptor<Emotion>(predicate: #Predicate { $0.name == name })

        if let existing = try? context.fetch(descriptor).first {
            return existing
        }

        let newEmotion = Emotion(
            name: name,
            colorHex: primaryEmotion.colorHex,
            iconName: primaryEmotion.iconName
        )

        context.insert(newEmotion)
        return newEmotion
    }
}
