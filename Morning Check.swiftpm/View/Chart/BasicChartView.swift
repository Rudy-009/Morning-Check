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
    case -1:
        return Color(.systemBackground)
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

#Preview {
    BasicChartView()
}
