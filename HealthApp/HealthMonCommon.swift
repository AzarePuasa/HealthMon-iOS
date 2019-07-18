//
//  ApptDataController.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 28/5/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import Foundation

class HealthMonCommon {
   
    enum DATETIMEINFO {
        case date
        case time
    }
    
    static func dateToday(type: DATETIMEINFO) -> String{
        
        let now = Date()
        
        let dff = DateFormatter()
        dff.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dff.locale = Locale(identifier: "en_US_POSIX")
        var dtNow: [String] = dff.string(from: now).components(separatedBy: " ")
        
        if (type == DATETIMEINFO.date) {
            return dtNow[0]
        }
        
        return dtNow[1]
    }
    
    func convertToDate(dateString: String, timeString: String) -> Date {
        let dateFormatter = DateFormatter()
        
        let dateToConvert = "\(dateString) \(timeString)"
        
        print("dateToConvert: \(dateToConvert)")
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let date = dateFormatter.date(from: dateToConvert) else {
            fatalError("Fail to convert String to Date ⚠️")
        }
        
        return date
    }
}
