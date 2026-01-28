import SwiftUI
import SwiftData

struct EmotionListView: View {

    @Environment(\.modelContext) private var context

    @Query(sort: \Emotion.createdAt)
    private var emotions: [Emotion]

    var body: some View {
        VStack {

            if emotions.isEmpty {
                emptyState
            } else {
                emotionList
            }

        }
        .navigationTitle("Emociones")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    addTestEmotion()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(AppColors.background)
    }
   

    // MARK: - Empty state
    private var emptyState: some View {
        VStack(spacing: 16) {
            Spacer()

            Text("Aún no hay emociones")
                .font(.title3.bold())

            Text("Añade la emoción que quieres trabajar")
                .foregroundColor(.secondary)

            Button("Añadir emoción") {
                addTestEmotion()
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
    }

    // MARK: - Emotion list
    private var emotionList: some View {
        List {
            ForEach(emotions) { emotion in
                NavigationLink {
                    EmotionDetailView(emotion: emotion)
                } label: {
                    HStack {
                        Circle()
                            .fill(emotion.color)
                            .frame(width: 12, height: 12)

                        Text(emotion.name)
                            .foregroundColor(AppColors.primaryText)
                    }
                    .padding(.vertical, 6)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(AppColors.background)
    }
    
    
    // MARK: - Temporary
    private func addTestEmotion() {
        let emotion = Emotion(
            name: "Impulsividad",
            colorHex: "#FF6B6B",
            iconName: "bolt.fill"
        )
        context.insert(emotion)
    }
}
