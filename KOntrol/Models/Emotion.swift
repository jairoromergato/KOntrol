import Foundation
import SwiftData

@Model
final class Emotion {

    var id: UUID
    var name: String
    var colorHex: String
    var iconName: String
    var createdAt: Date
    var isActive: Bool

    @Relationship(deleteRule: .cascade)
    var records: [ConsciousRecord]

    init(
        name: String,
        colorHex: String,
        iconName: String,
        isActive: Bool = true
    ) {
        self.id = UUID()
        self.name = name
        self.colorHex = colorHex
        self.iconName = iconName
        self.createdAt = Date()
        self.isActive = isActive
        self.records = []
    }
}

import SwiftUI

extension Emotion {
    var color: Color { Color(hex: colorHex) }
}

