
import SwiftUI

@main
struct MyApp: App {
    
    let sleepStore = SleepStore()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(sleepStore)
        }
    }
}
