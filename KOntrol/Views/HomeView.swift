import SwiftUI

struct HomeView: View {

    private let messages = [
        "No tienes que decidir nada ahora.",
        "Observa primero.",
        "El impulso no es una orden.",
        "Respira. Estás aquí.",
        "Un momento consciente lo cambia todo.",
        "No estás tarde. Estás a tiempo.",
        "Puedes pausar sin rendirte.",
        "Entre estímulo y respuesta, hay un espacio.",
        "Tu cuerpo te está hablando.",
        "No eres tu impulso."
    ]

    @State private var selectedMessage: String = ""
    @State private var secondsRemaining: Int = 5
    @State private var shouldNavigate = false
    @State private var countdownTask: Task<Void, Never>?

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundBlue").ignoresSafeArea()

                VStack(spacing: 24) {
                    Spacer()

                    Text("KOntrol")
                        .font(.largeTitle.bold())
                        .foregroundColor(AppColors.primaryText)

                    Text("Registra. Comprende. Decide.")
                        .font(.headline)
                        .foregroundColor(AppColors.secondaryText)

                    Text(selectedMessage)
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Spacer()
                }
                .padding()
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    skip()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "forward.fill")
                        Text("Saltar \(secondsRemaining)s")
                            .monospacedDigit()
                    }
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 14)
                    .background(.black.opacity(0.25))
                    .clipShape(Capsule())
                }
                .padding(.top, 14)
                .padding(.trailing, 16)
                .opacity(shouldNavigate ? 0 : 1)
                .animation(.easeInOut(duration: 0.2), value: shouldNavigate)
            }
            .navigationDestination(isPresented: $shouldNavigate) {
                EmotionListView()
            }
            .toolbar(.hidden, for: .navigationBar) // home limpia, sin navbar
            .onAppear {
                if selectedMessage.isEmpty {
                    selectedMessage = messages.randomElement() ?? "Un momento consciente lo cambia todo."
                }
                startCountdown()
            }
            .onDisappear {
                countdownTask?.cancel()
                countdownTask = nil
            }
        }
    }

    private func startCountdown() {
        countdownTask?.cancel()
        secondsRemaining = 5

        countdownTask = Task {
            // 5...1 (5 segundos)
            for s in stride(from: 5, through: 1, by: -1) {
                if Task.isCancelled { return }
                await MainActor.run { secondsRemaining = s }
                try? await Task.sleep(for: .seconds(1))
            }

            if Task.isCancelled { return }
            await MainActor.run { shouldNavigate = true }
        }
    }

    private func skip() {
        countdownTask?.cancel()
        shouldNavigate = true
    }
}
