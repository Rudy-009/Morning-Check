//
//  SwiftUIView.swift
//
//
//  Created by 이승준 on 1/25/24.
//

import SwiftUI
import Charts

struct BasicChartView: View {
    
    @EnvironmentObject private var sleepStore: SleepStore
    @EnvironmentObject private var chartStore: ChartStore
    
    @State var rawSelectedDate: Date? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Sleep Pattern with Sleep Quality")
                .font(.title2.bold())
                .foregroundColor(.primary)
                .opacity(rawSelectedDate == nil ? 1.0 : 0.0)
            basicChart(
                rawSelectedDate: $rawSelectedDate
            )
        }
    }
}

struct basicChart: View {
    
    @EnvironmentObject private var sleepStore: SleepStore
    @EnvironmentObject private var chartStore: ChartStore
    
    @Binding var rawSelectedDate: Date?
    
    var selectedDate: Date? {
        if let rawSelectedDate {
            return chartStore.allWakeUpTime.first(where: {
                let endOfDay = chartStore.allWakeUpTime.first!
                return ($0...endOfDay.addingTimeInterval(24*60*60*3)).contains(rawSelectedDate)
            })
        }
        return nil
    }
    
    var selectedSleep: Sleep? {
        if let selectedDate {
            return chartStore.sleep(which: sleepStore.sleepData, has: selectedDate)
        }
        return nil
    }
    
    var body: some View {
        VStack {
            if #available(iOS 17, *){
                Chart {
                    ForEach (sleepStore.sleepData) { sleep in
                        BarMark ( //Chart content that represents data using a single horizontal or vertical rule.
                            x: .value("date",sleep.wakeUpDate, unit: .day),
                            yStart: .value("WakeUp",sleep.markWakeUp),
                            yEnd: .value("Sleep",sleep.markSleep),
                            width: .ratio(0.3)
                        )
                        .foregroundStyle(qualityColor(sleep.sleepQuality))
                    }
                    
                    if let selectedDate {
                        RuleMark(
                            x: .value("Selected", selectedDate, unit: .day)
                        )
                        .foregroundStyle(Color.gray.opacity(0.3))
                        .offset(yStart: -10)
                        .annotation(
                            position: .top, spacing: 0,
                            overflowResolution: .init(
                                x: .fit(to: .chart),
                                y: .disabled
                            )
                        ) {
                            valueSelectionPopover
                        }
                    }
                    
                    BarMark (
                        x: .value("Goal", Date(timeInterval: +(24*60*60), since: Date()), unit: .day),
                        yStart: .value("WakeUp",sleepStore.targetMarkWakeUp),
                        yEnd: .value("Sleep",sleepStore.targetMarkSleep),
                        width: .ratio(0.3)
                    )
                    .foregroundStyle(.cyan)
                    
                    if let selectedDate {
                        RuleMark(
                            x: .value("Selected", selectedDate, unit: .day)
                        )
                        .foregroundStyle(Color.gray.opacity(0.3))
                        .offset(yStart: -10)
                        .annotation(
                            position: .top, spacing: 0,
                            overflowResolution: .init(
                                x: .fit(to: .chart),
                                y: .disabled
                            )
                        ) {
                            valueSelectionPopover
                        }
                    }
                }
                .chartXSelection(value: $rawSelectedDate)
                .frame(height: 400)
                .chartYAxis(.automatic)
                .chartYAxis {
                    AxisMarks() {
                        AxisTick()
                        AxisGridLine()
                        AxisValueLabel(format: .dateTime.hour().minute())
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: .day, count: 7)) {
                        AxisTick()
                        AxisGridLine()
                        AxisValueLabel(format: .dateTime.month().day())
                    }
                }
            } else {
                Chart {
                    ForEach (sleepStore.sleepData) { sleep in
                        BarMark ( //Chart content that represents data using a single horizontal or vertical rule.
                            x: .value("date",sleep.wakeUpDate, unit: .day),
                            yStart: .value("WakeUp",sleep.markWakeUp),
                            yEnd: .value("Sleep",sleep.markSleep),
                            width: .ratio(0.3)
                        )
                        .foregroundStyle(qualityColor(sleep.sleepQuality))
                    }
                    
                    BarMark (
                        x: .value("Goal", Date(timeInterval: +(24*60*60), since: Date()), unit: .day),
                        yStart: .value("WakeUp",sleepStore.targetMarkWakeUp),
                        yEnd: .value("Sleep",sleepStore.targetMarkSleep),
                        width: .ratio(0.3)
                    )
                    .foregroundStyle(.cyan)
                }
                .frame(minHeight: 400)
                .chartYAxis(.automatic)
                .chartYAxis {
                    AxisMarks() {
                        AxisTick()
                        AxisGridLine()
                        AxisValueLabel(format: .dateTime.hour().minute())
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: .day, count: 7)) {
                        AxisTick()
                        AxisGridLine()
                        AxisValueLabel(format: .dateTime.month().day())
                    }
                }
            }
        }
        .frame(minHeight: 600)
    }
    
    @ViewBuilder
    var valueSelectionPopover: some View {
        if let selectedSleep {
            VStack(alignment: .leading) {
                Text("Sleep : \(sleepStore.returnFormatted(selectedSleep.sleepDate))")
                Text("Wake  : \(sleepStore.returnFormatted(selectedSleep.wakeUpDate))")
                Text("\(selectedSleep.sleepDurationHours)H : \(selectedSleep.sleepDurationMinutes)M \(selectedSleep.idealSleepDuration ? " 👍" : "")")
                SingleBattery(num: selectedSleep.sleepQuality)
                    .foregroundStyle(qualityColor(selectedSleep.sleepQuality))
                Text("\(selectedSleep.emojis)")
                //Text("\(selectedDate)")
            }
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .foregroundStyle(Color.gray.opacity(0.12))
            }
        } else {
            EmptyView()
        }
    }
}

