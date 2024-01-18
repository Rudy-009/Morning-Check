
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
        }
    }
}
