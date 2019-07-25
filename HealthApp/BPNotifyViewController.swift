//
//  BPNotifyViewController.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 25/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import UIKit
import UserNotifications

class BPNotifyViewController: UIViewController {

    @IBOutlet weak var outMorningSwitch: UISwitch!
    @IBOutlet weak var outAfternoonSwitch: UISwitch!
    @IBOutlet weak var outEveningSwitch: UISwitch!
    
    @IBOutlet weak var outTextView: UITextView!
    
    var notifyMorningBP: Bool = false
    var notifyAfternoonBP: Bool = false
    var notifyEveningBP: Bool = false
    
    var morningNotificationId: String = "healthmon_bp_morning"
    var afternoonNotificationId: String = "healthmon_bp_afternoon"
    var eveningNotificationId: String = "healthmon_bp_evening"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Default message in Text view.
        let message = "Notification Schedule:\n\nMorning Notification: 7am\n Afternoon: 1 pm\n Evening: 7pm"
        
        outTextView.text = message
        
        //Set all switches to false.
        outMorningSwitch.isOn = false
        outAfternoonSwitch.isOn = false
        outEveningSwitch.isOn = false
        
        //TODO: Check for Notifications and turn on switches if available.
        //Check pending notifications.
        UNUserNotificationCenter.current()  .getPendingNotificationRequests(completionHandler: {requests -> () in
            
            print("\(requests.count) requests -------")
            
            for request in requests{
                if (request.identifier == self.morningNotificationId) {
                    print("Morning BP Notification found.")
                    DispatchQueue.main.async {
                        self.outMorningSwitch.isOn = true
                        self.notifyMorningBP = true
                    }
                } else if(request.identifier == self.afternoonNotificationId) {
                    print("Afternoon BP Notification found.")
                    DispatchQueue.main.async {
                        self.outAfternoonSwitch.isOn = true
                        self.notifyAfternoonBP = true
                    }
                } else if(request.identifier == self.eveningNotificationId) {
                    print("Evening BP Notification found.")
                    DispatchQueue.main.async {
                        self.outAfternoonSwitch.isOn = true
                        self.notifyEveningBP = true
                    }
                }
            }
        })
    }
    
    
    @IBAction func actDoneBtn(_ sender: UIBarButtonItem) {
        
        if (notifyMorningBP && !outMorningSwitch.isOn) {
            print("Deleting Morning BP Reminder")
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [morningNotificationId])
        } else {
            let subTitle = "Morning BP Reminder"
            let body = "Reminder to take you BP Reading"
            
            NotificationManager.createTimeIntervalNotification(for: subTitle, duration: 10, bodyText: body, identifierId: morningNotificationId)
        }
        
        if (notifyAfternoonBP && !outAfternoonSwitch.isOn) {
            print("Deleting Afternoon BP Reminder")
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [afternoonNotificationId])
        } else {
            let subTitle = "Afternoon BP Reminder"
            let body = "Reminder to take you BP Reading"
            
            NotificationManager.createTimeIntervalNotification(for: subTitle, duration: 20, bodyText: body, identifierId: afternoonNotificationId)
        }
        
        if (notifyEveningBP && !outEveningSwitch.isOn) {
            print("Deleting Evening BP Reminder")
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [eveningNotificationId])
        } else {
            let subTitle = "Evening BP Reminder"
            let body = "Reminder to take you BP Reading"
            
            NotificationManager.createTimeIntervalNotification(for: subTitle, duration: 30, bodyText: body, identifierId: eveningNotificationId)
        }
        
        performSegue(withIdentifier: "exitNotBP", sender: self)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
    }
    

}
