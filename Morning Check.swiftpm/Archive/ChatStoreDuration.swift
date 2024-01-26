//
//  File 2.swift
//  
//
//  Created by 이승준 on 1/26/24.
//

import Foundation

struct DurationAndQuality: Identifiable, Codable {
    var id = UUID()
    var duration : Double
    var count: Int
    var quality: Int
    var average: Double {
        return duration/Double(count)
    }
    
    var averageTime: Date {
        return Calendar.current.date(from: DateComponents(hour: Int(average/3600), minute: Int(average)%60 )) ?? Date()
    }
    
    var averageString: String {
        let seconds = Int(average)
        let hours = seconds/3600
        let minutes = (seconds%3600)/60
        return String(format: "%02d:%02d", hours, minutes)
    }
}

extension ChartStore { //Duration and Quality
    
    func updateDurationAndQuality() {
        var dictionary: [Int:(count: Int, duration: Double)] = [:]
        self.durationAndQualityArray = []
        
        for sleep in sleepData {
            if sleep.sleepDurationHours >= 4{
                let quality = sleep.sleepQuality
                if dictionary[quality] == nil {
                    dictionary[quality] = (1, 0.0)
                    dictionary[quality]?.duration += sleep.sleepDuration
                } else {
                    dictionary[quality]?.count += 1
                    dictionary[quality]?.duration += sleep.sleepDuration
                }
            }
        }
        
        for key in dictionary.keys {
            if let a = dictionary[key] {
                let data : DurationAndQuality = DurationAndQuality(duration: a.duration, count: a.count, quality: key)
                durationAndQualityArray.append(data)
            }
        }
        
        durationAndQualityArray.sort{$0.quality < $1.quality}
        print(self.durationAndQualityArray)
    }
    
}
