//
//  ApptStructs.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 3/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import Foundation

public struct ApptStruct: Codable {
    let datetime: String
    let location: String
    let purpose: String
    let createdAt: String
    let updatedAt: String
}
