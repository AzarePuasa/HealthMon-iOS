//
//  EditApptViewController.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 16/6/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import UIKit

class EditApptViewController: UIViewController {
    
    @IBOutlet weak var outImageHeader: UIImageView!
    
    @IBOutlet weak var outLabelHeader: UILabel!
    
    @IBOutlet weak var outLabelSubHeader: UILabel!
    
    @IBOutlet weak var outTextDate: UITextField!
    
    @IBOutlet weak var outTextTime: UITextField!
    
    @IBOutlet weak var outTextLocation: UITextField!
    
    @IBOutlet weak var outTextPurpose: UITextField!
    
    //Date & Time picker
    let datePicker: UIDatePicker = UIDatePicker()
    let timePicker: UIDatePicker = UIDatePicker()
    
    var dc = ApptDataController.sharedInstance
    
    var id: UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Load image
        let image = UIImage(named: "calendarscope")
        outImageHeader.image = image
        
        //Load Header & Sub-Header
        outLabelHeader.text = "Appointment"
        outLabelSubHeader.text = "Edit Appointment"
        
        if let id = id, let appointment = dc.getAppointment(id: id) {
            outTextDate.text = appointment.date
            outTextTime.text = appointment.time
            outTextLocation.text = appointment.location
            outTextPurpose.text = appointment.purpose
        }
    }
    
    @IBAction func actSave(_ sender: UIBarButtonItem) {
        if let id = id, let date = outTextDate.text, let time = outTextTime.text,
            let location = outTextLocation.text, let purpose = outTextPurpose.text  {
            //save to data controller
            let appointment = Appointment(dateOfAppt: date, timeOfAppt: time, location: location, purpose: purpose)
            
            let update = dc.updateAppointment(id: id, new: appointment)

            if (update) {
                performSegue(withIdentifier: "exittolist", sender: self)
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
