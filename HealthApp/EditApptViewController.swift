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
    
    var appointment: Appointment!
    
    var createNotification: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Load image
        let image = UIImage(named: "calendarscope")
        outImageHeader.image = image
        
        //Load Header & Sub-Header
        outLabelHeader.text = "Appointment"
        outLabelSubHeader.text = "Edit Appointment"
        
        //show date picker
        showDatePicker()
        showTimePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        outTextDate.text = appointment.date
        outTextTime.text = appointment.time
        outTextLocation.text = appointment.location
        outTextPurpose.text = appointment.purpose
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: appointment.date) {
            datePicker.setDate(date, animated: true)
        }
        
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
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH:mm:ss"
        
        if let time = dateFormatter.date(from: appointment.time) {
            timePicker.setDate(time, animated: true)
        }
        
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
    
    @IBAction func actSave(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "exittolist", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let identifier = segue.identifier
        
        //send appointment to viewcontroller
        if (identifier == "exittolist") {
            
            if let date = outTextDate.text, let time = outTextTime.text,
                let location = outTextLocation.text, let purpose = outTextPurpose.text  {
                
                let vc = segue.destination as! ApptViewController
                
                let updatedAppt = Appointment(id: appointment.id, dateOfAppt: date, timeOfAppt: time, location: location, purpose: purpose)
                
                vc.appointment = updatedAppt
            }
        }
        
    }
    

}
