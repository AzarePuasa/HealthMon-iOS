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

    @IBOutlet weak var outReminder: UILabel!
    
    @IBOutlet weak var outLabelReminder: UILabel!
    
    var id: Int!
    
    var isUpcoming: Bool!
    
    var appointment: Appointment!
    
    var userWantsNotification: Bool!
    
    var isGrantedNotificationAccess = false
    
    var notificationExist: Bool = false
    
    var apptNotificationId: String?
    
    var apptNotification: UNNotificationRequest?
    
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
        apptNotificationId = "healthmon_appt_\(id!)"
        
        print("apptNotificationId: \(apptNotificationId!)")
        
        outNotificationBarButton.isEnabled = false
        
        self.outReminder.text = REMINDER_STATUS.NOT_SET.description()
        
        if (isUpcoming) {
            // For Upcoming Appointment, Notification Label is set
            // according to Notification authorization.
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                // Do not schedule notifications if not authorized
                if (settings.authorizationStatus == .authorized) {
                    self.isGrantedNotificationAccess = true
                    self.outNotificationBarButton.isEnabled = true
                    
                } else {
                    DispatchQueue.main.async {
                        self.outReminder.text = REMINDER_STATUS.NO_AUTHORIZATION.description()
                    }
                }
            }
        } else {
            //hide Notification label for completed Appointment.
            outReminder.isHidden = true
            outLabelReminder.isHidden = true
            
            //disable widgets for for completed Appointment.
            outBarButtonEdit.isEnabled = false
            outNotificationBarButton.isEnabled = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("Running \(#function)")
        
        if (isUpcoming && isGrantedNotificationAccess) {
        
            //Check pending notifications.
            UNUserNotificationCenter.current()  .getPendingNotificationRequests(completionHandler: {requests -> () in
            
                print("\(requests.count) requests -------")
            
                for request in requests{
                    if (request.identifier == self.apptNotificationId) {
                        print("Appointment Notification found.")
                    
                        self.apptNotification = request
                        self.notificationExist = true
                        DispatchQueue.main.async {
                            self.outReminder.text = REMINDER_STATUS.SET.description()
                        }
                    }
                }
            })
        }
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
       
        //edit appointment screen
        if (identifier == "editAppt") {
            let vc = segue.destination as! EditApptViewController
            vc.appointment = self.appointment
        }
        
        //notification popover.
        if (identifier == "setnotification") {
            //TODO: send id of appointment.
            let vc = segue.destination as! ApptNotifyViewController
            
            vc.assignmentId = appointment.id
            
            print("Appointment ID: \(appointment.id)")
            
            //If exist, send true
            vc.notificationExist = notificationExist
            vc.apptNotification = apptNotification
        }
    }
    
    @IBAction func unwindUpComingApptSegue(_ sender: UIStoryboardSegue) {
        print("Running \(#function)")
        
        if (userWantsNotification) {
            print("Create/Replace Reminder")
            //TODO: Create notification for this Appointment
            //Date for trigger is Appointment Date - 1
            
            //Set the content of the notification
            let content = UNMutableNotificationContent()
            content.title = "Health Monitoring"
            content.subtitle = "Reminder"
            content.body = "You have an Appointment Tomorrow:\n Date: \(appointment.date)\nTime:\(appointment.time)\nLocation: \(appointment.location)"
            
            //Set the trigger of the notification -- here a timer.
            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: 20,
                repeats: false)
            
            //Set the request for the notification from the above
            if let identifier = apptNotificationId {
                print("Creating Notification with identifier: \(identifier)")
                let request = UNNotificationRequest(
                    identifier: identifier,
                    content: content,
                    trigger: trigger
                )
                
                //Add the notification to the currnet notification center
                UNUserNotificationCenter.current().add(
                    request, withCompletionHandler: nil)
            } else {
                print("Fail to create Notification")
            }
        } else {
            if (notificationExist) {
                print("Deleting Appointment Reminder")
                //TODO: Delete the notification.
                if let identifier = apptNotificationId {        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
                }
            }
        }
        
        //TODO: Update Reminder Text:
    }
}
