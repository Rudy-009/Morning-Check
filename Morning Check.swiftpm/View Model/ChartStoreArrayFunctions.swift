//
//  File.swift
//  
//
//  Created by 이승준 on 1/26/24.
//

import Foundation


extension ChartStore {
    
    func updateWeekRealtedSleep(by newSleepDate: [Sleep], start: Int, end: Int) -> [Sleep] {
        let calender = Calendar.current
        let todayComp = calender.dateComponents([.year, .weekOfYear], from: Date())
        var dateCompArray: [DateComponents] = []
        var result: [Sleep] = []
        
        for week in start...end {
            let comp = DateComponents(year: todayComp.year, weekOfYear: todayComp.weekOfYear! - week)
            dateCompArray.append(comp)
        }
        
        for sleep in newSleepDate {
            let sleepComp = calender.dateComponents([.year, .weekOfYear], from: sleep.wakeUpDate)
            
            guard sleep.sleepDuration >= 4*60*60 else { continue }
            
            for comp in dateCompArray {
                if sleepComp.year == comp.year && sleepComp.weekOfYear == comp.weekOfYear {
                    result.append(sleep)
                }
            }
        }
        
        return result
    }
    
    func getOnlySleepTime(of sleepArray: [Sleep]) -> [Date]{
        var sleepTime: [Date] = []
        
        for sleep in sleepArray {
            sleepTime.append(sleep.sleepDate)
        }
        
        return sleepTime
    }
    
    func getOnlyWakeUpTime(of sleepArray: [Sleep]) -> [Date]{
        var wakeUpTime: [Date] = []
        
        for sleep in sleepArray {
            wakeUpTime.append(sleep.wakeUpDate)
        }
        
        return wakeUpTime
    }
    
    
    
    
}
