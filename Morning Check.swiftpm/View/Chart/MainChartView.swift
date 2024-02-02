//
//  SwiftUIView.swift
//
//
//  Created by 이승준 on 1/22/24.
//

import SwiftUI
import Charts

struct MainChartView: View {
    
    @EnvironmentObject private var sleepStore: SleepStore
    @EnvironmentObject private var chartStore: ChartStore
    
    private enum Destinations {
        case empty
        case weekCompare
    }
    
    @State private var selection: Destinations?
    
    var body: some View {
        VStack {
            ScrollView {
                BasicChartView()
                    .padding()
                HStack {
                    DistruptorsAndQualityView()
                        .padding()
                    WeekComparePreview()
                        .padding()
                }
            }
        }
        .onAppear{
            chartStore.updateDistruptorsAndQuality()
            chartStore.updateEveryData(to: sleepStore.sleepData)
        }
    }
}


#Preview {
    MainChartView()
        .environmentObject(SleepStore())
}
