//
//  WeightNotifyViewController.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 24/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import UIKit
import UserNotifications

class WeightNotifyViewController: UIViewController {
    
    @IBOutlet weak var outSwitch: UISwitch!
    
    @IBOutlet weak var outTextView: UITextView!
    
    var notificationExist: Bool = false  //notification exist. Set from source controller.
    
    var weightNotification: UNNotificationRequest?
    
    var weightNotificationId: String = "healthmon_appt_weight"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        outTextView.text = "No Notification Set"
        outSwitch.isOn = false
        
        //Check pending notifications.
        UNUserNotificationCenter.current()  .getPendingNotificationRequests(completionHandler: {requests -> () in
            
            print("\(requests.count) requests -------")
            
            for request in requests{
                if (request.identifier == self.weightNotificationId) {
                    print("Weight Notification found.")
                    
                    self.weightNotification = request
                    self.notificationExist = true
                    
                    DispatchQueue.main.async {
                        //print details of weight notification if available.
                        if let weight_reminder = self.weightNotification {
                            self.outTextView.text = "Title\(weight_reminder.content.title)\n Sub-Title: \(weight_reminder.content.subtitle)\n Message: \(weight_reminder.content.body)"
                        }
                        
                        self.outSwitch.isOn = true
                    }
                }
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
    
    @IBAction func actBtnDone(_ sender: Any) {
        
        if (notificationExist && !outSwitch.isOn) {
            print("Deleting Appointment Reminder")
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [weightNotificationId])
        } else {
            let subTitle = "Weight Record Reminder"
            let body = "Have you record your weight this month?"
            
            NotificationManager.createTimeIntervalNotification(for: subTitle, duration: 10, bodyText: body, identifierId: weightNotificationId)
        }
        
        performSegue(withIdentifier: "exitNotWeight", sender: self)
    }
    
}
