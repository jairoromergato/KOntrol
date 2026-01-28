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
                emotionList
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
        .tint(AppColors.primaryButton)
        .background(Color("BackgroundBlue").ignoresSafeArea())
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

    // MARK: - Emotion list (swipe to delete)
    private var emotionList: some View {
        List {
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
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 7, leading: 16, bottom: 7, trailing: 16))
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        deleteEmotion(emotion)
                    } label: {
                        Label("Borrar", systemImage: "trash")
                    }
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }

    private func deleteEmotion(_ emotion: Emotion) {
        context.delete(emotion)
        try? context.save()
    }
}
