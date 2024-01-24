
import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var sleepStore: SleepStore
    @EnvironmentObject private var noticenter: NotificationManager
    
    @State private var isShownSheet: Bool = false
    @State private var isShownGoalSheet: Bool = false
    @State private var isChartOpen: Bool = false
    @State private var selected: Sleep.ID?
    @State private var notificationToggle: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack {
                SleepDataTableView(selected: $selected.animation(.easeInOut))
            }
            .toolbar {
                Button {
                    isChartOpen = true
                } label: {
                    Label("Open Chart", systemImage: "chart.bar.xaxis.ascending.badge.clock")
                }
                .sheet(isPresented: $isChartOpen, content: {
                    SwiftChartsA()
                })
                
                Button { //Notification Toggle
                    notificationToggle.toggle()
                    if notificationToggle { //Add Notification Again
                        noticenter.addNotificationAtGoalTime(with: sleepStore.targetWakeUpTime)
                    } else { //Remove All Notification
                        noticenter.deleteAllNotifications()
                    }
                } label: {
                    Label("Notification Toggle", systemImage: notificationToggle ? "bell.fill" : "bell.slash")
                }
                
                Button { //Cancel Selection
                    selected = nil
                } label: {
                    Label("cancel selection", systemImage: "x.circle")
                }
                .disabled(selected == nil)
                
                Button { //Edit Goal Data
                    isShownGoalSheet = true
                } label: {
                    Label("Set Goal View", systemImage: "trophy")
                }
                .sheet(isPresented: $isShownGoalSheet) {
                    EditGoalView(goalDate: sleepStore.targetWakeUpTime, isShownGoalSheet: $isShownGoalSheet)
                }
                .presentationDetents([.medium])
                
                Button { //Delete Button
                    sleepStore.deleteSleepData(sleep: selected)
                    selected = nil
                } label: {
                    Label("Delete Selected Data", systemImage: "trash")
                }
                .disabled(selected == nil)
                
                Button { //Add Sleep Data Button
                    self.isShownSheet = true
                } label: {
                    Label("Add Sleep", systemImage: "plus")
                }
                .sheet(isPresented: $isShownSheet) {
                    AddSleepDataView(isShownSheet: $isShownSheet)
                }
                .presentationDetents([.medium, .large])
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
                    Text("\(sleepStore.returnFormatted(sleep.sleepDate))")
                        .foregroundStyle(selected == sleep.id ? .white : .gray)
                }
                TableColumn("WakeUp") { sleep in
                    Text("\(sleepStore.returnFormatted(sleep.wakeUpDate))"+"\(sleepStore.isBefore(sleep.wakeUpDate) ? "🏆" : "")")
                        .foregroundStyle(selected == sleep.id ? .white : .gray)
                }
                TableColumn("Duration") { sleep in
                    Text("\(sleep.sleepDurationHours)H : \(sleep.sleepDurationMinutes)M")
                }
                TableColumn("Distruptions") { sleep in
                    Text("\(sleep.emojis)")
                }
            }
        }
    }
}
