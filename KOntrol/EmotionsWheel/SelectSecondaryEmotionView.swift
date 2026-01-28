import SwiftUI
import SwiftData

struct SelectSecondaryEmotionView: View {

    @Environment(\.modelContext) private var context

    let primaryEmotion: PrimaryEmotion?
    let fixedEmotion: Emotion?
    let onComplete: () -> Void

    @State private var pushedSecondary: EmotionWheel.Secondary?
    @State private var recordEmotion: Emotion?
    @State private var showRecordFlow = false

    var body: some View {
        VStack(spacing: 16) {

            Text(title)
                .font(.title.bold())
                .foregroundColor(emotionColor)

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(secondaries) { secondary in
                        Button {
                            if secondary.tertiaries.isEmpty {
                                startRecordFlow()
                            } else {
                                pushedSecondary = secondary
                            }
                        } label: {
                            HStack {
                                Text(secondary.title)
                                    .foregroundColor(.primary)

                                Spacer()

                                Image(systemName: secondary.tertiaries.isEmpty ? "arrow.right.circle.fill" : "chevron.right")
                                    .foregroundColor(emotionColor)
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

            Spacer(minLength: 0)
        }
        .padding()
        .navigationTitle("¿Cómo es?")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(item: $pushedSecondary) { secondary in
            SelectTertiaryEmotionView(
                primaryEmotion: resolvedPrimary,
                fixedEmotion: fixedEmotion,
                secondaryTitle: secondary.title,
                tertiaryOptions: secondary.tertiaries,
                onComplete: onComplete
            )
        }
        .sheet(isPresented: $showRecordFlow) {
            if let recordEmotion {
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
        .kontrolEmotionBackground(emotionColor)
    }

    // MARK: - UI helpers

    private var title: String {
        fixedEmotion?.name ?? primaryEmotion?.rawValue ?? ""
    }

    private var emotionColor: Color {
        fixedEmotion?.color ?? primaryEmotion?.themeColor ?? .blue
    }

    // MARK: - Data

    private var resolvedPrimary: PrimaryEmotion? {
        if let primaryEmotion { return primaryEmotion }
        if let fixedEmotion { return PrimaryEmotion(rawValue: fixedEmotion.name) }
        return nil
    }

    private var secondaries: [EmotionWheel.Secondary] {
        guard let resolvedPrimary else { return [] }
        return EmotionWheel.secondaries(for: resolvedPrimary)
    }

    private func startRecordFlow() {
        recordEmotion = resolvedEmotion()
        showRecordFlow = true
    }

    private func resolvedEmotion() -> Emotion {
        if let fixedEmotion { return fixedEmotion }
        guard let primaryEmotion else {
            // fallback seguro
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
