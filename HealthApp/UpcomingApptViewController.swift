//
//  UpcomingApptViewController.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 15/6/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import UIKit
import UserNotifications

class UpcomingApptViewController: UIViewController {
    
    @IBOutlet weak var outImageHeader: UIImageView!
    
    @IBOutlet weak var outLabelHeader: UILabel!
    
    @IBOutlet weak var outLabelSubHeader: UILabel!
    
    @IBOutlet weak var outLabelDate: UILabel!
    
    @IBOutlet weak var outLabelTime: UILabel!
    
    @IBOutlet weak var outLabelLocation: UILabel!
    
    @IBOutlet weak var outLabelPurpose: UILabel!
    
    @IBOutlet weak var outBarButtonEdit: UIBarButtonItem!
    
    @IBOutlet weak var outNotificationBarButton: UIBarButtonItem!
    
    var id: Int!
    
    var isUpcoming: Bool!
    
    var appointment: Appointment!
    
    var isNotificationOn: Bool!
    
    var isGrantedNotificationAccess = false
    
    var notificationExist: Bool = false
    
    var apptNotificationId: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Load image
        let image = UIImage(named: "calendarscope")
        outImageHeader.image = image
    
        //Load Header & Sub-Header
        outLabelHeader.text = "Appointment"
        outLabelSubHeader.text = isUpcoming ?
            "Upcoming Appointment": "Completed Appointment"
        
        fetchAppointment(url: "http://localhost:9010/api/appointment/\(id!)")
        
        outNotificationBarButton.isEnabled = false
        
        if (isUpcoming) {
            // Check access is granted for notification.
            let center = UNUserNotificationCenter.current()
            center.getNotificationSettings { (settings) in
                // Do not schedule notifications if not authorized
                if (settings.authorizationStatus == .authorized) {
                    self.isGrantedNotificationAccess = true
                    self.outNotificationBarButton.isEnabled = true
                }
            }
            
            //TODO: Check for notification with id healthmon.appt.<id>
            center.getPendingNotificationRequests(completionHandler: {requests -> () in
                print("\(requests.count) requests -------")
                for request in requests{
                    if (request.identifier == self.apptNotificationId) {
                        self.notificationExist = true
                        print("Appointment Notification found.")
                    }
                }
            })
        } else {
            outBarButtonEdit.isEnabled = false
            outNotificationBarButton.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func fetchAppointment(url: String) {
        HTTPHandler.getAPI(urlString: url, completionHandler: parseDataIntoAppt)
    }
    
    func parseDataIntoAppt(data: Data?) -> Void {
        if let data = data {
            let object = JSONParser.parseItem(data: data)
            if let object = object {
                self.appointment = ApptDataProcessor.mapJsonToAppt(object: object)
                print("Appointment: \(self.appointment.id)")
                DispatchQueue.main.async {
                    self.outLabelDate.text = self.appointment.date
                    self.outLabelTime.text = self.appointment.time
                    self.outLabelLocation.text = self.appointment.location
                    self.outLabelPurpose.text = self.appointment.purpose
                    
                     self.apptNotificationId = "healthmon.appt.\(self.appointment.id)"
                }
            }
        }
    }
    
    @IBAction func actBtnEdit(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "editAppt", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let identifier = segue.identifier
        if (identifier == "editAppt") {
            let vc = segue.destination as! EditApptViewController
            vc.appointment = self.appointment
        }
        
        if (identifier == "setnotification") {
            //TODO: send id of appointment.
            let vc = segue.destination as! ApptNotifyViewController
            
            vc.assignmentId = appointment.id
            
            print("Appointment ID: \(appointment.id)")
            
            //If exist, send true
            vc.notificationExist = notificationExist
        }
    }
    
    @IBAction func unwindUpComingApptSegue(_ sender: UIStoryboardSegue) {
        print("unwind Segue in UpcomingAppt ")
        
        if (isNotificationOn) {
            print("Switch on Appt Notification is set to ON. Create/Replace Notification")
            //TODO: Create notification for this Appointment
            //Date for trigger is Appointment Date - 1
            
            //Set the content of the notification
            let content = UNMutableNotificationContent()
            content.title = "Health Monitoring"
            content.subtitle = "Appointment Reminder Test"
            content.body = "Notification after 1 Minute"
            
            //Set the trigger of the notification -- here a timer.
            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: 60.0,
                repeats: false)
            
            //Set the request for the notification from the above
            if let identifier = apptNotificationId {
                let request = UNNotificationRequest(
                    identifier: identifier,
                    content: content,
                    trigger: trigger
                )
                
                //Add the notification to the currnet notification center
                UNUserNotificationCenter.current().add(
                    request, withCompletionHandler: nil)
            }
        } else {
            if (notificationExist) {
                print("Switch on Appt Notification is set to OFF. Deleting pending Notification")
                //TODO: Delete the notification.
                if let identifier = apptNotificationId {        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
                }
            }
        }
    }
}
