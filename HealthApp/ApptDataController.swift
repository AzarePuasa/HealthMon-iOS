//
//  ApptDataController.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 28/5/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import Foundation

class ApptDataController {
    
    static var sharedInstance = ApptDataController()
    
    var appointments: [Appointment] = []
   
    enum DATETIMEINFO {
        case date
        case time
    }
    
    private init() {

    }
    
    func dateToday(type: DATETIMEINFO) -> String{
        
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
    
    func add(appointment: Appointment) {
        appointments.append(appointment)
    }
    
    func list() -> [Appointment] {
        return appointments
    }
    
    func getAppointment(id: Int) -> Appointment? {
        for appointment in appointments {
            if (appointment.id == id) {
                return appointment
            }
        }
        
        return nil
    }
    
    func updateAppointment(id: Int, new: Appointment) -> Bool {
        
        for appointment in appointments {
            if (appointment.id == id) {
                appointment.date = new.date
                appointment.time = new.time
                appointment.location = new.location
                appointment.purpose = new.purpose
                
                return true
            }
        }
        
        return false
    }
    
    //for each appointment, compare current date with
    //current date/time.
    //if later than current date/time, add to list
    var upcomingAppointments: [Appointment] {
        
        var upcomingAppts: [Appointment] = []
        
        let currentdate = Date()
        
        for appointment in appointments {
            let apptDateTime = convertToDate(dateString: appointment.date, timeString: appointment.time)
            
            if (apptDateTime > currentdate) {
                upcomingAppts.append(appointment)
                
                print("Upcoming: Date: \(dateToday(type: DATETIMEINFO.date)) time: \(dateToday(type: DATETIMEINFO.date))")
            }
        }
        
        return upcomingAppts
    }
    
    //for each appointment, compare current date with
    //current date/time.
    //if earlier than current date/time, add to list
    var completedAppointments: [Appointment] {
        var completedAppts: [Appointment] = []
        
        let currentdate = Date()
        
        for appointment in appointments {
            let apptDateTime = convertToDate(dateString: appointment.date, timeString: appointment.time)
            
            if (apptDateTime < currentdate) {
                completedAppts.append(appointment)
                
                print("Completed: Date: \(dateToday(type: DATETIMEINFO.date)) time: \(dateToday(type: DATETIMEINFO.date))")
            }
        }
        
        return completedAppts
    }
}
