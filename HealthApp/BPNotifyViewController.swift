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
    
    var notificationExist: Bool = false  //notification exist. Set from source controller.
    
    var morningNotification: UNNotificationRequest?
    var afternoonNotification: UNNotificationRequest?
    var eveningNotification: UNNotificationRequest?
    
    var morningNotificationId: String = "healthmon_bp_morning"
    var afternoonNotificationId: String = "healthmon_bp_afternoon"
    var eveningNotificationId: String = "healthmon_bp_evening"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func actDoneBtn(_ sender: UIBarButtonItem) {
         performSegue(withIdentifier: "exitNotBP", sender: self)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
