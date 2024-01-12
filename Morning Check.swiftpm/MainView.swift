
import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var sleepStore: SleepStore
    @State private var isShownSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                SleepDataTableView(sleepData: $sleepStore.sleepData)
            }
            .toolbar {
                Button {
                    self.isShownSheet = true
                } label: {
                    Label("Add Sleep", systemImage: "plus")
                }
                .sheet(isPresented: $isShownSheet) {
                    AddSleepDataView(isShownSheet: $isShownSheet)
                }
                .presentationDetents([.medium, .large])
            }
            .onAppear{
                sleepStore.getSleepDataFromUserDefaults()
            }
        }
    }
}

struct SleepDataTableView: View {
    
    @Binding var sleepData: [Sleep]
    @State private var selected: Sleep.ID?
    
    var body: some View {
        VStack {
            Table(sleepData, selection: $selected) {
                TableColumn("Quality", value: \.sleepQuality.rawValue)
                TableColumn("Sleep") { sleep in
                    Text("\(sleep.sleepDate.formatted(date: .numeric, time: .shortened))")
                }
                TableColumn("WakeUp") { sleep in
                    Text("\(sleep.wakeUpDate.formatted(date: .numeric, time: .shortened))")
                }
            }
        }
    }
}
