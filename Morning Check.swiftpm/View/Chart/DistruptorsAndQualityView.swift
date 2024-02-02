//
//  SwiftUIView.swift
//  
//
//  Created by 이승준 on 1/25/24.
//

import SwiftUI
import Charts

struct DistruptorsAndQualityView: View {
    
    @EnvironmentObject private var sleepStore: SleepStore
    @EnvironmentObject private var chartStore: ChartStore
    
    var body: some View {
        VStack {
            Text("Correlation with Distruptors and Sleep Quality")
                .font(.title2.bold())
                .foregroundColor(.primary)
            Chart {
                ForEach(chartStore.distruptorAndQualityArray) { token in
                    BarMark(
                        x: .value("average", token.averageByDistruptors),
                        y: .value("distruptors", token.distruptor.rawValue + " " + token.distruptor.emoji)
                    )
                    .foregroundStyle(qualityColorDouble(token.averageByDistruptors))
                }
            }
            .chartXScale(domain: 0.0...4.0)
            .chartPlotStyle { plotArea in
                plotArea.frame(height: 200)
            }
            Text(" ")
            Text(" ")
        }
    }
}

func qualityColorDouble(_ num: Double) -> Color {
    switch num {
    case 0.0..<1.0:
        return Color("darkMode")
    case 1.0..<2.0:
        return .red
    case 2.0..<3.0:
        return .yellow
    case 3.0..<4.0:
        return .green
    case 4.0:
        return .blue
    default:
        return .black
    }
}

#Preview {
    DistruptorsAndQualityView()
}
