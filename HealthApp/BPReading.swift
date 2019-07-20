//
//  BPReading.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 14/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import Foundation

class BPReading {

    var type: AddBPViewController.BPTYPE?
    var systolic: String
    var diastolic: String
    var dailyReadingId: Int
    
    init(type: AddBPViewController.BPTYPE ) {
        self.type = type
        self.systolic = ""
        self.diastolic = ""
        self.dailyReadingId = -1
    }
    
    func setSystolic(systolic: String) {
        self.systolic = systolic
    }
    
    func setDiastolic(diastolic: String) {
        self.diastolic = diastolic
    }
    
    func describe() -> String {
        return "\nType: \(type)\nSystolic: \(systolic)\nDiastolic: \(diastolic)\nDailyReadingId: \(dailyReadingId)"
    }
    
}
