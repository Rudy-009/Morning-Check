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
        
        let start = date(
            year: todayComp.year!, weekOfYear: todayComp.weekOfYear! - week, weekday: 1)
        
        let end = date(
            year: todayComp.year!, weekOfYear: todayComp.weekOfYear! - week, weekday: 7)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M.d.YY"
        
        let from = dateFormatter.string(from: start)
        let to = dateFormatter.string(from: end)
        
        return "\(from) ~ \(to)"
    }
    
    func updateWeekDataOriginal() {
        
        self.weekData.append(Week(name: "This Week", weekSleep: self.thisWeekSleep, wakeUpData: self.thisWeekWakeUpTime, sleepData: self.thisWeekSleepTime))
        
        self.weekData.append(Week(name: "Last Week", weekSleep: self.lastWeekSleep, wakeUpData: self.lastWeekWakeUpTime, sleepData: self.lastWeekSleepTime))
        
        self.weekData.append(Week(name: weekName(of: 2), weekSleep: self.pastThirdWeekSleep, wakeUpData: self.pastThirdWeekWakeUpTime, sleepData: self.pastThirdWeekSleepTime))
        
        self.weekData.append(Week(name: weekName(of: 3), weekSleep: self.pastFourthWeekSleep, wakeUpData: self.pastFourthWeekWakeUpTime, sleepData: self.pastFourthWeekSleepTime))
        
        self.weekData.append(Week(name: weekName(of: 4), weekSleep: self.pastFifthWeekSleep, wakeUpData: self.pastFifthWeekWakeUpTime, sleepData: self.pastFifthWeekSleepTime))
        
    }
    
}
