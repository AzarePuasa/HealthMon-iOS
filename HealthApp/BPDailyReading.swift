//
//  BPDailyReading.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 14/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import Foundation

class BPDailyReading {
    var id: Int = -1
    var date: String = ""
    var morningBP: String?
    var afternoonBP: String?
    var eveningBP: String?
    
    init(id:Int, date: String) {
        self.id = id
        self.date = date
        self.morningBP = ""
        self.afternoonBP = ""
        self.eveningBP = ""
    }
    
    func setmorningBP(morningBP: String) {
        self.morningBP = morningBP
    }
    
    func setAfternoonBP(afternoonBP: String) {
        self.afternoonBP = afternoonBP
    }
    
    func setEveningBP(eveningBP: String) {
        self.eveningBP = eveningBP
    }
}
