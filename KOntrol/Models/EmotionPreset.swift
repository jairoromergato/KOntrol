import SwiftUI

enum EmotionPreset: String, CaseIterable, Identifiable {

    case impulsividad
    case ansiedad
    case ira
    case tristeza
    case miedo
    case culpa
    case vergüenza
    case rechazo
    case alegria
    case frustración
    case soledad

    var id: String { rawValue }

    var title: String {
        rawValue.capitalized
    }

    var colorHex: String {
        switch self {
        case .impulsividad: return "#FF6B6B"
        case .ansiedad:     return "#FFA94D"
        case .ira:          return "#E03131"
        case .tristeza:     return "#4D96FF"
        case .miedo:        return "#845EC2"
        case .culpa:        return "#868E96"
        case .vergüenza:    return "#C77DFF"
        case .rechazo:        return "#69DB7C"
        case .alegria:      return "#FFD43B"
        case .frustración:   return "#FF9D9D"
        case .soledad:      return "#FFC300"
        }
    }

    var iconName: String {
        switch self {
        case .impulsividad: return "bolt.fill"
        case .ansiedad:     return "waveform.path.ecg"
        case .ira:          return "flame.fill"
        case .tristeza:     return "cloud.rain.fill"
        case .miedo:        return "eye.fill"
        case .culpa:        return "exclamationmark.triangle.fill"
        case .vergüenza:    return "face.smiling.inverse"
        case .rechazo:        return "leaf.fill"
        case .alegria:      return "sun.max.fill"
        case .frustración:   return "exclamationmark.circlepath.circle"
        case .soledad:      return "moon.stars.fill"
        }
    }
}
