//
//  ApptNotifyViewController.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 22/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import UIKit
import UserNotifications

class ApptNotifyViewController: UIViewController {
    
    @IBOutlet weak var outSwitch: UISwitch!
    
    @IBOutlet weak var outTextView: UITextView!
    
    var assignmentId: Int?
    var notificationExist: Bool = false  //notification exist. Set from source controller.
    var isSwitchOn: Bool = false
    var apptNotification: UNNotificationRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //TODO: Set notification id using the assignment id send over.
        
        //TODO: Check if Current Notification exist.
        // If notification exist for this Appointnent,
        //set switch to on. Else switch is off
        if (notificationExist) {
            outSwitch.isOn = true
        } else {
            outSwitch.isOn = false
        }
    
        if let appt_reminder = apptNotification {
            outTextView.text = "Title\(appt_reminder.content.title)\n Sub-Title: \(appt_reminder.content.subtitle)"
        } else {
            outTextView.text = "No Notification Set"
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let identifier = segue.identifier
        
        if (identifier == "exitNotAppt") {
            //if switch is off and there is current Notification, delete the
            //Notification
            let vc = segue.destination as! UpcomingApptViewController
            
            print("isSwitchOn: \(isSwitchOn)")
            
            vc.userWantsNotification = outSwitch.isOn
        }
    }
    
    @IBAction func actDone(_ sender: UIBarButtonItem) {
        //Segue back to Upcoming Appointment View Controller
        
        performSegue(withIdentifier: "exitNotAppt", sender: self)
        
    }
    
    @IBAction func actSwitchChange(_ sender: UISwitch) {
        if (outSwitch.isOn) {
            print("The Notification is to be enabled")
            isSwitchOn = true
        } else {
            print("The Notification is to be disabled")
            isSwitchOn = false
        }
    }
    
}
