//
//  File.swift
//
//
//  Created by 이승준 on 1/31/24.
//

import Foundation

struct Week: Identifiable {
    
    let name: String
    let weekSleep: [Sleep]
    
    let wakeUpData: [Date]
    let sleepData: [Date]
    
    //Average
//    let wakeUpAverage: Date
//    let sleepAverage: Date
//    
//    let sleepTimeConsistency: Double
//    let wakeUpTimeConsistency: Double
//    let durationConsistency: Double
//    
//    var qualityAverage: Double {
//        return Double(weekSleep.reduce(into: 0.0){Double($0.sleepQuality) + Double($1.sleepQuality})/Double(weekSleep.count))
//    }
//    
//    var durationAverage: Double {
//        return Double(weekSleep.reduce(into: 0.0){Double($0.sleepDuration) + Double($1.sleepDuration})/Double(weekSleep.count))
//    }
    
    var id: String {name}
    
}
