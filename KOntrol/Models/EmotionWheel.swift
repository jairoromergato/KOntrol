import SwiftUI

enum PrimaryEmotion: String, CaseIterable, Identifiable, Codable {
    case joy = "Alegría"
    case sadness = "Tristeza"
    case fear = "Miedo"
    case anger = "Ira"
    case disgust = "Asco"
    case surprise = "Sorpresa"

    var id: String { rawValue }

    var themeColor: Color {
        switch self {
        case .joy: return .yellow
        case .sadness: return .blue
        case .fear: return .purple
        case .anger: return .red
        case .disgust: return .green
        case .surprise: return .orange
        }
    }

    // ✅ esto evita inventos tipo toHex()
    var colorHex: String {
        switch self {
        case .joy: return "#FFD43B"
        case .sadness: return "#4D96FF"
        case .fear: return "#845EC2"
        case .anger: return "#E03131"
        case .disgust: return "#69DB7C"
        case .surprise: return "#FFA94D"
        }
    }

    var iconName: String {
        switch self {
        case .joy: return "sun.max.fill"
        case .sadness: return "cloud.rain.fill"
        case .fear: return "eye.fill"
        case .anger: return "flame.fill"
        case .disgust: return "leaf.fill"
        case .surprise: return "sparkles"
        }
    }
}

// MARK: - Rueda emocional (anillos 2 y 3)

extension PrimaryEmotion {

    // Segundo anillo
    static func secondaryOptions(for primary: PrimaryEmotion) -> [String] {
        switch primary {
        case .joy:
            return ["Calma", "Entusiasmo", "Orgullo"]
        case .sadness:
            return ["Soledad", "Desánimo", "Pena"]
        case .fear:
            return ["Ansiedad", "Inseguridad", "Preocupación"]
        case .anger:
            return ["Frustración", "Irritación", "Rabia"]
        case .disgust:
            return ["Rechazo", "Desprecio", "Asco"]
        case .surprise:
            return ["Impacto", "Confusión", "Asombro"]
        }
    }

    // Tercer anillo
    static func tertiaryOptions(primary: PrimaryEmotion, secondary: String) -> [String] {
        switch (primary, secondary) {

        case (.anger, "Frustración"):
            return ["Bloqueo", "Impotencia", "Cansancio"]

        case (.fear, "Ansiedad"):
            return ["Anticipación", "Hipervigilancia", "Miedo difuso"]

        case (.sadness, "Soledad"):
            return ["Vacío", "Desconexión", "Abandono"]

        case (.joy, "Entusiasmo"):
            return ["Energía", "Motivación", "Ilusión"]

        default:
            return []
        }
    }
}

