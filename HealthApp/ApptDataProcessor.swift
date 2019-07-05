//
//  ApptDataProcessor.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 5/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import Foundation

class ApptDataProcessor {
    
    static func mapJsonToAppointment(object: [[String: AnyObject]]) -> [Appointment] {
        var mappedAppts: [Appointment] = []
        
        guard let appts = object as? [[String: AnyObject]] else { return mappedAppts }
        
        for appt in appts {
            guard let id = appt["id"] as? Int,
                let datetime = appt["datetime"] as? String,
                let location = appt["location"] as? String,
                let purpose = appt["purpose"] as? String else { continue }
            
            print("Id: \(id) \nDate/Time: \(datetime) \nLocation: \(location) \nPurpose: \(purpose)\n")
            
            //Seperate date time.
            let datetimeArr = datetime.components(separatedBy: " ")
            let date = datetimeArr[0]
            let time = datetimeArr[1]
            
            let apptClass = Appointment(id: id, dateOfAppt: date, timeOfAppt: time, location: location, purpose: purpose)
            
            mappedAppts.append(apptClass)
        }
        return mappedAppts
    }
    
    static func write(Appointments: [Appointment]) {
        // TODO: Implement :)
    }
}
