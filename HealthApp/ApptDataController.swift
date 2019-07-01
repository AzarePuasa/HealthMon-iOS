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
        
        //pull data from REST API and add to array.
        
        guard let url = URL(string: "http://localhost:9010/api/appointments") else {
            return
        }
        
        // Step 2 - Create a URLRequest object
        let request = URLRequest(url:url)
        // Step 3 - Create a URLSession object
        let session = URLSession.shared
        // Step 4 - Create a URLSessionDataTask object
        let task = session.dataTask(with: request) { (data, response, error) in
            // Step 6 - Process the response
            
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    return
                }
                
                for dic in jsonArray{
                    if let id = dic["id"] as? Int,
                        let datetime = dic["datetime"] as? String,
                        let location = dic["location"] as? String,
                        let purpose = dic["purpose"] as? String {
                        print("Id: \(id) \nDate/Time: \(datetime) \nLocation: \(location) \nPurpose: \(purpose)\n")
                        
                        //Seperate date time.
                        let datetimeArr = datetime.components(separatedBy: " ")
                        let date = datetimeArr[0]
                        let time = datetimeArr[1]
                        //create Appointment object
                        
                        let appt = Appointment(dateOfAppt: date, timeOfAppt: time, location: location, purpose: purpose)
                        
                        self.add(appointment: appt)
                    }
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        
        // Step 5 - Start / resume the task
        task.resume()
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
    
    func getAppointment(id: UUID) -> Appointment? {
        for appointment in appointments {
            if (appointment.id == id) {
                return appointment
            }
        }
        
        return nil
    }
    
    func updateAppointment(id: UUID, new: Appointment) -> Bool {
        
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
    
    var upcomingAppointments: [Appointment] {
        
        var upcomingAppts: [Appointment] = []
        
        //for each appointment, compare current date with
        //current date/time.
        //if later than current date/time, add to list
        
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
    
    
    var completedAppointments: [Appointment] {
        var completedAppts: [Appointment] = []
        
        //for each appointment, compare current date with
        //current date/time.
        //if earlier than current date/time, add to list
        
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
