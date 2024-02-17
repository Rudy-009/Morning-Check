//
//  File.swift
//  
//
//  Created by 이승준 on 2/16/24.
//

import SwiftUI

let tempSleepData: [Sleep] = [
    Sleep(sleepDate: date(year: 2024, month: 2, day: 16, hour: 04, min: 13),
          wakeUpDate: date(year: 2024, month: 2, day: 16, hour: 12, min: 06),
          sleepQuality: 4, distruptors: [.phone], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 2, day: 15, hour: 02, min: 20),
          wakeUpDate: date(year: 2024, month: 2, day: 15, hour: 09, min: 08),
          sleepQuality: 4, distruptors: [.phone], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 2, day: 14, hour: 02, min: 20),
          wakeUpDate: date(year: 2024, month: 2, day: 14, hour: 08, min: 37),
          sleepQuality: 4, distruptors: [.phone], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 2, day: 13, hour: 02, min: 20),
          wakeUpDate: date(year: 2024, month: 2, day: 13, hour: 10, min: 06),
          sleepQuality: 4, distruptors: [.phone], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 2, day: 12, hour: 03, min: 28), 
          wakeUpDate: date(year: 2024, month: 2, day: 12, hour: 09, min: 00),
          sleepQuality: 4, distruptors: [.phone, .caffein], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 2, day: 11, hour: 02, min: 04), 
          wakeUpDate: date(year: 2024, month: 2, day: 11, hour: 09, min: 04),
          sleepQuality: 4, distruptors: [], awakes: 0),
    //:------------------------------------------://
    Sleep(sleepDate: date(year: 2024, month: 2, day: 10, hour: 02, min: 04), 
          wakeUpDate: date(year: 2024, month: 2, day: 10, hour: 12, min: 04),
          sleepQuality: 1, distruptors: [.phone, .alcohol], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 2, day: 09, hour: 04, min: 27), 
          wakeUpDate: date(year: 2024, month: 2, day: 09, hour: 07, min: 02),
          sleepQuality: 1, distruptors: [.phone, .energyDrink], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 2, day: 08, hour: 02, min: 03), 
          wakeUpDate: date(year: 2024, month: 2, day: 08, hour: 10, min: 03),
          sleepQuality: 3, distruptors: [], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 2, day: 07, hour: 01, min: 03), 
          wakeUpDate: date(year: 2024, month: 2, day: 07, hour: 09, min: 03),
          sleepQuality: 2, distruptors: [], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 2, day: 06, hour: 02, min: 15), 
          wakeUpDate: date(year: 2024, month: 2, day: 06, hour: 10, min: 21),
          sleepQuality: 3, distruptors: [.caffein, .phone], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 2, day: 05, hour: 04, min: 17), 
          wakeUpDate: date(year: 2024, month: 2, day: 05, hour: 11, min: 06),
          sleepQuality: 2, distruptors: [.snack, .alcohol, .phone], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 2, day: 04, hour: 02, min: 07), 
          wakeUpDate: date(year: 2024, month: 2, day: 04, hour: 10, min: 44),
          sleepQuality: 1, distruptors: [.phone, .alcohol], awakes: 0),
    
    //:-------------------------------------------://
    
    Sleep(sleepDate: date(year: 2024, month: 2, day: 03, hour: 04, min: 38),
          wakeUpDate: date(year: 2024, month: 2, day: 03, hour: 11, min: 56),
          sleepQuality: 2, distruptors: [], awakes: 0),
    
    Sleep(sleepDate: date(year: 2024, month: 2, day: 02, hour: 03, min: 30),
          wakeUpDate: date(year: 2024, month: 2, day: 02, hour: 11, min: 35),
          sleepQuality: 2, distruptors: [.phone, .snack, .energyDrink], awakes: 0),
    
    Sleep(sleepDate: date(year: 2024, month: 2, day: 01, hour: 01, min: 03),
          wakeUpDate: date(year: 2024, month: 2, day: 01, hour: 09, min: 03),
          sleepQuality: 2, distruptors: [.phone, .snack, .caffein], awakes: 0),
    
    Sleep(sleepDate: date(year: 2024, month: 1, day: 31, hour: 03, min: 12),
          wakeUpDate: date(year: 2024, month: 1, day: 31, hour: 09, min: 17),
          sleepQuality: 1, distruptors: [.caffein, .phone], awakes: 0),
    
    Sleep(sleepDate: date(year: 2024, month: 1, day: 30, hour: 03, min: 32),
          wakeUpDate: date(year: 2024, month: 1, day: 30, hour: 10, min: 00),
          sleepQuality: 2, distruptors: [.snack, .alcohol, .phone], awakes: 0),
    
    Sleep(sleepDate: date(year: 2024, month: 1, day: 29, hour: 02, min: 08),
          wakeUpDate: date(year: 2024, month: 1, day: 29, hour: 09, min: 15),
          sleepQuality: 2, distruptors: [.phone], awakes: 0),
    
    Sleep(sleepDate: date(year: 2024, month: 1, day: 28, hour: 03, min: 10),
          wakeUpDate: date(year: 2024, month: 1, day: 28, hour: 11, min: 05),
          sleepQuality: 4, distruptors: [.snack, .caffein], awakes: 0),

    //:-------------------------------------------://
    
    Sleep(sleepDate: date(year: 2024, month: 01, day: 27, hour: 03, min: 25),
          wakeUpDate: date(year: 2024, month: 01, day: 27, hour: 10, min: 01),
          sleepQuality: 2, distruptors: [.snack, .caffein, .alcohol, .phone], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 01, day: 26, hour: 03, min: 13),
          wakeUpDate: date(year: 2024, month: 01, day: 26, hour: 11, min: 14),
          sleepQuality: 4, distruptors: [.snack, .energyDrink, .phone], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 01, day: 25, hour: 04, min: 35),
          wakeUpDate: date(year: 2024, month: 01, day: 25, hour: 09, min: 19),
          sleepQuality: 1, distruptors: [.snack], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 01, day: 23, hour: 23, min: 54),
          wakeUpDate: date(year: 2024, month: 01, day: 24, hour: 08, min: 17),
          sleepQuality: 4, distruptors: [.caffein, .light], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 01, day: 23, hour: 02, min: 02),
          wakeUpDate: date(year: 2024, month: 01, day: 23, hour: 09, min: 17),
          sleepQuality: 4, distruptors: [], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 01, day: 22, hour: 01, min: 12),
          wakeUpDate: date(year: 2024, month: 01, day: 22, hour: 09, min: 00),
          sleepQuality: 4, distruptors: [], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 01, day: 20, hour: 23, min: 15),
          wakeUpDate: date(year: 2024, month: 01, day: 21, hour: 08, min: 04),
          sleepQuality: 2, distruptors: [], awakes: 0),
    
    //:--------------------------------------------://
    
    Sleep(sleepDate: date(year: 2024, month: 01, day: 20, hour: 05, min: 13),
          wakeUpDate: date(year: 2024, month: 01, day: 20, hour: 13, min: 19),
          sleepQuality: 2, distruptors: [.meal, .caffein, .alcohol, .phone], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 01, day: 19, hour: 06, min: 19),
          wakeUpDate: date(year: 2024, month: 01, day: 19, hour: 13, min: 30),
          sleepQuality: 4, distruptors: [], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 01, day: 18, hour: 04, min: 12),
          wakeUpDate: date(year: 2024, month: 01, day: 18, hour: 09, min: 14),
          sleepQuality: 0, distruptors: [], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 01, day: 17, hour: 04, min: 25),
          wakeUpDate: date(year: 2024, month: 01, day: 17, hour: 09, min: 21),
          sleepQuality: 2, distruptors: [.meal, .light], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 01, day: 16, hour: 04, min: 20),
          wakeUpDate: date(year: 2024, month: 01, day: 16, hour: 12, min: 20),
          sleepQuality: 4, distruptors: [.phone, .meal, .caffein], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 01, day: 15, hour: 03, min: 36),
          wakeUpDate: date(year: 2024, month: 01, day: 15, hour: 12, min: 10),
          sleepQuality: 2, distruptors: [.phone, .alcohol, .caffein], awakes: 0),
    Sleep(sleepDate: date(year: 2024, month: 01, day: 14, hour: 04, min: 35),
          wakeUpDate: date(year: 2024, month: 01, day: 14, hour: 12, min: 10),
          sleepQuality: 4, distruptors: [], awakes: 0),
    
]

