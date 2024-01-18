//
//  BatteryView.swift
//  Morning Check
//
//  Created by 이승준 on 1/18/24.
//

import SwiftUI

struct BatteryView: View {
    
    @Binding var battery: Int
    var size: Int
    
    var batteryImage : String {
        get {
            switch battery {
            case 0...4:
                return "battery.\(battery*25)percent"
            default:
                return ""
            }
        }
    }
    
    var colorOfBettery : Color {
        get {
            switch battery {
            case 0:
                return .black
            case 1:
                return .red
            case 2:
                return . yellow
            case 3...4:
                return .green
            default:
                return .green
            }
        }
    }
    
    var body: some View {
        VStack {
            Image(systemName: "\(batteryImage)")
                .foregroundStyle(colorOfBettery, colorOfBettery)
                .scaledToFit()
                .font(.system(size: 300))
            HStack {
                Button(action: {
                    if 0 < battery  {
                        battery -= 1
                    }
                }, label: {
                    Text("Minus")
                        .font(.system(size: 50))
                        .padding()
                })
                Button(action: {
                    if battery < 4 {
                        battery += 1
                    }
                }, label: {
                    Text("Add")
                        .font(.system(size: 50))
                        .padding()
                })
            }
        }
    }
}
