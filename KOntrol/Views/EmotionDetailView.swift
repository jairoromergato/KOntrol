import SwiftUI

struct EmotionDetailView: View {

    let emotion: Emotion
    @State private var showRecordFlow = false

    var body: some View {
        VStack(spacing: 24) {

            Text(emotion.name)
                .font(.largeTitle.bold())

            Spacer()

            Button {
                showRecordFlow = true
            } label: {
                Text("Añadir registro")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(emotion.color.opacity(0.85))
                    .foregroundColor(.white)
                    .cornerRadius(14)
            }
            .padding(.horizontal)
        }
        .padding()
        .navigationTitle(emotion.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(AppColors.background)
        .sheet(isPresented: $showRecordFlow) {
            RecordBeforeView(emotion: emotion)
        }
    }
}
