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
            
            Chart{
                ForEach(chartStore.durationAndQualityArray){ token in
                    
                    // 시:분 형식으로 시간을 나타내기 위한 코드
                    BarMark(
                        x: .value("Quality", token.quality),
                        y: .value("Average", token.average)
                    )
                    .foregroundStyle(qualityColor(token.quality))
                }
            }
            .chartPlotStyle { plotArea in
                plotArea.frame(height: 200)
            }
            
            Chart{
                ForEach(chartStore.durationAndQualityArray){ token in
                    PointMark (
                        x: .value("Quality", token.quality ) ,
                        y: .value("Average",  token.average)
                    )
                    .foregroundStyle(qualityColor(token.quality))
                }
            }
            .chartPlotStyle { plotArea in
                plotArea.frame(height: 200)
            }
        }
    }
}

#Preview {
    DurationAndQualityView()
}
