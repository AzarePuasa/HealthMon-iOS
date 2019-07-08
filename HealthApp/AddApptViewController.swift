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
    
    func createAppointment() {
        HTTPHandler.getJson(urlString: CREATE_APPT_URL, completionHandler: parseDateCreateAppts)
    }
    
    func parseDateCreateAppts(data: Data?) -> Void {
        
    }
    
    @IBAction func actSave(_ sender: Any) {
        
        if let date = outTextDate.text, let time = outTextTime.text,
            let location = outTextLocation.text, let purpose = outTextPurpose.text  {
            //save to data controller
            
            let session = URLSession.shared
            let url = URL(string: "http://localhost:9010/api/appointment")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Powered by Swift!", forHTTPHeaderField: "X-Powered-By")
            
            let date = "\(date) \(time)" as AnyObject
            let loc = location as AnyObject
            let pur = purpose as AnyObject
            
            let apptDict: [String: AnyObject] = ["datetime": date,
                "location":loc, "purpose": pur]

            let jsonData = try! JSONSerialization.data(withJSONObject: apptDict, options: [])
            
            let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
                
                if let error = error {
                    print("error: \(error)")
                } else {
                    if let response = response as? HTTPURLResponse {
                        print("statusCode: \(response.statusCode)")
                    }
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        print("data: \(dataString)")
                    }
                }
            }
            
            task.resume()
        }
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
