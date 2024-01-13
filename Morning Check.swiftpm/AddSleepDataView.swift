
import SwiftUI

struct AddSleepDataView: View {
    
    let pages: Int = 3
    
    @EnvironmentObject private var sleepStore: SleepStore
    @State private var tabIndex: Int = 0
    @State private var isShowCompareAlert: Bool = false
    @State private var isShowNonlogicalAlert: Bool = false
    @Binding var isShownSheet: Bool
    @State var sleepDate: Date = Calendar.current.date(byAdding: .day, value: -1, to: Date())! //Yesterday
    @State var wakeUpDate: Date = Date() //Today
    @State var sleepQuality: SleepQuality?
    
    var isPreviousAble: Bool {
        get {
            if tabIndex > 0 {
                return false
            } else {
                return true
            }
        }
    }
    
    var isDoneAble: Bool {
        get {
            if sleepQuality != nil { //모든 정보가 잘 받아졌다는 가정 하에
                return false
            } else {
                return true
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $tabIndex){
                SleepDateSelectionView(sleepDate: $sleepDate).tag(0)
                WakeUpDateSelectionView(wakeUpDate: $wakeUpDate).tag(1)
                SleepQualitySelectionView(sleepQuality: $sleepQuality).tag(2)
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) { // <-
                    Button("Previous") {
                        tabIndex -= 1
                    }
                    .disabled(isPreviousAble)
                    if tabIndex != pages - 1 {
                        Button("Next") {
                            if sleepDate >= wakeUpDate {
                                //Alert
                                isShowCompareAlert = true
                            } else {
                                tabIndex += 1
                            }
                        }
                    } else {
                        Button("Done") {
                            //Save at store
                            //if sleep time is available
                            if sleepStore.isNotOverlapped(new: Sleep(sleepDate: sleepDate, wakeUpDate: wakeUpDate, sleepQuality: sleepQuality ?? .Refreshed)) {
                               sleepStore.addSleepData( sleep: Sleep(sleepDate: sleepDate, wakeUpDate: wakeUpDate, sleepQuality: sleepQuality ?? .Refreshed))
                                sleepStore.saveSleepDataToUserDefaults()
                                //Pop sheet
                                isShownSheet = false
                            } else {
                                isShowNonlogicalAlert = true
                                tabIndex = 0
                            }
                        }
                        .disabled(isDoneAble)
                    }
                }
            }
            .alert(isPresented: $isShowCompareAlert) {
                Alert(
                    title: Text("Time Error!"),
                    message: Text("Sleep time is later than Wake Up Time. Please Check your time again")
                )
            }
            .alert(isPresented: $isShowNonlogicalAlert) {
                Alert( title: Text("Overlap Detected"),
                    message: Text("New sleep entry conflicts with previous records. Please Check your time again"))
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
        }
    }
}

struct WakeUpDateSelectionView: View {
    
    @Binding var wakeUpDate: Date
    var dateRange: ClosedRange<Date> {
        //Last Year to Today
        let min = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
        return min...Date()
    }
    
    var body: some View {
        VStack {
            Text("Select WakeUp Day and Time")
                .font(.largeTitle)
                .padding([.bottom], 200)
            VStack {
                DatePicker(
                    "",
                    selection: $wakeUpDate,
                    in: dateRange,
                    displayedComponents: .date)
                .datePickerStyle(.graphical)
                HStack{
                    Spacer()
                    DatePicker.init(selection: $wakeUpDate, displayedComponents: .hourAndMinute, label: {
                        EmptyView()
                    })
                    .labelsHidden().datePickerStyle(WheelDatePickerStyle())
                    Spacer()
                }
            }
        }
    }
}

struct SleepDateSelectionView: View {
    
    @Binding var sleepDate: Date
    
    var dateRange: ClosedRange<Date> {
        //Last Year to Today
        let min = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
        return min...Date()
    }
    
    var body: some View {
        VStack {
            Text("Select Sleep Day and Time")
                .padding([.bottom], 200)
                .font(.largeTitle)
            VStack {
                DatePicker("", selection: $sleepDate, in: dateRange, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                HStack{
                    Spacer()
                    DatePicker.init(selection: $sleepDate, displayedComponents: .hourAndMinute, label: {
                        EmptyView()
                    })
                    .labelsHidden().datePickerStyle(WheelDatePickerStyle())
                    Spacer()
                }
            }
        }
    }
}


