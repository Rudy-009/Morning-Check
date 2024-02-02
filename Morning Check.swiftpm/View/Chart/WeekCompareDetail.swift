//
//  SwiftUIView.swift
//  
//
//  Created by 이승준 on 2/1/24.
//

import SwiftUI

struct WeekCompareDetail: View {
    
    @EnvironmentObject private var sleepStore: SleepStore
    @EnvironmentObject private var chartStore: ChartStore
    
    @State var index: Int = 0
    @State var isLeftDisale: Bool = false
    @State var isRightDisale: Bool = true
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    if index == chartStore.weekData.count - 1 { 
                        isLeftDisale = true
                    } else {
                        index += 1
                        if index == chartStore.weekData.count - 1 {
                            isLeftDisale = true
                        }
                        isRightDisale = false
                    }
                } label: {
                    Image(systemName: "arrow.left.circle.fill")
                        .foregroundStyle(.primary)
                }
                .padding([.leading], 30)
                .disabled(isLeftDisale)

                Spacer()
                
                Text("\(chartStore.weekData[index].name)")
                
                Spacer()
                
                Button {
                    if index == 0 {
                        isRightDisale = true
                    } else {
                        index -= 1
                        if index == 0 {
                            isRightDisale = true
                        }
                        isLeftDisale = false
                    }
                } label: {
                    Image(systemName: "arrow.right.circle.fill")
                        .foregroundStyle(.primary)
                }
                .padding([.trailing], 30)
                .disabled(isRightDisale)
            }
            .frame(maxWidth: .infinity)
            
            
            
            ScrollView {
                WeekComparePreview()
            }
            
        }
    }
}

#Preview {
    WeekCompareDetail()
}
