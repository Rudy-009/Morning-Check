//
//  SwiftUIView.swift
//
//
//  Created by 이승준 on 1/25/24.
//

import SwiftUI
import Charts

struct DurationAndQualityView: View {
    
    @EnvironmentObject private var sleepStore: SleepStore
    @EnvironmentObject private var chartStore: ChartStore
    
    var body: some View {
        VStack {
            Text("Correlation with Duration and Quality")
            
            Chart {
                ForEach(chartStore.durationAndQualityArray) { token in
                    BarMark(
                        x: .value("Quality", token.quality),
                        y: .value("Average", token.average)
                    )
                    .foregroundStyle(qualityColor(token.quality))
                }
            }
            .chartPlotStyle { plotArea in
                plotArea.frame(height: K.Chart.basicHeight)
            }
            .chartYAxis {
                AxisMarks() { _ in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.month(.narrow), centered: true)
                }
            }
            .padding()
        }
    }
}

#Preview {
    DurationAndQualityView()
}
