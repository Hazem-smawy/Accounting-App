//
//  Utilies.swift
//  Accounting App
//
//  Created by B-ALDUAIS on 25/07/2023.
//

import SwiftUI


class Utilies {
    static func formattedValue(using value:Double)-> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 5
        return formatter.string(from: NSNumber(value: value)) ?? " "
    }
    
    
    static func formattedDate(date:Date) -> String {
        let dateFormatter :DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.locale = Locale(identifier: "en")
            formatter.dateFormat = "yyyy,MM,dd"
            return formatter
        }()
        return dateFormatter.string(from: date)
        
    }
    
    static func formattedTime(date:Date) -> String {
         let timeFormatter :DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            formatter.locale = Locale(identifier: "en")
            
            return formatter
        }()
        return timeFormatter.string(from: date)
        
    }
    
   
  
}


struct SnackBar {
    var message :String
    var color:Color
    var icon:String
}

class MoreWordUsed {
    static var edit:String = "تعد يل"
    static var add:String = "حفظ"
}
