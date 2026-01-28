import Foundation
import SwiftData

@Model
final class ConsciousRecord {
    
    var id: UUID
    var date: Date
    
    // MARK: - Antes del impulso
    var triggers: String
    var bodySignals: String
    var dominantEmotion: String
    var impulseIntensity: Int
    var impulseType: String
    
    // MARK: - Después de la conducta (opcional)
    var actionTaken: String?
    var emotionAfter: String?
    var thoughtsAfter: String?
    
    // MARK: - Integración
    var helpfulAlternative: String
    var nextTimeDecision: String
    
    // Relación inversa
    var emotion: Emotion?
    
    init(
        triggers: String,
        bodySignals: String,
        dominantEmotion: String,
        impulseIntensity: Int,
        impulseType: String,
        actionTaken: String? = nil,
        emotionAfter: String? = nil,
        thoughtsAfter: String? = nil,
        helpfulAlternative: String,
        nextTimeDecision: String,
        emotion: Emotion? = nil
    ) {
        self.id = UUID()
        self.date = Date()
        self.triggers = triggers
        self.bodySignals = bodySignals
        self.dominantEmotion = dominantEmotion
        self.impulseIntensity = impulseIntensity
        self.impulseType = impulseType
        self.actionTaken = actionTaken
        self.emotionAfter = emotionAfter
        self.thoughtsAfter = thoughtsAfter
        self.helpfulAlternative = helpfulAlternative
        self.nextTimeDecision = nextTimeDecision
        self.emotion = emotion
    }
}
