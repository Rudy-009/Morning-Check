
import SwiftUI

@main
struct MyApp: App {
    
    let sleepStore = SleepStore()
    let chartStore = ChartStore()
    let noticenter = NotificationManager()
    
    var body: some Scene {
        WindowGroup {
            MainSplitView()
                .environmentObject(sleepStore)
                .environmentObject(noticenter)
                .environmentObject(chartStore)
                .onAppear{
                    sleepStore.getSleepDataFromUserDefaults()
                    sleepStore.getTargetDateFromUserDefaults()
                    //print(sleepStore.loadSleepDatasFromUserDefaults())
                    noticenter.requestNotiAuthorization()
                    chartStore.updateEveryData(to: sleepStore.sleepData)
            }
        }
    }
}
