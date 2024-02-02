//
//  SwiftUIView.swift
//  
//
//  Created by 이승준 on 2/1/24.
//

import SwiftUI
import Charts

struct WeekComparePreview: View {
    
    @EnvironmentObject var chartStore: ChartStore
    @EnvironmentObject var sleepStore: SleepStore
    
    var body: some View {
        VStack {
            Text("This Week")
                .font(.title2.bold())
                .foregroundColor(.primary)
            Chart {
                ForEach(chartStore.thisWeekSleep) { sleep in
                    BarMark ( //Chart content that represents data using a single horizontal or vertical rule.
                        x: .value("date",sleep.wakeUpDate, unit: .day),
                        yStart: .value("WakeU p",sleep.markWakeUp),
                        yEnd: .value("Sleep",sleep.markSleep)
                    )
                    .foregroundStyle(qualityColor(sleep.sleepQuality))
                }
                
                RuleMark(y: .value("average sleep time", chartStore.sleepTimeAverage(of: chartStore.thisWeekSleepTime)))
                
                RuleMark(y: .value("average wake up time", chartStore.wakeUpTimeAverage(of: chartStore.thisWeekWakeUpTime)))
                
            }
            .chartYAxis(.automatic)
            .chartYAxis {
                AxisMarks() {
                    AxisTick()
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.hour().minute())
                }
            }
            .chartPlotStyle { plotArea in
                plotArea.frame(height: K.Chart.basicHeight)
            }
            .padding()
            Text("Average")
            Text("WakeUp: \(sleepStore.hourMinuteFormatted(chartStore.sleepTimeAverage(of: chartStore.thisWeekSleepTime))) Sleep: \(sleepStore.hourMinuteFormatted(chartStore.wakeUpTimeAverage(of: chartStore.thisWeekWakeUpTime)))")
                .foregroundStyle(Color.accentColor)
        }
    }
}

#Preview {
    WeekComparePreview()
}
