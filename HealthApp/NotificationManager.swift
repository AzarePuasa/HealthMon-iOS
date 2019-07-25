//
//  NotificationManager.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 24/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    enum REMINDER_STATUS {
        case SET
        case NOT_SET
        case NO_AUTHORIZATION
        
        func description() -> String {
            switch self {
            case .SET:
                return "SET"
            case .NOT_SET:
                return "NOT SET"
            case .NO_AUTHORIZATION:
                return "NO AUTHORIZATION"
            }
        }
    }
    
    static var title: String = "Health Monitoring"
    
    static func createTimeIntervalNotification(for subtitle: String, duration: Int, bodyText: String, identifierId: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = bodyText
        
        //Set the trigger of the notification -- here a timer.
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 20,
            repeats: false)
        
        //Set the request for the notification from the above
        
        print("Creating Notification with identifier: \(identifierId)")
        let request = UNNotificationRequest(
            identifier: identifierId,
            content: content,
            trigger: trigger
        )
        
        //Add the notification to the currnet notification center
        UNUserNotificationCenter.current().add(
            request, withCompletionHandler: nil)
    }
}
