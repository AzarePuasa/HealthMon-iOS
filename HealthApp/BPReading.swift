//
//  BPReading.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 14/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import Foundation

class BPReading {
    
    enum BPTYPE {
        case MORNING
        case AFTERNOON
        case EVENING
    }
    
    var type: BPTYPE
    var systolic: String
    var diastolic: String
    
    init(type: BPTYPE ) {
        self.type = type
        self.systolic = ""
        self.diastolic = ""
    }
}
