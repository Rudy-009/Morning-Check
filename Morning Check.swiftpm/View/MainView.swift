
import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var sleepStore: SleepStore
    @State private var isShownSheet: Bool = false
    @State private var isShownGoalSheet: Bool = false
    @State private var selected: Sleep.ID?
    
    var body: some View {
        NavigationStack {
            VStack {
                SleepDataTableView(selected: $selected)
            }
            .toolbar {
                Button {
                    isShownGoalSheet = true
                } label: {
                    Label("Set Goal View", systemImage: "trophy")
                }
                .sheet(isPresented: $isShownGoalSheet) {
                    EditGoalView(goalDate: sleepStore.targetWakeUpTime, isShownGoalSheet: $isShownGoalSheet)
                }
                
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
                    SingleBattery(num: sleep.sleepQuality)
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
}
