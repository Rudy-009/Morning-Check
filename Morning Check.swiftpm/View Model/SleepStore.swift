
import SwiftUI

class SleepStore: ObservableObject, Observable {
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    
    @Published var sleepData: [Sleep] = []
    @Published var targetWakeUpTime: Date = Date()
    
    var targetWakeUpTimeHourMinute: String {
        return ""
    }
    
    var targetMarkWakeUp: Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: targetWakeUpTime)
        return Calendar.current.date(from: DateComponents( hour: dateComponents.hour, minute: dateComponents.minute)) ?? Date()
    }
    
    var targetMarkSleep: Date {
        return Date(timeInterval: -(9*60*60), since: targetMarkWakeUp)
    }
    
    init() {
        targetWakeUpTime = loadTargetdateFromUserDefaults()
    }
    
    func addSleepData (sleep: Sleep) {
        sleepData.append(sleep)
        sleepData.sort{$0.sleepDate > $1.sleepDate}
        saveSleepDataToUserDefaults()
    }
    
    func deleteSleepData (sleep: Sleep.ID?) {
        sleepData.removeAll{ $0.id == sleep }
        sleepData.sort{$0.sleepDate > $1.sleepDate}
        saveSleepDataToUserDefaults()
    }
    
    func deleteSleepDatas (sleeps: [Sleep]) {
        for s in sleeps {
            sleepData.removeAll{ $0.id == s.id }
        }
        sleepData.sort{$0.sleepDate > $1.sleepDate}
        saveSleepDataToUserDefaults()
    }
    
    func updateSleepData (sleep: Sleep) {
        sleepData.removeAll{ $0.id == sleep.id}
        sleepData.sort{$0.sleepDate > $1.sleepDate}
        saveSleepDataToUserDefaults()
    }
    
    func sleepDurationIs (sleep sleepDate: Date, wake wakeUpDate: Date ) -> Int {
        
        let duration = Int(wakeUpDate.timeIntervalSince(sleepDate))
        
        return duration
    }
    
    func noMoreOptional() {
        for index in 0...sleepData.count-1 {
            sleepData[index].distruptors = []
            sleepData[index].awakes = 0
        }
        saveSleepDataToUserDefaults()
    }
    
    func contains(where date: Date) -> Date? {
        return nil
    }
    
}

extension SleepStore { //For Sleep DateFormat
    
    func returnFormatted(_ date: Date) -> String {
        
        dateFormatter.dateFormat = "M-d HH:mm a"
        
        return dateFormatter.string(from: date)
    }
    
    func hourMinuteFormatted(_ date: Date)  -> String {
        
        dateFormatter.dateFormat = "HH:mm a"
        
        return dateFormatter.string(from: date)
    }
}

extension SleepStore { //For Edge Case
    
    func isNotOverlapped(new: Sleep) -> Bool {
        
        if sleepData.isEmpty { return true }
        let sortedSleepData = (sleepData + [new]).sorted { $0.sleepDate > $1.sleepDate }
        guard let newIndex = sortedSleepData.firstIndex(where: { $0.id == new.id }) else { return false }
        //Cheat Sheet :
        //Date : next.sleepDate > new.wakeUpDate > new.sleepDate > previous.wakeUpDate
        //Index : [..., next, new, previous, ...] = [new-1, new, new+1]
        let nextSleep = newIndex > 0 ? sortedSleepData[newIndex - 1] : nil
        let previousSleep = newIndex < sortedSleepData.count - 1 ? sortedSleepData[newIndex + 1] : nil
        
        if let pS = previousSleep, let nS = nextSleep { //[..., next, new, previous, ...]
            return pS.wakeUpDate < new.sleepDate && new.wakeUpDate < nS.sleepDate
        } else if let pS = previousSleep { //[new, previous, ...]
            return pS.wakeUpDate < new.sleepDate
        } else if let nS = nextSleep { //[..., next, new]
            return new.wakeUpDate < nS.sleepDate
        } else {
            return false
        }
    }
}

extension SleepStore { //For UserDefault
    
    func loadSleepDatasFromUserDefaults() -> [Sleep] {
        if let savedData = UserDefaults.standard.object(forKey: "SleepDatas") as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode([Sleep].self, from: savedData) {
                return savedObject
            } else {
                print("Error while decode to [Sleep]")
            }
        } else {
            print("Error while decode to Sleep Data")
        }
        return []
    }
    
    func saveSleepDataToUserDefaults() {
        let encoder = JSONEncoder()
        /// encoded is Data format
        if let encoded = try? encoder.encode(self.sleepData) {
            UserDefaults.standard.setValue(encoded, forKey: "SleepDatas")
        }
        //print("Save SleepData Succeed \(self.sleepData)")
    }
    
    func loadTargetdateFromUserDefaults() -> Date {
        if let savedData = UserDefaults.standard.object(forKey: "TargetDate") as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode(Date.self, from: savedData) {
                return savedObject
            } else {
                print("Error while decode to [Sleep]")
            }
        } else {
            print("Error while decode to Target Data")
        }
        return Date()
    }
    
    func saveTargetDateToUserDefaults() {
        let encoder = JSONEncoder()
        /// encoded is Data format
        if let encoded = try? encoder.encode(self.targetWakeUpTime) {
            UserDefaults.standard.setValue(encoded, forKey: "TargetDate")
        }
    }
    
    func getSleepDataFromUserDefaults() {
        self.sleepData = loadSleepDatasFromUserDefaults()
    }
    
    func getTargetDateFromUserDefaults() {
        self.targetWakeUpTime = loadTargetdateFromUserDefaults()
    }
    
    
    func getAllDataFromUserDefaults() {
        getSleepDataFromUserDefaults()
        getTargetDateFromUserDefaults()
    }
    
}

extension SleepStore { //For Compare
    
    func editTargetWakeUpTime(_ date: Date) {
        
        var targetComponents = calendar.dateComponents([.hour, .minute], from: targetWakeUpTime)
        let components = calendar.dateComponents([.hour, .minute], from: date)
        
        targetComponents.hour = components.hour
        targetComponents.minute = components.minute
        
        targetWakeUpTime = calendar.date(from: targetComponents) ?? Date()
        saveTargetDateToUserDefaults()
    }
    
    func isBefore(_ date: Date) -> Bool {
        let targetComponents = calendar.dateComponents([.hour, .minute], from: targetWakeUpTime)
        let wakeUpComponents = calendar.dateComponents([.hour, .minute], from: date)
        
        if let tH = targetComponents.hour, let wH = wakeUpComponents.hour,
           let tM = targetComponents.minute, let wM = wakeUpComponents.minute
        {
            if wH < tH || (wH == tH && wM <= tM) {
                return true
            }
        }
        else {
            print("nil was found from dateComponents!! Store.swift")
        }
        
        return false
    }
    
}
