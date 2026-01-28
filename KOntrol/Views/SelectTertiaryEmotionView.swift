import SwiftUI

struct SelectTertiaryEmotionView: View {

    let secondaryEmotion: String
    let fixedEmotion: Emotion
    let onComplete: () -> Void

    @State private var selectedTertiary: String?
    @State private var showRecordFlow = false

    private var primaryEmotion: PrimaryEmotion? {
        PrimaryEmotion.allCases.first { $0.rawValue == fixedEmotion.name }
    }

    private var options: [String] {
        guard let primaryEmotion else { return [] }
        return PrimaryEmotion.tertiaryOptions(primary: primaryEmotion, secondary: secondaryEmotion)
    }

    private var canContinue: Bool {
        // ✅ si no hay opciones, la 3ª rueda es opcional => se puede continuar
        options.isEmpty || selectedTertiary != nil
    }

    var body: some View {
        VStack(spacing: 24) {

            Text(fixedEmotion.name)
                .font(.title.bold())
                .foregroundColor(fixedEmotion.color)

            Text(secondaryEmotion)
                .foregroundColor(.secondary)

            if options.isEmpty {
                Text("No hay un matiz más concreto para esta opción. Puedes continuar.")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 12)
            } else {
                VStack(spacing: 12) {
                    ForEach(options, id: \.self) { option in
                        Button {
                            selectedTertiary = option
                        } label: {
                            HStack {
                                Text(option)
                                Spacer()
                                if selectedTertiary == option {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(fixedEmotion.color)
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.15))
                            .cornerRadius(12)
                        }
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
                    .background(fixedEmotion.color)
                    .cornerRadius(16)
            }
            .disabled(!canContinue)
            .opacity(canContinue ? 1 : 0.5)
        }
        .padding()
        .navigationTitle("Más concreto")
        .sheet(isPresented: $showRecordFlow) {
            RecordBeforeView(
                emotion: fixedEmotion,
                onFinish: {
                    showRecordFlow = false
                    onComplete() // ✅ CIERRA LA RUEDA
                }
            )
        }
    }
}
