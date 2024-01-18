
import SwiftUI

struct SingleBattery: View {
    
    var num: Int
    
    var body: some View {
        VStack{
            Label("\(colorAndState.1)", systemImage: "\(batteryImage)")
                .foregroundStyle(colorAndState.0)
                .scaledToFit()
        }
    }
    
    var batteryImage : String {
        get {
            switch num {
            case 0...4:
                return "battery.\(num*25)percent"
            default:
                return ""
            }
        }
    }
    
    var colorAndState : (Color, String) {
        get {
            switch num {
            case 0:
                return (.black, SleepQuality.Unrested.rawValue)
            case 1:
                return (.red, SleepQuality.Sluggish.rawValue)
            case 2:
                return (.yellow, SleepQuality.Groggy.rawValue)
            case 3:
                return (.green, SleepQuality.Invigorated.rawValue)
            case 4:
                return (.blue, SleepQuality.Refreshed.rawValue)
            default:
                return (.black, "")
            }
        }
    }
    
}

#Preview {
    SingleBattery(num: 3)
}
