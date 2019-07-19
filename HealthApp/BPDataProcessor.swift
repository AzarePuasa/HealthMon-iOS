//
//  BPDataProcessor.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 17/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import Foundation

class BPDataProcessor {
    static func mapJsonToDailyBPReadings(object: [[String: AnyObject]]) -> [BPDailyReading] {
        var mappedDailyBPReading: [BPDailyReading] = []
        
        let dailyBPReadings = object
        
        for dailyBPReading in dailyBPReadings {
            if let id = dailyBPReading["id"] as? Int,
                let date = dailyBPReading["date"] as? String {
                
                let bpReading = BPDailyReading(id: id, date: date)
                
                if let bpmorning = dailyBPReading["bpmorning"] as? String {
                    bpReading.setmorningBP(morningBP: bpmorning)
                }
                if let bpafternoon = dailyBPReading["bpafternoon"] as? String {
                    bpReading.setAfternoonBP(afternoonBP: bpafternoon)
                }
                if let bpevening = dailyBPReading["bpevening"] as? String {
                    bpReading.setEveningBP(eveningBP: bpevening)
                }
            
                print("Id: \(bpReading.id) \nDate: \(bpReading.date) \nMorning: \(bpReading.morningBP ?? nil)\nAfternoon: \(bpReading.afternoonBP ?? nil) \n Evening: \(bpReading.eveningBP ?? nil)")
 
                mappedDailyBPReading.append(bpReading)
            }
        }
        
        return mappedDailyBPReading
    }
    
    static func mapJsonToDailyBPReading(object: [String: AnyObject]) -> BPDailyReading? {
        
        let dailyBPReading = object

        if let id = dailyBPReading["id"] as? Int,
            let date = dailyBPReading["date"] as? String {
            
            let bpReading = BPDailyReading(id: id, date: date)
            
            if let bpmorning = dailyBPReading["bpmorning"] as? String {
                bpReading.setmorningBP(morningBP: bpmorning)
            }
            if let bpafternoon = dailyBPReading["bpafternoon"] as? String {
                bpReading.setAfternoonBP(afternoonBP: bpafternoon)
            }
            if let bpevening = dailyBPReading["bpevening"] as? String {
                bpReading.setEveningBP(eveningBP: bpevening)
            }
            
            print("Id: \(bpReading.id) \nDate: \(bpReading.date) \nMorning: \(bpReading.morningBP ?? nil)\nAfternoon: \(bpReading.afternoonBP ?? nil) \n Evening: \(bpReading.eveningBP ?? nil)")
    
            return bpReading
    
        }
        return nil
    }
}
