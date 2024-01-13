
import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var sleepStore: SleepStore
    @State private var isShownSheet: Bool = false
    @State private var selected: Sleep.ID?
    
    var body: some View {
        NavigationStack {
            VStack {
                SleepDataTableView(selected: $selected)
            }
            .toolbar {
                Button {
                    sleepStore.deleteSleepData(sleep: selected)
                    selected = nil
                } label: {
                    Label("Delete Selected Data", systemImage: "trash")
                }
                .disabled(selected == nil)
                
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
    
    @EnvironmentObject private var sleepStore: SleepStore
    
    @Binding var selected: Sleep.ID?
    
    var body: some View {
        VStack {
            Table(sleepStore.sleepData, selection: $selected) {
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
