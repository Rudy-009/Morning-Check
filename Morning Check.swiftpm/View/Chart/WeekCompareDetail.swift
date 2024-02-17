//
//  SwiftUIView.swift
//
//
//  Created by 이승준 on 2/1/24.
//

import SwiftUI
import Charts

struct WeekCompareDetail: View {
    
    @EnvironmentObject private var sleepStore: SleepStore
    @EnvironmentObject private var chartStore: ChartStore
    
    @State var index: Int = 0
    @State var isLeftDisale: Bool = false
    @State var isRightDisale: Bool = true
    
    let columnLayout = Array(repeating: GridItem(), count: 2)
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    index += 1
                    if index == chartStore.weekData.count - 1 || index == 3 {
                        isLeftDisale = true
                    }
                    isRightDisale = false
                } label: {
                    Image(systemName: "arrow.left.circle.fill")
                        .foregroundStyle(.primary)
                }
                .padding([.leading], 30)
                .disabled(isLeftDisale)
                .font(.system(size: K.Font.weekCompareDetailButtonSize))
                
                Spacer()
                
                Text("\(chartStore.weekData[index].name)")
                    .font(.system(size: K.Font.weekCompareDetailTitleSize))
                
                Spacer()
                
                Button {
                    index -= 1
                    if index == 0 {
                        isRightDisale = true
                    }
                    isLeftDisale = false
                } label: {
                    Image(systemName: "arrow.right.circle.fill")
                        .foregroundStyle(.primary)
                }
                .padding([.trailing], 30)
                .disabled(isRightDisale)
                .font(.system(size: K.Font.weekCompareDetailButtonSize))
                
            }
            .frame(maxWidth: .infinity)
            
            Chart {
                ForEach(chartStore.sleepArrayForSevenDays(of: chartStore.weekData[index].weekSleep, in: index)) { sleep in
                    BarMark(
                        x: .value("date",sleep.wakeUpDate, unit: .day),
                        yStart: .value("WakeUp",sleep.markWakeUp),
                        yEnd: .value("Sleep",sleep.markSleep),
                        width: .ratio(0.4)
                    )
                    .foregroundStyle(qualityColor(sleep.sleepQuality))
                }
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
                plotArea.frame(height: K.Chart.detailHeight)
            }
            .padding()
            ScrollView {
                LazyVGrid(columns: columnLayout) {
                    DetailAverageTokenView(thisWeekAverage: chartStore.sleepTimeAverage(of: chartStore.weekData[index].sleepData), lastWeekAverage: chartStore.sleepTimeAverage(of: chartStore.weekData[index+1].sleepData), name: .sleep)
                    DetailAverageTokenView(thisWeekAverage: chartStore.wakeUpTimeAverage(of: chartStore.weekData[index].wakeUpData), lastWeekAverage: chartStore.wakeUpTimeAverage(of: chartStore.weekData[index+1].wakeUpData), name: .wakeUp)
                    DetailDurationTokenView(thisWeekAverage:
                        chartStore.durationAverage(of:
                        chartStore.weekData[index].weekSleep) , name: .wakeUp)
                }
            }
        }
        .onAppear{
            chartStore.updateEveryData(to: sleepStore.sleepData)
        }
    }
}

struct DetailAverageTokenView: View {
    
    var thisWeekAverage: Date
    var lastWeekAverage: Date
    var name: SelectState

    let sleepStore = SleepStore()
    let chartStore = ChartStore()
    
    var body: some View {
        ZStack(alignment: .leading) {
            K.Colors.chartDetailToeknViewBackground
            VStack(alignment: .leading) {
                HStack {
                    Text("\(sleepStore.hourMinuteFormatted(thisWeekAverage))")
                    switch name {
                    case .wakeUp:
                        Image(systemName: "sun.horizon.fill")
                            .tint(.yellow)
                    case .sleep:
                        Image(systemName: "moon.fill")
                            .tint(.yellow)
                    }
                } //Average
                    .font(.system(size: 30))
                Text("Average \(name.Upper) Time") //Wake Up time or Sleep time
                Text("\(chartStore.compareAverageResult(result: chartStore.compareAverageTimes(thisWeekAverage, lastWeekAverage)))")
            }
            .padding()
        }
        .frame(height: 150)
        .padding()
        .cornerRadius(20)
    }
}

struct DetailDurationTokenView: View {
    
    var thisWeekAverage: Double
    //var lastWeekAverage: Double
    var name: SelectState
    
    let sleepStore = SleepStore()
    
    var body: some View {
        ZStack(alignment: .leading) {
            K.Colors.chartDetailToeknViewBackground
            VStack(alignment: .leading) {
                Text("\(Int(thisWeekAverage)/3600)H : \((Int(thisWeekAverage)%3600)/60)M") //Average
                    .font(.system(size: 30))
                Text("Sleep Duration Average") //Wake Up time or Sleep time
                //Text("(H,M shorter or longer ) than last week")
            }
            .padding()
        }
        .frame(height: 150)
        .padding()
        .cornerRadius(20)
    }
}

enum SelectState: String {
    case  wakeUp, sleep
    
    var Upper: String {
        switch self {
            
        case .wakeUp:
            "Wake Up"
        case .sleep:
            "Sleep"
        }
    }
    
}

#Preview {
    WeekCompareDetail()
}