func qualityColor(_ num: Int) -> Color {
    switch num {
    case 0:
        return Color("darkMode")
    case 1:
        return .red
    case 2:
        return .yellow
    case 3:
        return .green
    case 4:
        return .blue
    default:
        return .black
    }
}

let sleepDataTemp = [
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 23, hour: 01, min: 23, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 23, hour: 07, min: 00, sec: 00),
        sleepQuality: 4, distruptors: [], awakes: 2),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 22, hour: 05, min: 13, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 22, hour: 13, min: 31, sec: 00),
        sleepQuality: 3, distruptors: [], awakes: 1),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 21, hour: 05, min: 13, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 21, hour: 13, min: 31, sec: 00),
        sleepQuality: 3, distruptors: [], awakes: 0),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 20, hour: 05, min: 13, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 20, hour: 13, min: 31, sec: 00),
        sleepQuality: 3, distruptors: [], awakes: 0),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 19, hour: 6, min: 10, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 19, hour: 13, min: 30, sec: 00),
        sleepQuality: 2, distruptors: [], awakes: 1),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 18, hour: 4, min: 08, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 18, hour: 9, min: 08, sec: 13),
        sleepQuality: 1, distruptors: [], awakes: 2),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 17, hour: 4, min: 10, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 17, hour: 9, min: 10, sec: 00),
        sleepQuality: 2, distruptors: [], awakes: 0),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 16, hour: 3, min: 4, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 16, hour: 9, min: 50, sec: 00),
        sleepQuality: 4, distruptors: [], awakes: 1),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 15, hour: 03, min: 37, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 15, hour: 12, min: 11, sec: 00),
        sleepQuality: 3, distruptors: [], awakes: 1),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 14, hour: 04, min: 35, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 14, hour: 12, min: 10, sec: 00),
        sleepQuality: 4, distruptors: [], awakes: 1),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 13, hour: 04, min: 26, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 13, hour: 12, min: 10, sec: 00),
        sleepQuality: 3, distruptors: [], awakes: 0),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 12, hour: 05, min: 23, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 12, hour: 10, min: 9, sec: 00),
        sleepQuality: 2, distruptors: [], awakes: 0),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 11, hour: 05, min: 13, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 11, hour: 13, min: 31, sec: 00),
        sleepQuality: 3, distruptors: [], awakes: 0),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 10, hour: 05, min: 13, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 10, hour: 13, min: 31, sec: 00),
        sleepQuality: 3, distruptors: [], awakes: 0),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 9, hour: 05, min: 13, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 9, hour: 13, min: 31, sec: 00),
        sleepQuality: 3, distruptors: [], awakes: 0),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 8, hour: 6, min: 10, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 8, hour: 13, min: 30, sec: 00),
        sleepQuality: 2, distruptors: [], awakes: 1),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 7, hour: 4, min: 08, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 7, hour: 9, min: 08, sec: 13),
        sleepQuality: 1, distruptors: [], awakes: 0),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 6, hour: 4, min: 10, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 6, hour: 9, min: 10, sec: 00),
        sleepQuality: 2, distruptors: [], awakes: 0),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 5, hour: 3, min: 4, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 5, hour: 9, min: 50, sec: 00),
        sleepQuality: 4, distruptors: [], awakes: 1),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 4, hour: 03, min: 37, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 4, hour: 12, min: 11, sec: 00),
        sleepQuality: 3, distruptors: [], awakes: 0),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 3, hour: 04, min: 35, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 3, hour: 12, min: 10, sec: 00),
        sleepQuality: 4, distruptors: [], awakes: 0),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 2, hour: 04, min: 26, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 2, hour: 12, min: 10, sec: 00),
        sleepQuality: 3, distruptors: [], awakes: 0),
    Morning_Check.Sleep(
        sleepDate: date(year: 2024, month: 01, day: 1, hour: 05, min: 23, sec: 00),
        wakeUpDate: date(year: 2024, month: 01, day: 1, hour: 10, min: 9, sec: 00),
        sleepQuality: 2, distruptors: [], awakes: 1)
]


#Preview {
    BasicChartView()
}
