
import SwiftUI

struct SleepQualityEditView: View {
    
    @Binding var sleepQuality: Int
    var size: Int
    
    var body: some View {
        VStack {
            Text("How was your sleep??")
                .font(.system(size: 50))
            Text("\(colorAndState.1)")
                .font(.system(size: 50))
            Image(systemName: "\(batteryImage)")
                .foregroundStyle(colorAndState.0)
                .scaledToFit()
                .font(.system(size: 300))
            HStack {
                Button(action: {
                    if 0 < sleepQuality  {
                        sleepQuality -= 1
                    }
                }, label: {
                    Text("-")
                        .font(.system(size: 50))
                        .padding()
                        .disabled(sleepQuality <= 0 ? true : false)
                })
                Button(action: {
                    if sleepQuality < 4 {
                        sleepQuality += 1
                    }
                }, label: {
                    Text("+")
                        .font(.system(size: 50))
                        .padding()
                        .disabled(sleepQuality >= 4 ? true : false)
                })
            }
        }
    }
    
    var batteryImage : String {
        get {
            switch sleepQuality {
            case 0...4:
                return "battery.\(sleepQuality*25)percent"
            default:
                return ""
            }
        }
    }
    
    var colorAndState : (Color, String) {
        get {
            switch sleepQuality {
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
    
    var isAddDisable: Bool {
        get {
            if sleepQuality >= 4 {
                return true
            }
            return false
        }
    }
}
