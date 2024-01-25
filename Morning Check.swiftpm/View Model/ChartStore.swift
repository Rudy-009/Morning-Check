//
//  File.swift
//
//
//  Created by 이승준 on 1/24/24.

import Foundation

struct DistruptorAndQuality: Identifiable, Codable {
    var id = UUID()
    var distruptor: SleepDisruptors
    var distruptorCount: Int
    var totalQuality: Int
    var averageByDistruptors: Double {
        return Double(totalQuality)/Double(distruptorCount)
    }
}

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

class ChartStore: ObservableObject {
    
    @Published var sleepData: [Sleep] = []
    @Published var distruptorAndQualityArray: [DistruptorAndQuality] = []
    @Published var durationAndQualityArray: [DurationAndQuality] = []
    
    private var thisWeek: [Sleep] = []
    private var twoWeeks: [Sleep] = []
    private var fourWeeks: [Sleep] = []
    private var lastWeek: [Sleep] = []
    
    private var thisWeekOnlySleep: [Sleep] = []
    private var twoWeeksOnlySleep: [Sleep] = []
    private var fourWeeksOnlySleep: [Sleep] = []
    private var lastWeekOnlySleep: [Sleep] = []
    
    init() {
        
    }
    
    func refreshChartData(to newSleepDate: [Sleep]) {
        self.sleepData = newSleepDate
    }
    
    func updateThisWeek(by newSleepDate: [Sleep]) {
        
    }
    
    func updateTwoWeeks(by newSleepDate: [Sleep]) {
        
    }
    
    func updateEveryData(to newSleepDate: [Sleep]) {
        refreshChartData(to: newSleepDate)
        updateDistruptorsAndQuality()
        updateDurationAndQuality()
        updateDurationAndQuality()
    }
    
}

extension ChartStore {
    
    func updateDistruptorsAndQuality(){ //Modify array for use of DistruptionAndQualityView
        var dictionary: [SleepDisruptors:(count: Int, total: Int)] = [:]
        self.distruptorAndQualityArray = []
        
        for sleep in sleepData {
            if !sleep.distruptors.isEmpty && sleep.sleepDurationHours >= 4{
                for dis in sleep.distruptors {
                    if dictionary[dis] == nil {
                        dictionary[dis] = (0,0)
                        dictionary[dis]?.count += 1
                        dictionary[dis]?.total += sleep.sleepQuality
                    } else {
                        dictionary[dis]?.count += 1
                        dictionary[dis]?.total += sleep.sleepQuality
                    }
                }
            }
        }
        
        for key in dictionary.keys {
            if let a = dictionary[key] {
                let data : DistruptorAndQuality = DistruptorAndQuality(distruptor: key, distruptorCount: a.count, totalQuality: a.total)
                distruptorAndQualityArray.append(data)
            }
        }
        
        distruptorAndQualityArray.sort{$0.averageByDistruptors < $1.averageByDistruptors}
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
