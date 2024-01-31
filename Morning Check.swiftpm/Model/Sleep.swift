
import Foundation
import SwiftUI
import Charts

struct Sleep : Identifiable, Codable, Equatable {
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
    
    var idealSleepDuration: Bool {
        if 7*60*60 <= sleepDuration && sleepDuration <= 8*60*60 + 30*60 {
            return true
        } else {
            return false
        }
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
                result += "\(d.emoji) "
            }
            return result
        }
    }
    
    var qualityString: String {
        switch sleepQuality {
        case 0:
            return "Unrested"
        case 1:
            return "Sluggish"
        case 2:
            return "Groggy"
        case 3:
            return "Invigorated"
        case 4:
            return "Refreshed"
        default:
            return ""
        }
    }
    
}
