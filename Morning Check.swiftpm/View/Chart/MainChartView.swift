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
    
    var body: some View {
        ScrollView {
            BasicChartView()
                .padding()
            DurationAndQualityView()
                .padding()
        }
    }
}


#Preview {
    MainChartView()
        .environmentObject(SleepStore())
}
