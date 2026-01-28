//
//  Item.swift
//  KOntrol
//
//  Created by Jairo Romero gato on 28/1/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
