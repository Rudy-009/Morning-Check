
import SwiftUI

@main
struct MyApp: App {
    
    let sleepStore = SleepStore()
    let noticenter = NotificationManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(sleepStore)
                .environmentObject(noticenter)
                .onAppear{
                    sleepStore.getSleepDataFromUserDefaults()
                    sleepStore.getTargetDateFromUserDefaults()
                    print(sleepStore.loadSleepDatasFromUserDefaults())
                    noticenter.requestNotiAuthorization()
            }
        }
    }
}
