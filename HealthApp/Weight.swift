//
//  Weight.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 11/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import Foundation

class Weight {
    var id: Int = -1
    var date: String = ""
    var weight: String = ""
    
    init(id:Int, dateOfRecord: String, weightRecord: String) {
        self.id = id
        self.date = dateOfRecord
        self.weight = weightRecord
    }
}
