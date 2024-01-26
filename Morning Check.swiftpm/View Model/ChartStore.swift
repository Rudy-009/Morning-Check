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
    
    init() {
        
    }
    
    func refreshChartData(to newSleepDate: [Sleep]) {
        self.sleepData = newSleepDate
    }
    
    func updateThisWeekSleep(by newSleepDate: [Sleep]) {
        thisWeekSleep = updateWeekRealtedSleep(by: newSleepDate, start: 0, end: 0)
        thisWeekSleepTime = getOnlySleepTime(of: thisWeekSleep)
        thisWeekWakeUpTime = getOnlyWakeUpTime(of: thisWeekSleep)
    }
    
    func updateLastWeekSleep(by newSleepDate: [Sleep]) {
        lastWeekSleep = updateWeekRealtedSleep(by: newSleepDate, start: 1, end: 1)
        lastWeekSleepTime = getOnlySleepTime(of: lastWeekSleep)
        lastWeekWakeUpTime = getOnlyWakeUpTime(of: lastWeekSleep)
    }
    
    func updatePastThirdWeekSleep(by newSleepDate: [Sleep]) {
        pastThirdWeekSleep = updateWeekRealtedSleep(by: newSleepDate, start: 1, end: 1)
        pastThirdWeekSleepTime = getOnlySleepTime(of: pastThirdWeekSleep)
        pastThirdWeekWakeUpTime = getOnlyWakeUpTime(of: pastThirdWeekSleep)
    }
    
    func updatePastFourthWeekSleep(by newSleepDate: [Sleep]) {
        pastFourthWeekSleep = updateWeekRealtedSleep(by: newSleepDate, start: 1, end: 1)
        pastFourthWeekSleepTime = getOnlySleepTime(of: pastFourthWeekSleep)
        pastFourthWeekWakeUpTime = getOnlyWakeUpTime(of: pastFourthWeekSleep)
    }
    
    func twoLastWeekSleep(by newSleepDate: [Sleep]) {
        twoWeekSleep =  updateWeekRealtedSleep(by: newSleepDate, start: 1, end: 2)
        twoWeekSleepTime = getOnlySleepTime(of: twoWeekSleep)
        twoWeekWakeUpTime = getOnlyWakeUpTime(of: twoWeekSleep)
    }
    
    func updateFourWeeksSleep(by newSleepDate: [Sleep]) {
        fourWeeksSleep = updateWeekRealtedSleep(by: newSleepDate, start: 0, end: 3)
        fourWeeksSleepTime = getOnlySleepTime(of: fourWeeksSleep)
        fourWeeksWakeUpTime = getOnlyWakeUpTime(of: fourWeeksSleep)
    }
    
    func updateAllWeekSleep(by newSleepDate: [Sleep]) {
        updateThisWeekSleep(by: newSleepDate)
        updateLastWeekSleep(by: newSleepDate)
        updatePastThirdWeekSleep(by: newSleepDate)
        updatePastFourthWeekSleep(by: newSleepDate)
        twoLastWeekSleep(by: newSleepDate)
        updateFourWeeksSleep(by: newSleepDate)
    }
    
    func updateEveryData(to newSleepDate: [Sleep]) {
        refreshChartData(to: newSleepDate)
        updateDistruptorsAndQuality()
        updateAllWeekSleep(by: newSleepDate)
    }
    
}
