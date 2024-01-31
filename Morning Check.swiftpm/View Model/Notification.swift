
import NotificationCenter

class NotificationManager : ObservableObject {
    
    let notiCenter = UNUserNotificationCenter.current()
    
    func requestNotiAuthorization() {
        notiCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined : //The app isn't authorized to schedule or receive notifications.
                //Ask Approvement
                self.notiCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if let error = error {
                        // Handle the error here.
                        print("Error : \(error.localizedDescription)")
                    }
                    
                    if granted { //Allowed
                        
                    } else {
                        
                    }
                    // Enable or disable features based on the authorization.
                }
            case .denied:
                break
            case .authorized: //Already Allowed
                break
            case .provisional: //The application is provisionally authorized to post noninterruptive user notifications.
                break
            case .ephemeral: //Limited by time duration
                //The app is authorized to schedule or receive notifications for a limited amount of time.
                break
            @unknown default:
                print("Unkown Error : settings.authorizationStatus has unkown value or nil")
            }
        }
    }
    
    func addNotification(with time: Date, title: String, subtitle: String) {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound.defaultRingtone
        
        let dateComponent = Calendar.current.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        // show this notification five seconds from now
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        notiCenter.add(request)
    }
    
    func deleteAllNotifications() {
        notiCenter.removeAllDeliveredNotifications()
    }
    
    func addNotificationAtGoalTime(with time: Date) {
        deleteAllNotifications()
        let title: String = K.NotificationMessage.basicTitle
        let subtitle: String = K.NotificationMessage.basicText
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound.defaultRingtone
        
        let dateComponent = Calendar.current.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        notiCenter.add(request)
        
        
    }
}
