//
//  Appointment.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 4/5/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import Foundation

class Appointment {
    var id: Int = -1
    var date: String = ""
    var time: String = ""
    var location: String = ""
    var purpose: String = ""
   
    init(id:Int, dateOfAppt: String, timeOfAppt: String, location: String, purpose: String) {
        self.id = id
        self.date = dateOfAppt
        self.time = timeOfAppt
        self.location = location
        self.purpose = purpose
    }
}
