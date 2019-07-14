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
    var morningBP: BPReading?
    var afternoonBP: BPReading?
    var eveningBP: BPReading?
    
    init(id:Int, date: String) {
        self.id = id
        self.date = date
        self.morningBP = BPReading(type: BPReading.BPTYPE.MORNING)
        self.afternoonBP = BPReading(type: BPReading.BPTYPE.AFTERNOON)
        self.eveningBP = BPReading(type: BPReading.BPTYPE.EVENING)
    }
}
