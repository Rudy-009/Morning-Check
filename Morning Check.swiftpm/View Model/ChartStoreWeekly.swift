//
//  File.swift
//  
//
//  Created by 이승준 on 2/2/24.
//

import Foundation

extension ChartStore {
    
    func weekName(of week: Int) -> String {
        let calender = Calendar.current
        let todayComp = calender.dateComponents([.year, .weekOfYear, .weekday , .month, .day], from: Date())
        
        let start = DateComponents(year: todayComp.year, weekday: 1  ,weekOfYear: todayComp.weekOfYear! - week)
        
        let end = DateComponents(year: todayComp.year, month: todayComp.month, day: todayComp.day, weekday: 7  ,weekOfYear: todayComp.weekOfYear! - week)
        
        let from = "\(start.month) \(start.day) \(start.year)"
        let to = "\(end.month) \(end.day) \(end.year)"
        
        return "\(from) ~ \(to)"
    }
    
    func updateWeekDataOriginal() {
        
        self.weekData.append(Week(name: "This Week", weekSleep: self.thisWeekSleep, wakeUpData: self.thisWeekWakeUpTime, sleepData: self.thisWeekSleepTime))
        
        self.weekData.append(Week(name: "Last Week", weekSleep: self.lastWeekSleep, wakeUpData: self.lastWeekWakeUpTime, sleepData: self.lastWeekSleepTime))
        
        self.weekData.append(Week(name: weekName(of: 2), weekSleep: self.pastThirdWeekSleep, wakeUpData: self.pastThirdWeekWakeUpTime, sleepData: self.pastThirdWeekSleepTime))
        
        self.weekData.append(Week(name: weekName(of: 3), weekSleep: self.pastFourthWeekSleep, wakeUpData: self.pastFourthWeekWakeUpTime, sleepData: self.pastFourthWeekSleepTime))
        
    }
    
}
