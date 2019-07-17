//
//  BPDataProcessor.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 17/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import Foundation

class BPDataProcessor {
    static func mapJsonToDailyBPReading(object: [[String: AnyObject]]) -> [BPDailyReading] {
        var mappedDailyBPReading: [BPDailyReading] = []
        
        let dailyBPReadings = object
        
        for dailyBPReading in dailyBPReadings {
            guard let id = dailyBPReading["id"] as? Int,
                let date = dailyBPReading["date"] as? String,
                let bpmorning = dailyBPReading["bpmorning"] as? String,
                let bpafternoon = dailyBPReading["bpafternoon"] as? String,
                let bpevening = dailyBPReading["bpevening"] as? String
            else { continue }
  
            print("Id: \(id) \nDate: \(date) \nMorning: \(bpmorning)\nAfternoon: \(bpafternoon) \n Evening: \(bpevening)")
            
            let bpReading = BPDailyReading(id: id, date: date)
            
            bpReading.setmorningBP(morningBP: bpmorning)
            bpReading.setAfternoonBP(afternoonBP: bpafternoon)
            bpReading.setEveningBP(eveningBP: bpevening)
            
            mappedDailyBPReading.append(bpReading)
        }
        
        return mappedDailyBPReading
    }
}
