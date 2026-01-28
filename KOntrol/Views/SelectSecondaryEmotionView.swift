import SwiftUI
import SwiftData

struct SelectSecondaryEmotionView: View {

    @Environment(\.modelContext) private var context

    let primaryEmotion: PrimaryEmotion?
    let fixedEmotion: Emotion?
    let onComplete: () -> Void

    @State private var selectedSecondary: String?
    @State private var showRecordFlow = false

    var body: some View {
        VStack(spacing: 24) {

            Text(title)
                .font(.title.bold())
                .foregroundColor(emotionColor)

            VStack(spacing: 12) {
                ForEach(secondaryOptions, id: \.self) { option in
                    Button {
                        selectedSecondary = option
                    } label: {
                        HStack {
                            Text(option)
                                .foregroundColor(.primary)
                            Spacer()
                            if selectedSecondary == option {
                                Image(systemName: "checkmark")
                                    .foregroundColor(emotionColor)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(emotionColor.opacity(0.15))
                        )
                    }
                }
            }

            Spacer()

            Button {
                showRecordFlow = true
            } label: {
                Text("Continuar")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(emotionColor)
                    .cornerRadius(16)
            }
            .disabled(selectedSecondary == nil)
            .opacity(selectedSecondary == nil ? 0.5 : 1)
        }
        .padding()
        .navigationTitle("¿Cómo es?")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showRecordFlow) {
            RecordBeforeView(
                emotion: resolvedEmotion(),
                onFinish: {
                    showRecordFlow = false
                    onComplete() // ✅ cierra el flujo y vuelve atrás
                }
            )
        }
    }

    // MARK: - Helpers

    private var title: String {
        fixedEmotion?.name ?? primaryEmotion?.rawValue ?? ""
    }

    private var emotionColor: Color {
        fixedEmotion?.color ?? primaryEmotion?.themeColor ?? .blue
    }

    private var secondaryOptions: [String] {
        if let primaryEmotion {
            return PrimaryEmotion.secondaryOptions(for: primaryEmotion)
        }

        if let fixedEmotion,
           let primary = PrimaryEmotion(rawValue: fixedEmotion.name) {
            return PrimaryEmotion.secondaryOptions(for: primary)
        }

        return []
    }

    private func resolvedEmotion() -> Emotion {
        if let fixedEmotion {
            return fixedEmotion
        }

        let name = primaryEmotion!.rawValue

        let descriptor = FetchDescriptor<Emotion>(
            predicate: #Predicate { $0.name == name }
        )

        if let existing = try? context.fetch(descriptor).first {
            return existing
        }

        let newEmotion = Emotion(
            name: name,
            colorHex: primaryEmotion!.colorHex,
            iconName: primaryEmotion!.iconName
        )

        context.insert(newEmotion)
        return newEmotion
    }
}
