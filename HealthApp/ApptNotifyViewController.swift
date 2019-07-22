//
//  ApptNotifyViewController.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 22/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import UIKit

class ApptNotifyViewController: UIViewController {
    
    @IBOutlet weak var outSwitch: UISwitch!
    
    var assignmentId: Int?
    var notificationExist: Bool = false  //notification exist. Set from source controller.
    var isSwitchOn: Bool = false
    
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
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let identifier = segue.identifier
        
        if (identifier == "exitNotAppt") {
            //if switch is off and there is current Notification, delete the
            //Notification
            let vc = segue.destination as! UpcomingApptViewController
            
            vc.isNotificationOn = isSwitchOn
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
