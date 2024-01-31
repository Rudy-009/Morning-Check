//
//  File.swift
//  
//
//  Created by 이승준 on 1/30/24.
//

import SwiftUI
import NotificationCenter

class ResetBedStore: ObservableObject {
    
    let notiCenter = UNUserNotificationCenter.current()
    
    @Published var resetDate: Date = Date()
    
    func loadResetDate() -> Date {
        if let savedData = UserDefaults.standard.object(forKey: "resetDate") as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode(Date.self, from: savedData) {
                return savedObject
            } else {
                print("Error while decode to [Sleep]")
            }
        } else {
            print("Error while decode to Target Data")
        }
        
        let temp = Date().addingTimeInterval(60*60*3)
        return Date() //Tomorrow
    }
    
    func saveResetDate() {
        let encoder = JSONEncoder()
        /// encoded is Data format
        if let encoded = try? encoder.encode(self.resetDate) {
            UserDefaults.standard.setValue(encoded, forKey: "resetDate")
        }
    }
    
    func getIsBedCleanFromUserDefaults() {
        self.resetDate = loadResetDate()
    }
    
    func firstCleanBedNotification() {
        let title: String = K.NotificationMessage.cleanBedTitle
        let subtitle: String = K.NotificationMessage.cleanBedSubtitle
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound.defaultRingtone
        
        var dateComponent = Calendar.current.dateComponents([.day, .hour, .minute], from: Date())
        dateComponent.minute! += 10
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let request = UNNotificationRequest(identifier: K.NotificationMessage.cleanBedIdentifier, content: content, trigger: trigger)
        
        notiCenter.add(request)
    }
    
    func AddCleanBedNotification() { // User Pressed "Yes" about clean own bedroom
        //No Alarm Repeat
        let title: String = K.NotificationMessage.cleanBedTitle
        let subtitle: String = K.NotificationMessage.cleanBedSubtitle
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound.defaultRingtone
        
        var dateComponent = Calendar.current.dateComponents([.day], from: Date())
        dateComponent.day! += 28
        dateComponent.hour = 10
        dateComponent.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let request = UNNotificationRequest(identifier: K.NotificationMessage.cleanBedIdentifier, content: content, trigger: trigger)
        
        notiCenter.add(request)
    }
    
    func deleteCleanBedNotification() {
        notiCenter.removeDeliveredNotifications(withIdentifiers: [K.NotificationMessage.cleanBedIdentifier])
    }
    
    func resetedBedToday() {
        var dateComponent = Calendar.current.dateComponents([.year, .month,.day, .hour, .minute], from: Date())
        dateComponent.day! += 28
        dateComponent.hour = 10
        dateComponent.minute = 0
        self.resetDate = date(year: dateComponent.year!, month: dateComponent.month!, day: dateComponent.day!, hour: dateComponent.hour!, min: dateComponent.minute!)
        deleteCleanBedNotification()
        AddCleanBedNotification()
    }
    
    func startObject() {
        getIsBedCleanFromUserDefaults()
        firstCleanBedNotification()
    }
    
    func getColor() -> Color {
        if Date() > resetDate {
            return Color.red
        } else {
            return Color.accentColor
        }
    }
}
