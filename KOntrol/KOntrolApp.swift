import SwiftData
import SwiftUI

@main
struct KOntrolApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .background(AppColors.background)
                .ignoresSafeArea()
        }
        .modelContainer(PersistenceController.container)
    }
}
