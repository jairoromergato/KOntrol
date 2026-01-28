import Foundation
enum SecondaryEmotion {
    case calm, entusiasmo, pride
    
    case loneliness, desanimo, pena
}

extension [SecondaryEmotion] {
    init(primaryEmotion: PrimaryEmotion) {
        switch primaryEmotion {
        case .joy:
            self = [.calm, .entusiasmo]
        default:
            self = []
        }
    }
}
