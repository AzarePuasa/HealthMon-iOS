//
//  AddApptViewController.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 15/6/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import UIKit

class AddApptViewController: UIViewController {

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
    
    let CREATE_APPT_URL = "http://localhost:9010/api/appointment"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Load image
        let image = UIImage(named: "calendarscope")
        outImageHeader.image = image
        
        //Load Header & Sub-Header
        outLabelHeader.text = "Appointment"
        outLabelSubHeader.text = "Add Appointment"
        
        //show date picker
        showDatePicker()
        showTimePicker()
    }
    
    //Save input as new Appointment.
    @IBAction func actSave(_ sender: Any) {
        performSegue(withIdentifier: "exit", sender: self)
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain, target: self, action: #selector(donedatePicker(_:)))
        
        toolbar.setItems([doneButton], animated: false)
        
        // add toolbar to textField
        outTextDate.inputAccessoryView = toolbar
        // add datepicker to textField
        outTextDate.inputView = datePicker
    }
    
    func showTimePicker(){
        //Formate Date
        timePicker.datePickerMode = .time
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain, target: self, action: #selector(donetimePicker(_:)))
        
        toolbar.setItems([doneButton], animated: false)
        
        // add toolbar to textField
        outTextTime.inputAccessoryView = toolbar
        // add datepicker to textField
        outTextTime.inputView = timePicker
    }
    
    @objc func donedatePicker(_ sender:UIBarButtonItem){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        outTextDate.text = formatter.string(from: datePicker.date)
        outTextDate.resignFirstResponder()
    }
    
    @objc func donetimePicker(_ sender:UIBarButtonItem){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        outTextTime.text = formatter.string(from: timePicker.date)
        outTextTime.resignFirstResponder()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let identifier = segue.identifier
        
        //send appointment to viewcontroller
        if (identifier == "exit") {
            
            if let date = outTextDate.text, let time = outTextTime.text,
                let location = outTextLocation.text, let purpose = outTextPurpose.text  {
                
                let vc = segue.destination as! ViewController
                
                let appointment = Appointment(id: -1, dateOfAppt: date, timeOfAppt: time, location: location, purpose: purpose)
                
                vc.appointment = appointment
            }
        }
    }
}
