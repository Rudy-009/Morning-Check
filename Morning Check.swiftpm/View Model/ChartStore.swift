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

class ChartStore: ObservableObject {
    @Published var sleepData: [Sleep] = []
    @Published var distruptorAndQualityArray: [DistruptorAndQuality] = []
    
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
    
    func updateForDistruptorsAndQualityView(){ //Modify array for use of DistruptionAndQualityView
        var dictionary: [SleepDisruptors:(count: Int, total: Int)] = [:]
        self.distruptorAndQualityArray = []
        
        for sleep in sleepData {
            if !sleep.distruptors.isEmpty {
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

    func updateEveryData(to newSleepDate: [Sleep]) {
        refreshChartData(to: newSleepDate)
        updateForDistruptorsAndQualityView()
    }
    
}
