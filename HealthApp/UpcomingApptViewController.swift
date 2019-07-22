//
//  UpcomingApptViewController.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 15/6/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import UIKit

class UpcomingApptViewController: UIViewController {
    
    @IBOutlet weak var outImageHeader: UIImageView!
    
    @IBOutlet weak var outLabelHeader: UILabel!
    
    @IBOutlet weak var outLabelSubHeader: UILabel!
    
    @IBOutlet weak var outLabelDate: UILabel!
    
    @IBOutlet weak var outLabelTime: UILabel!
    
    @IBOutlet weak var outLabelLocation: UILabel!
    
    @IBOutlet weak var outLabelPurpose: UILabel!
    
    @IBOutlet weak var outBarButtonEdit: UIBarButtonItem!
    
    var id: Int!
    
    var isUpcoming: Bool!
    
    var appointment: Appointment!
    
    var isNotificationOn: Bool!

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
        
        if (!isUpcoming) {
            outBarButtonEdit.isEnabled = false
        }
        
        //TODO: Check for notification with id healthmon.appt.<id>
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetchAppointment(url: "http://localhost:9010/api/appointment/\(id!)")
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
        if (identifier == "editAppt") {
            let vc = segue.destination as! EditApptViewController
            vc.appointment = self.appointment
        }
        
        if (identifier == "setnotification") {
            //TODO: send id of appointment.
            let vc = segue.destination as! ApptNotifyViewController
            
            vc.assignmentId = appointment.id
            
            //If exist, send true
            vc.notificationExist = true
        }
    }
    
    @IBAction func unwindUpComingApptSegue(_ sender: UIStoryboardSegue) {
        print("unwind Segue in UpcomingAppt ")
        
        //TODO: To create/delete notification here.
        if (isNotificationOn) {
            print("Switch on Appt Notification is set to ON")
        } else {
            print("Switch on Appt Notification is set to OFF")
        }
        
    }
}
