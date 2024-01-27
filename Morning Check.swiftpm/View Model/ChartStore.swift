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
    
    private var thisWeekSleep: [Sleep] = []
    private var lastWeekSleep: [Sleep] = []
    private var pastThirdWeekSleep: [Sleep] = []
    private var pastFourthWeekSleep: [Sleep] = []
    
    private var twoWeekSleep: [Sleep] = []
    private var fourWeeksSleep: [Sleep] = []
    private var allSleep: [Sleep] = []
    
    private var overThePastTwoWeeksSleep: [Sleep] = []
    private var duringTheLastTwoWeeksSleep: [Sleep] = []
    
    private var thisWeekSleepTime: [Date] = []
    private var thisWeekWakeUpTime: [Date] = []
    private var lastWeekSleepTime: [Date] = []
    private var lastWeekWakeUpTime: [Date] = []
    private var pastThirdWeekSleepTime: [Date] = []
    private var pastThirdWeekWakeUpTime: [Date] = []
    private var pastFourthWeekSleepTime: [Date] = []
    private var pastFourthWeekWakeUpTime: [Date] = []
    
    private var twoWeekSleepTime: [Date] = []
    private var twoWeekWakeUpTime: [Date] = []
    private var fourWeeksSleepTime: [Date] = []
    private var fourWeeksWakeUpTime: [Date] = []
    
    var allSleepTime: [Date] = []
    var allWakeUpTime: [Date] = []
                         
    var allSleepTimeWithUUID: [(Date, UUID)] = []
    var allWakeUpTimeWithUUID: [(Date, UUID)] = []
    
    init() {
        
    }
    
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
        self.pastThirdWeekSleep = updateWeekRealtedSleep(by: newSleepDate, start: 1, end: 1)
        self.pastThirdWeekSleepTime = getOnlySleepTime(of: self.pastThirdWeekSleep)
        self.pastThirdWeekWakeUpTime = getOnlyWakeUpTime(of: self.pastThirdWeekSleep)
    }
    
    func updatePastFourthWeekSleep(by newSleepDate: [Sleep]) {
        self.pastFourthWeekSleep = updateWeekRealtedSleep(by: newSleepDate, start: 1, end: 1)
        self.pastFourthWeekSleepTime = getOnlySleepTime(of: self.pastFourthWeekSleep)
        self.pastFourthWeekWakeUpTime = getOnlyWakeUpTime(of: self.pastFourthWeekSleep)
    }
    
    func twoLastWeekSleep(by newSleepDate: [Sleep]) {
        self.twoWeekSleep =  updateWeekRealtedSleep(by: newSleepDate, start: 1, end: 2)
        self.twoWeekSleepTime = getOnlySleepTime(of: self.twoWeekSleep)
        self.twoWeekWakeUpTime = getOnlyWakeUpTime(of: self.twoWeekSleep)
    }
    
    func updateFourWeeksSleep(by newSleepDate: [Sleep]) {
        self.fourWeeksSleep = updateWeekRealtedSleep(by: newSleepDate, start: 0, end: 3)
        self.fourWeeksSleepTime = getOnlySleepTime(of: self.fourWeeksSleep)
        self.fourWeeksWakeUpTime = getOnlyWakeUpTime(of: self.fourWeeksSleep)
    }
    
    func updateAllWeeksSleep(by newSleepDate: [Sleep]) {
        self.allSleep = updateWeekRealtedSleep(by: newSleepDate, start: 0, end: -1)
        self.allSleepTime = getOnlySleepTime(of: self.allSleep)
        self.allWakeUpTime = getOnlyWakeUpTime(of: self.allSleep)
        
        self.allWakeUpTimeWithUUID = getWakeUpTimeAndUUID(of: self.allSleep)
    }
    
    func updateAllWeekSleep(by newSleepDate: [Sleep]) {
        self.updateThisWeekSleep(by: newSleepDate)
        self.updateLastWeekSleep(by: newSleepDate)
        self.updatePastThirdWeekSleep(by: newSleepDate)
        self.updatePastFourthWeekSleep(by: newSleepDate)
        self.twoLastWeekSleep(by: newSleepDate)
        self.updateFourWeeksSleep(by: newSleepDate)
        self.updateAllWeeksSleep(by: newSleepDate)
    }
    
    func updateEveryData(to newSleepDate: [Sleep]) {
        self.refreshChartData(to: newSleepDate)
        self.updateDistruptorsAndQuality()
        self.updateAllWeekSleep(by: newSleepDate)
    }
    
    func sleep(which targetArray: [Sleep], has date: Date) -> Sleep? {
        return targetArray.first(where: {
            return $0.wakeUpDate == date
        })
    }
    
}
