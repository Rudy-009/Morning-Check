//
//  SwiftUIView.swift
//
//
//  Created by 이승준 on 1/25/24.
//

import SwiftUI

enum RootScreen: String {
    case table
    case chart
    
    var title: String {
        rawValue.capitalized
    }
}

struct MainSplitView: View {
    
    @State private var selection: RootScreen? = .table
    
    var body: some View {
        NavigationSplitView {
            sidebarContent
        } detail: {
            detailContent
        }
        .accentColor(.accentColor)
        .navigationSplitViewStyle(.prominentDetail)
    }
}

extension MainSplitView {

    var sidebarContent: some View {
        List(selection: $selection) {
            link(to: .table)
            link(to: .chart)
        }
    }

    func link(to page: RootScreen) -> some View {
        NavigationLink(value: page) {
            Text(page.title)
        }
    }
}

extension MainSplitView {

    @ViewBuilder
    var detailContent: some View {
        if let selection = selection {
            detailContent(for: selection)
        } else {
            Text("Nothing Selected")
        }
    }

    @ViewBuilder
    func detailContent(for screen: RootScreen) -> some View {
        switch screen {
        case .table: MainTableView()
        case .chart: MainChartView()
        }
    }
}
