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
    
    var id: UUID!
    
    var isUpcoming: Bool!
    
    var dc = ApptDataController.sharedInstance

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
        
        if let appointment = dc.getAppointment(id: id) {
            outLabelDate.text = appointment.date
            outLabelTime.text = appointment.time
            outLabelLocation.text = appointment.location
            outLabelPurpose.text = appointment.purpose
        }
        
        if (!isUpcoming) {
            outBarButtonEdit.isEnabled = false
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
            vc.id = self.id
        } 
        
    }
    

}
