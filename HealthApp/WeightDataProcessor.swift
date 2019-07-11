//
//  WeightDataProcessor.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 12/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import Foundation

class WeightDataProcessor {
    static func mapJsonToWeights(object: [[String: AnyObject]]) -> [Weight] {
        var mappedWeights: [Weight] = []
        
        let weights = object
        
        for weight in weights {
            guard let id = weight["id"] as? Int,
                let date = weight["date"] as? String,
                let weightrecord = weight["weight"] as? String else { continue }
            
            print("Id: \(id) \nDate: \(date) \nWeight Record: \(weightrecord)\n")
            
            let weightClass = Weight(id: id, dateOfRecord: date, weightRecord: weightrecord)
            
            mappedWeights.append(weightClass)
        }
        return mappedWeights
    }
}
