import SwiftUI

enum PrimaryEmotion: String, CaseIterable, Identifiable, Codable {
    case joy = "Felicidad"
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
        case .joy: return "felicidad"
        case .sadness: return "tristeza"
        case .fear: return "miedo"
        case .anger: return "ira"
        case .disgust: return "asco"
        case .surprise: return "sorpresa"
        }
    }
}
