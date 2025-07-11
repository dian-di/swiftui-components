//
//  Item.swift
//  SwiftUI-components
//
//  Created by wuxue on 2025/7/11.
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
