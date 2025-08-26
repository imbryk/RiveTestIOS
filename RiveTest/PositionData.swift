//
//  PositionData.swift
//  RiveTest
//
//  Created by Leszek.Mzyk on 26/08/2025.
//

import Foundation
import SwiftData

@Model
final class PositionData {
    var x: Float
    var y: Float
    var timestamp: Date
    
    init(x: Float, y: Float) {
        self.x = x
        self.y = y
        self.timestamp = Date()
    }
}
