//
//  File 2.swift
//  
//
//  Created by 이승준 on 1/25/24.
//

import Foundation

enum SleepDisruptors: String, Codable {
    case phone, light, meal, snack, alcohol, caffein, drug, protein, milk, bread, noise
    case energyDrink = "Energy Drink"
    case intenseExercise = "Intense Exercise"
    case lightExercise = "Light Exercise"
    
    var capitalized: String {
        rawValue.capitalized
    }
    
    var emoji: String {
        switch self {
        case .phone:
            return "📱"
        case .light:
            return "💡"
        case .meal:
            return "🍕"
        case .snack:
            return "🍿"
        case .alcohol:
            return "🍺"
        case .caffein:
            return "☕️"
        case .drug:
            return "💊"
        case .protein:
            return "💪"
        case .milk:
            return "🥛"
        case .bread:
            return "🥖"
        case .energyDrink:
            return "⚡️"
        case .noise:
            return "📢"
        case .intenseExercise:
            return "🏋️"
        case .lightExercise:
            return "🚶"
        }
    }
    
    var explanation: String {
        switch self {
        case .phone:
            return "Within 1H before sleep."
        case .light, .noise:
            return "Within 1H before sleep or during sleep."
        case .meal, .drug, .milk, .bread, .snack, .protein:
            return "Within 2H before sleep."
        case .alcohol, .caffein, .energyDrink:
            return "before sleep"
        case .intenseExercise:
            return ""
        case .lightExercise:
            return ""
        }
    }
}
