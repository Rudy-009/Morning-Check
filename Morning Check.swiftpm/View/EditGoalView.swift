
import SwiftUI

struct EditGoalView: View {
    
    @EnvironmentObject private var sleepStore: SleepStore
    @EnvironmentObject private var notiManager: NotificationManager
    
    @State var goalDate: Date
    @Binding var isShownGoalSheet: Bool
    
    var body: some View {
        VStack {
            Text("Set a goal time to wake up.")
            DatePicker.init(selection: $goalDate, displayedComponents: .hourAndMinute, label: {
                EmptyView()
            })
            .labelsHidden().datePickerStyle(WheelDatePickerStyle())
            Button {
                sleepStore.editTargetWakeUpTime(goalDate)
                notiManager.addNotificationAtGoalTime(with: goalDate)
                isShownGoalSheet = false
            } label: {
                Text("Done")
            }

        }
    }
}

#Preview {
    EditGoalView(goalDate: Date(), isShownGoalSheet: .constant(false))
}
