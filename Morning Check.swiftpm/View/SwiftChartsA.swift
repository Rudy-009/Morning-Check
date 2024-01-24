//
//  SwiftUIView.swift
//
//
//  Created by 이승준 on 1/22/24.
//

import SwiftUI
import Charts

func date(year: Int, month: Int, day: Int, hour: Int, min: Int, sec: Int) -> Date {
    Calendar.current.date(from: DateComponents(timeZone: TimeZone(identifier: "Asia/Seoul"), year: year, month: month, day: day, hour: hour, minute: min, second: sec)) ?? Date()
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

struct SwiftChartsA: View {
    
    @EnvironmentObject private var sleepStore: SleepStore
    
    var body: some View {
        ScrollView {
            Chart {
                ForEach (sleepStore.sleepData) { sleep in
                    BarMark ( //Chart content that represents data using a single horizontal or vertical rule.
                        x: .value("date",sleep.wakeUpDate, unit: .day),
                        yStart: .value("WakeUp",sleep.markWakeUp),
                        yEnd: .value("Sleep",sleep.markSleep),
                        width: .ratio(0.3)
                    )
                    .foregroundStyle(qualiyColor(sleep.sleepQuality))
                }
                BarMark (
                    x: .value("Goal", Date(timeInterval: +(24*60*60), since: Date()), unit: .day),
                    yStart: .value("WakeUp",sleepStore.targetMarkWakeUp),
                    yEnd: .value("Sleep",sleepStore.targetMarkSleep),
                    width: .ratio(0.3)
                )
                .foregroundStyle(.cyan)

            }
            .frame(minHeight: 300)
            //.chartYScale(type: .date)
            .chartYAxis(.automatic)
            
        }
    }
}

func qualiyColor(_ num: Int) -> Color {
    switch num {
    case 0:
        return .black
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
    SwiftChartsA()
        .environmentObject(SleepStore())
}
