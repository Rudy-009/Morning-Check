
import SwiftUI

@main
struct MyApp: App {
    
    let sleepStore = SleepStore()
    let chartStore = ChartStore()
    let noticenter = NotificationManager()
    let resetBedStore = ResetBedStore()
    
    var body: some Scene {
        WindowGroup {
            MainSplitView()
                .environmentObject(sleepStore)
                .environmentObject(noticenter)
                .environmentObject(chartStore)
                .environmentObject(resetBedStore)
                .onAppear{
                    sleepStore.getAllDataFromUserDefaults()
                    //print(sleepStore.loadSleepDatasFromUserDefaults())
                    noticenter.requestNotiAuthorization()
                    chartStore.updateEveryData(to: sleepStore.sleepData)
                    resetBedStore.startObject()
                }
        }
    }
}

