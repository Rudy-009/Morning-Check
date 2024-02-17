//
//  File.swift
//  
//
//  Created by 이승준 on 1/30/24.
//

import Foundation
import SwiftUI

struct K {
    
    struct NotificationMessage {
        static let basicTitle = "Good Morning!"
        
        static let basicText = "Time to Record Your Wake-up and Sleep Time"
        
        static let cleanBedTitle = "Renew Bedding, Sleep Better!"
        
        static let cleanBedSubtitle = "Time to wash your sheets and pillowcases for optimal sleep quality. 🌙🛌"
        
        static let cleanBedIdentifier = "cleanBedIdentifier"
    }
    
    struct BedSanitaion {
        
    }
    
    struct AlertMessage {
        static let haveYouDone =  "Have you done your bedding laundry"
    }
    
    struct Chart {
        static let basicHeight: CGFloat = 200
        
        static let detailHeight: CGFloat = 400
    }
    
    struct Font {
        static let weekCompareDetailButtonSize: CGFloat = 50
        
        static let weekCompareDetailTitleSize: CGFloat = 50
        
    }
    
    struct Colors {
        static let chartDetailToeknViewBackground = Color("detailBackground")
    }
}
