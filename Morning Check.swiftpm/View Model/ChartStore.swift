//
//  File.swift
//
//
//  Created by 이승준 on 1/24/24.

import Foundation

class ChartStore: ObservableObject {
    
    @Published var sleepData: [Sleep] = []
    @Published var distruptorAndQualityArray: [DistruptorAndQuality] = []
    @Published var durationAndQualityArray: [DurationAndQuality] = []
    
    @Published var thisWeekSleep: [Sleep] = []
    @Published var lastWeekSleep: [Sleep] = []
    @Published var pastThirdWeekSleep: [Sleep] = []
    @Published var pastFourthWeekSleep: [Sleep] = []
    @Published var pastFifthWeekSleep: [Sleep] = []
    
//    var twoWeeksSleep: [Sleep] = []
//    var fourWeeksSleep: [Sleep] = []
    var allSleep: [Sleep] = []
    
    private var overThePastTwoWeeksSleep: [Sleep] = []
    private var duringTheLastTwoWeeksSleep: [Sleep] = []
    
    @Published var thisWeekSleepTime: [Date] = []
    @Published var thisWeekWakeUpTime: [Date] = []
    @Published var lastWeekSleepTime: [Date] = []
    @Published var lastWeekWakeUpTime: [Date] = []
    @Published var pastThirdWeekSleepTime: [Date] = []
    @Published var pastThirdWeekWakeUpTime: [Date] = []
    @Published var pastFourthWeekSleepTime: [Date] = []
    @Published var pastFourthWeekWakeUpTime: [Date] = []
    @Published var pastFifthWeekSleepTime: [Date] = []
    @Published var pastFifthWeekWakeUpTime: [Date] = []
    
    @Published var weekData: [Week] = []
    
//    private var twoWeeksSleepTime: [Date] = []
//    private var twoWeeksWakeUpTime: [Date] = []
//    private var fourWeeksSleepTime: [Date] = []
//    private var fourWeeksWakeUpTime: [Date] = []
    
    var allSleepTime: [Date] = []
    var allWakeUpTime: [Date] = []
    
    
    init() {}
    
    func refreshChartData(to newSleepDate: [Sleep]) {
        self.sleepData = newSleepDate
    }
    
    func updateThisWeekSleep(by newSleepDate: [Sleep]) {
        self.thisWeekSleep = updateWeekRealtedSleep(by: newSleepDate, start: 0, end: 0)
        self.thisWeekSleepTime = getOnlySleepTime(of: self.thisWeekSleep)
        self.thisWeekWakeUpTime = getOnlyWakeUpTime(of: self.thisWeekSleep)
    }
    
    func updateLastWeekSleep(by newSleepDate: [Sleep]) {
        self.lastWeekSleep = updateWeekRealtedSleep(by: newSleepDate, start: 1, end: 1)
        self.lastWeekSleepTime = getOnlySleepTime(of: self.lastWeekSleep)
        self.lastWeekWakeUpTime = getOnlyWakeUpTime(of: self.lastWeekSleep)
    }
    
    func updatePastThirdWeekSleep(by newSleepDate: [Sleep]) {
        self.pastThirdWeekSleep = updateWeekRealtedSleep(by: newSleepDate, start: 2, end: 2)
        self.pastThirdWeekSleepTime = getOnlySleepTime(of: self.pastThirdWeekSleep)
        self.pastThirdWeekWakeUpTime = getOnlyWakeUpTime(of: self.pastThirdWeekSleep)
    }
    
    func updatePastFourthWeekSleep(by newSleepDate: [Sleep]) {
        self.pastFourthWeekSleep = updateWeekRealtedSleep(by: newSleepDate, start: 3, end: 3)
        self.pastFourthWeekSleepTime = getOnlySleepTime(of: self.pastFourthWeekSleep)
        self.pastFourthWeekWakeUpTime = getOnlyWakeUpTime(of: self.pastFourthWeekSleep)
    }
    
    func updatePastFifthWeekSleep(by newSleepDate: [Sleep]) {
        self.pastFifthWeekSleep = updateWeekRealtedSleep(by: newSleepDate, start: 4, end: 4)
        self.pastFifthWeekSleepTime = getOnlySleepTime(of: self.pastFifthWeekSleep)
        self.pastFifthWeekWakeUpTime = getOnlyWakeUpTime(of: self.pastFifthWeekSleep)
    }
    
//    func twoLastWeekSleep(by newSleepDate: [Sleep]) {
//        self.twoWeeksSleep =  updateWeekRealtedSleep(by: newSleepDate, start: 1, end: 2)
//        self.twoWeeksSleepTime = getOnlySleepTime(of: self.twoWeeksSleep)
//        self.twoWeeksWakeUpTime = getOnlyWakeUpTime(of: self.twoWeeksSleep)
//    }
//    
//    func updateFourWeeksSleep(by newSleepDate: [Sleep]) {
//        self.fourWeeksSleep = updateWeekRealtedSleep(by: newSleepDate, start: 0, end: 3)
//        self.fourWeeksSleepTime = getOnlySleepTime(of: self.fourWeeksSleep)
//        self.fourWeeksWakeUpTime = getOnlyWakeUpTime(of: self.fourWeeksSleep)
//    }
    
    func updateAllWeeksSleep(by newSleepDate: [Sleep]) {
        self.allSleep = updateWeekRealtedSleep(by: newSleepDate, start: 0, end: -1)
        self.allSleepTime = getOnlySleepTime(of: self.allSleep)
        self.allWakeUpTime = getOnlyWakeUpTime(of: self.allSleep)
    }
    
    func updateWeekData() {
        self.updateWeekDataOriginal()
    }
    
    func updateAllWeekSleep(by newSleepDate: [Sleep]) {
        self.updateThisWeekSleep(by: newSleepDate)
        self.updateLastWeekSleep(by: newSleepDate)
        self.updatePastThirdWeekSleep(by: newSleepDate)
        self.updatePastFourthWeekSleep(by: newSleepDate)
        self.updatePastFifthWeekSleep(by: newSleepDate)
        //self.twoLastWeekSleep(by: newSleepDate)
        //self.updateFourWeeksSleep(by: newSleepDate)
        self.updateAllWeeksSleep(by: newSleepDate)
    }

    func updateEveryData(to newSleepDate: [Sleep]) {
        self.refreshChartData(to: newSleepDate)
        self.updateDistruptorsAndQuality()
        self.updateAllWeekSleep(by: newSleepDate)
        self.updateWeekData()
        self.updateWeekDataOriginal()
    }
    
    func sleep(which targetArray: [Sleep], has date: Date) -> Sleep? {
        return targetArray.first(where: {
            return $0.wakeUpDate == date
        })
    }
    
}
