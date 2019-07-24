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
    
    var notificationExist: Bool = false  //notification exist. Set from source controller.
    
    var apptNotification: UNNotificationRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //TODO: Set notification id using the assignment id send over.
        
        //Set switch. ON indicates that there is a pending Appointment,
        //OFF otherwise.
        if (notificationExist) {
            outSwitch.isOn = true
        } else {
            outSwitch.isOn = false
        }
    
        //print details of Appointment if available.
        if let appt_reminder = apptNotification {
            outTextView.text = "Title\(appt_reminder.content.title)\n Sub-Title: \(appt_reminder.content.subtitle)\n Message: \(appt_reminder.content.body)"
        } else {
            outTextView.text = "No Notification Set"
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let identifier = segue.identifier
        
        if (identifier == "exitNotAppt") {
            let vc = segue.destination as! UpcomingApptViewController
            
            print("isSwitchOn: \(outSwitch.isOn)")
            
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
        } else {
            print("The Notification is to be disabled")
        }
    }
}
