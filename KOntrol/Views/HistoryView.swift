import SwiftUI
import SwiftData

struct HistoryView: View {
    
    let emotion: Emotion
    
    @Query(sort: \ConsciousRecord.date, order: .reverse)
    private var allRecords: [ConsciousRecord]
    
    private var records: [ConsciousRecord] {
        allRecords.filter { $0.emotion == emotion }
    }
    
    var body: some View {
        List {
            if records.isEmpty {
                Text("Aún no hay registros")
            } else {
                ForEach(records) { record in
                    NavigationLink {
                        RecordDetailView(record: record)
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(record.date, style: .date)
                                .font(.caption)
                            
                            Text("Intensidad: \(record.impulseIntensity)")
                                .font(.headline)
                        }
                    }
                }
            }
        }
        .navigationTitle("Historial")
        // ✅ fondo por emoción
        .scrollContentBackground(.hidden)
        .kontrolEmotionBackground(emotion.color)
    }
}
  

