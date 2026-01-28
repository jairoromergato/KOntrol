import SwiftUI

struct RecordAfterView: View {

    let emotion: Emotion
    let onFinish: () -> Void

    @State var draft: RecordDraft

    var body: some View {
        Form {
            Section("Después de la conducta") {

                TextField("Conducta realizada", text: $draft.actionTaken)
                TextField("Emoción posterior", text: $draft.emotionAfter)
                TextField("Pensamientos posteriores", text: $draft.thoughtsAfter)
            }
        }
        .navigationTitle("Después")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink("Siguiente") {
                    RecordImproveView(
                        emotion: emotion,
                        onFinish: onFinish,
                        draft: draft
                    )
                }
            }
        }
    }
}
