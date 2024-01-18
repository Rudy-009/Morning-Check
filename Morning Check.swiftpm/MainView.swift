
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
                TableColumn("Quality") { sleep in
                    if selected != sleep.id {
                        Text("\(sleep.sleepQuality.rawValue)")
                            .foregroundStyle(qColor(sleep.sleepQuality))
                    } else {
                        Text("\(sleep.sleepQuality.rawValue)")
                            .foregroundStyle(.white)
                    }
                }
                TableColumn("Sleep") { sleep in
                    if selected != sleep.id {
                        Text("\(sleep.sleepDate.formatted(date: .numeric, time: .shortened))")
                    } else {
                        Text("\(sleep.sleepDate.formatted(date: .numeric, time: .shortened))")
                            .foregroundStyle(.white)
                    }
                }
                TableColumn("WakeUp") { sleep in
                    if selected != sleep.id {
                        Text("\(sleep.wakeUpDate.formatted(date: .numeric, time: .shortened))"+"\(sleepStore.isBefore(sleep.wakeUpDate) ? "🏆" : "")")
                    } else {
                        Text("\(sleep.wakeUpDate.formatted(.dateTime))"+"\(sleepStore.isBefore(sleep.wakeUpDate) ? "🏆" : "")")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
    
    func qColor(_ q: SleepQuality)-> Color {
        switch q {
        case .Refreshed:
            return .blue
        case .Invigorated:
            return .green
        case .Groggy:
            return .yellow
        case .Sluggish:
            return .orange
        case .Unrested:
            return .red
        }
    }
    
}
