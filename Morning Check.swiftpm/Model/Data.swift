
import Foundation
import SwiftUI

struct Sleep : Identifiable, Codable {
    var id = UUID()
    var sleepDate: Date
    var wakeUpDate: Date
    var sleepQuality: Int
    
    var sleepDuration: Double {
        return wakeUpDate.timeIntervalSince(sleepDate)
    }
    var sleepDurationHours: Int {
        return Int(sleepDuration/3600)
    }
    var sleepDurationMinutes: Int {
        return (Int(sleepDuration)%3600)/60
    }
}

enum SleepQuality: String, Codable {
    case Refreshed
    case Invigorated
    case Groggy
    case Sluggish
    case Unrested
}
