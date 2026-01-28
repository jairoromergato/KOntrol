import SwiftData

@MainActor
enum PersistenceController {
    
    static let container: ModelContainer = {
        do {
            let schema = Schema ([
                Emotion.self,
                ConsciousRecord.self
            ])
            
            let configuration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false
            )
            
            return try ModelContainer(
                for: schema,
                configurations: [configuration]
            )
        } catch {
            fatalError("Error creando ModelContainer: \(error)")
        }
    }()
}
