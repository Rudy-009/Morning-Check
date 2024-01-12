
import Foundation
import SwiftUI

struct Sleep : Identifiable, Codable {
    var id = UUID()
    var sleepDate: Date
    var wakeUpDate: Date
    var sleepQuality: SleepQuality
}

enum SleepQuality: String, Codable {
    case Refreshed
    case Invigorated
    case Groggy
    case Sluggish
    case Unrested
}
