import SwiftUI
import SwiftData

struct EmotionListView: View {

    @Environment(\.modelContext) private var context
    @Query(sort: \Emotion.createdAt) private var emotions: [Emotion]

    @State private var showAddEmotion = false

    var body: some View {
        Group {
            if emotions.isEmpty {
                emptyState
            } else {
                emotionButtons
            }
        }
        .navigationTitle("Emociones")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddEmotion = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddEmotion) {
            SelectPrimaryEmotionView {
                showAddEmotion = false
            }
        }
        .kontrolScreen()
    }

    // MARK: - Empty state
    private var emptyState: some View {
        VStack(spacing: 16) {
            Spacer()

            Text("Aún no hay emociones")
                .font(.title3.bold())
                .foregroundColor(AppColors.primaryText)

            Text("Añade la emoción que quieres trabajar")
                .foregroundColor(AppColors.secondaryText)

            Button("Añadir emoción") {
                showAddEmotion = true
            }
            .kontrolPrimaryButton()

            Spacer()
        }
        .padding()
    }

    // MARK: - Emotion buttons
    private var emotionButtons: some View {
        ScrollView {
            VStack(spacing: 14) {
                ForEach(emotions) { emotion in
                    NavigationLink {
                        EmotionDetailView(emotion: emotion)
                    } label: {
                        Text(emotion.name)
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(emotion.color)
                            .cornerRadius(18)
                    }
                    .buttonStyle(.plain) // 🔑 quita flechas y estilos de lista
                }
            }
            .padding()
        }
    }
}
