//
//  File.swift
//  
//
//  Created by 이승준 on 1/25/24.
//

import Foundation
import SwiftUI

enum SleepQuality: String, Codable {
    typealias RawValue = String
    
    case Refreshed
    case Invigorated
    case Groggy
    case Sluggish
    case Unrested
    case Hide

    var color: Color {
        switch self {
        case .Refreshed:
                .blue
        case .Invigorated:
                .green
        case .Groggy:
                .yellow
        case .Sluggish:
                .red
        case .Unrested:
                Color("darkMode")
        case .Hide:
            Color(.systemBackground)
        }
    }
    
    var score: Int {
        switch self {
        case .Refreshed:
            4
        case .Invigorated:
            3
        case .Groggy:
            2
        case .Sluggish:
            1
        case .Unrested:
            0
        case .Hide:
            -1
        }
    }
}
