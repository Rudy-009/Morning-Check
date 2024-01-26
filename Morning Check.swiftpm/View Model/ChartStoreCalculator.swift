//
//  File.swift
//  
//
//  Created by 이승준 on 1/25/24.
//

import SwiftUI

extension ChartStore {
    
    func timeAverage(of dateArray: [Date]) -> Date {
        //let date: Date = Date()
        let calendar = Calendar.current
        
        var result: Int = 0
        
        for date in dateArray {
            let dc = calendar.dateComponents([.hour, .minute], from: date)
            
            if dc.hour! >= 12 { //23, 22, 21, 20... 12
                result += ((dc.hour!*60 + dc.minute!) - 24*60)
            } else { //0, 1, 2, 3, 4, ..., 11
                result += (dc.hour!*60 + dc.minute!)
            }
        }
        
        let avg = result/dateArray.count >= 0 ? result/dateArray.count : 24*60 + result/dateArray.count
        
        return Calendar.current.date(from: DateComponents(hour: avg/60, minute: avg%60)) ?? Date()
    }
    
    func timeDeviation(of dateArray: [Date]) -> Double {
        
        let average = timeAverage(of: dateArray)
        let calendar = Calendar.current
        let averageComp = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: average)
        
        var sum = 0.0
        
        for token in dateArray {
            let tokenComp = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: token)
            let tempAverage = Calendar.current.date(
                from: DateComponents( year: tokenComp.year, month: tokenComp.month,
                                      day: averageComp.hour! <= 12 ? tokenComp.day!+1 : tokenComp.day,
                                      hour: averageComp.hour, minute: averageComp.minute )) ?? Date()
            
            let interval = tempAverage.timeIntervalSince(token)/3600.0
            sum += interval*interval
        }
        
        let deviation: Double = sqrt(sum/Double(dateArray.count))
        return deviation
    }
    
}

func date(year: Int, month: Int, day: Int, hour: Int, min: Int, sec: Int) -> Date {
    Calendar.current.date(
        from: DateComponents(year: year, month: month, day: day, hour: hour, minute: min)) ?? Date()
}

func date(year: Int, month: Int, day: Int, hour: Int, min: Int) -> Date {
    Calendar.current.date(
        from: DateComponents(year: year, month: month, day: day, hour: hour, minute: min)) ?? Date()
}

func date(hour: Int, min: Int) -> Date {
    Calendar.current.date(
        from: DateComponents(hour: hour, minute: min)) ?? Date()
}
