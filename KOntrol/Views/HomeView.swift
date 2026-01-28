import SwiftUI

struct HomeView: View {

    private let messages = [
        "No tienes que decidir nada ahora.",
        "Observa primero.",
        "El impulso no es una orden.",
        "Respira. Estás aquí.",
        "Un momento consciente lo cambia todo."
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {

                Spacer()

                Text("KOntrol")
                    .font(.largeTitle.bold())
                    .foregroundColor(Color.white)

                Text("Registra. Comprende. Decide.")
                    .font(.headline)
                    .foregroundColor(Color.white)

                Text(messages.randomElement()!)
                    .font(.body)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Spacer()

                NavigationLink {
                    EmotionListView()
                } label: {
                    Text("Entrar")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("ButtonGreen"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            .padding()
            .background(Color("BackgroundBlue"))
            .ignoresSafeArea()
        }
    }
}
