//
//  JSONParser.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 5/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import Foundation

class JSONParser {
    static func parseItems (data: Data) -> [[String: AnyObject]]? {
        let options = JSONSerialization.ReadingOptions()
 
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: data, options: options) as? [[String: AnyObject]]
            
            return jsonObj
        } catch (let parseError){
            print("There was an error parsing the JSON: \"\(parseError.localizedDescription)\"")
        }
        return nil
    }
    
    static func parseItem (data: Data) -> [String: AnyObject]? {
        let options = JSONSerialization.ReadingOptions()
        
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: data, options: options) as? [String: AnyObject]
            
            return jsonObj
        } catch (let parseError){
            print("There was an error parsing the JSON: \"\(parseError.localizedDescription)\"")
        }
        return nil
    }
}
