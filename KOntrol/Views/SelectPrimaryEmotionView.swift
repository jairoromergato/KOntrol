import SwiftUI

struct SelectPrimaryEmotionView: View {

    @Environment(\.dismiss) private var dismiss
    let onComplete: () -> Void

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(PrimaryEmotion.allCases) { emotion in
                        NavigationLink {
                            SelectSecondaryEmotionView(
                                primaryEmotion: emotion,
                                fixedEmotion: nil,
                                onComplete: onComplete
                            )
                        } label: {
                            VStack(spacing: 12) {
                                Circle()
                                    .fill(emotion.themeColor)
                                    .frame(width: 60, height: 60)

                                Text(emotion.rawValue)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(emotion.themeColor.opacity(0.15))
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("¿Qué sientes ahora?")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
    }
}
