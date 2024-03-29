//
//  HTTPHandler.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 5/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import Foundation

class HTTPHandler {
    static func getAPI(urlString: String, completionHandler: @escaping (Data?) -> (Void)) {
        let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)
        
        print("URL being used is \(url!)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if let data = data {
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                print("get request completed with code: \(statusCode)")
                if (statusCode == 200) {
                    print("return to completion handler with the data")
                    completionHandler(data as Data)
                }
            } else if let error = error {
                print("***There was an error making the HTTP request***")
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
        task.resume()
    }
    
    static func postAPI(urlString: String, dataToUpload: Data, completionHandler: @escaping (Data?) -> (Void)) {
        
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Powered by Swift!", forHTTPHeaderField: "X-Powered-By")
        
        let session = URLSession.shared
        
        let task = session.uploadTask(with: request, from: dataToUpload) { data, response, error in
            
            if let data = data {
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                print("post request completed with code: \(statusCode)")
                if (statusCode == 200) {
                    print("return to completion handler with the data")
                    completionHandler(data as Data)
                }
            } else if let error = error {
                print("***There was an error making the POST HTTP request***")
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
        
        task.resume()
    }
    
    static func putAPI(urlString: String, dataToUpload: Data, completionHandler: @escaping (Data?) -> (Void)) {
        
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Powered by Swift!", forHTTPHeaderField: "X-Powered-By")
        
        let session = URLSession.shared
        
        let task = session.uploadTask(with: request, from: dataToUpload) { data, response, error in
            
            if let data = data {
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                print("PUT request completed with code: \(statusCode)")
                if (statusCode == 200) {
                    print("return to completion handler with the data")
                    completionHandler(data as Data)
                }
            } else if let error = error {
                print("***There was an error making the PUT HTTP request***")
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
        
        task.resume()
    }
    
    static func putAPIString(urlString: String, data: String, completionHandler: @escaping (Data?) -> (Void)) {
 
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        
        request.httpBody = data.data(using: .utf8)
    
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                print("PUT request completed with code: \(statusCode)")
                if (statusCode == 200) {
                    print("return to completion handler with the data")
                    completionHandler(data as Data)
                }
            } else if let error = error {
                print("***There was an error making the PUT HTTP request***")
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
        
        task.resume()
    }
}
