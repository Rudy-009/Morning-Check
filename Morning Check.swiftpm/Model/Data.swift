
import Foundation
import SwiftUI

struct Sleep : Identifiable, Codable {
    var id = UUID()
    var sleepDate: Date
    var wakeUpDate: Date
    var sleepQuality: Int
    var distruptors: Set<SleepDisruptors>
    var awakes: Int
    
    var sleepDuration: Double {
        return wakeUpDate.timeIntervalSince(sleepDate)
    }
    
    var sleepDurationHours: Int {
        return Int(sleepDuration/3600)
    }
    
    var sleepDurationMinutes: Int {
        return (Int(sleepDuration)%3600)/60
    }
    
    var isMoreThanEightHours: Bool {
        return sleepDuration >= 3600*8 ? true : false
    }
    
    var markWakeUp: Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: wakeUpDate)
        return Calendar.current.date(from: DateComponents( hour: dateComponents.hour, minute: dateComponents.minute)) ?? Date()
    }
    
    var markSleep: Date {
        return Date(timeInterval: -sleepDuration, since: markWakeUp)
    }
    
    var todayAt7PM: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        
        // Set the time components to 7:00 PM
        components.hour = 19
        components.minute = 0
        components.second = 0
        
        if let today7PM = calendar.date(from: components) {
            return today7PM
        } else {
            // Default to the current date if there's an issue
            return Date()
        }
    }
    
    
    var yesterdayAt7PM: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        
        // Set the time components to 7:00 PM
        components.hour = 19
        components.minute = 0
        components.second = 0
        
        // Subtract one day from the current date
        if let yesterday = calendar.date(byAdding: .day, value: -1, to: calendar.date(from: components)!) {
            return yesterday
        } else {
            // Default to the current date if there's an issue
            return Date()
        }
    }
    
    var emojis: String {
        if distruptors.isEmpty {
            return "Nothing"
        } else {
            var result: String = ""
            for d in distruptors {
                result += "\(distruptorEmoji(of: d)) "
            }
            return result
        }
    }
    
}

enum SleepQuality: String, Codable {
    case Refreshed
    case Invigorated
    case Groggy
    case Sluggish
    case Unrested
}

enum SleepDisruptors: String, Codable {
    case phone, light, meal, snack, alcohol, caffein, drug, protein, milk, bread, noise
    case energyDrink = "Energy Drink"
    case intenseExercise = "Intense Exercise"
    case lightExercise = "Light Exercise"
}

func distruptorEmoji (of dis: SleepDisruptors) -> String {
    switch dis {
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

func explanationDis (of dis: SleepDisruptors) -> String {
    switch dis {
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

