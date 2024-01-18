
import Foundation

class SleepStore: ObservableObject, Observable {
    let calendar = Calendar.current
    
    @Published var sleepData: [Sleep] = []
    @Published var targetWakeUpTime: Date = Date()
    
    init() {
        var components = DateComponents()
        components.hour = 10
        components.minute = 0
        targetWakeUpTime = calendar.date(from: components) ?? Date()
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
            print("Error while decode to Data")
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
    
    func getSleepDataFromUserDefaults() {
        self.sleepData = loadSleepDatasFromUserDefaults()
        //print("Result : \(self.sleepData)")
    }
    
}

extension SleepStore { //For Compare
    
    func editTargetWakeUpTime(_ date: Date) {
        
        var targetComponents = calendar.dateComponents([.hour, .minute], from: targetWakeUpTime)
        let components = calendar.dateComponents([.hour, .minute], from: date)
        
        targetComponents.hour = components.hour
        targetComponents.minute = components.minute
        
        targetWakeUpTime = calendar.date(from: targetComponents) ?? Date()
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
