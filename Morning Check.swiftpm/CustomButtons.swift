//
//  CustomNextButton.swift
//  Morning Check
//
//  Created by 이승준 on 1/13/24.
//

import SwiftUI

struct CustomPreviousButton: View {
    
    @Binding var tabIndex: Int
    
    var isPreviousAble: Bool {
        get {
            if tabIndex > 0 {
                return false
            } else {
                return true
            }
        }
    }
    
    var body: some View {
        Button("Previous") {
            tabIndex -= 1
        }
        .disabled(isPreviousAble)
    }
}

struct CustomNextButton: View {
    
    var sleepDate: Date
    var wakeUpDate: Date
    
    @Binding var alert: Bool
    @Binding var tabIndex: Int
    
    var body: some View {
        Button("Next") {
            if sleepDate >= wakeUpDate {
                //Alert
                alert = true
            } else {
                tabIndex += 1
            }
        }
    }
}

struct CustomDoneButton: View {
    
    @EnvironmentObject private var sleepStore: SleepStore
    
    @Binding var sheet: Bool
    @Binding var alert: Bool
    @Binding var tabIndex: Int
    @Binding var sleepQuality: SleepQuality?
    
    var isDoneAble: Bool {
        get {
            if sleepQuality != nil { //모든 정보가 잘 받아졌다는 가정 하에
                return false
            } else {
                return true
            }
        }
    }
    
    var sleep: Sleep
    
    var body: some View {
        Button("Done") {
            //Save at store
            //if sleep time is available
            if sleepStore.isNotOverlapped(new: sleep) {
               sleepStore.addSleepData( sleep: sleep)
                sleepStore.saveSleepDataToUserDefaults()
                //Pop sheet
                sheet = false
            } else {
                alert = true
                tabIndex = 0
            }
        }
        .disabled(isDoneAble)
    }
}
