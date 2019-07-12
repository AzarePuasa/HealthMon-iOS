//
//  AddWeightViewController.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 12/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import UIKit

class AddWeightViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    enum DATETIMEINFO {
        case date
        case time
    }
    
    @IBOutlet weak var outImageHeader: UIImageView!
    
    @IBOutlet weak var outLabelHeader: UILabel!
    
    @IBOutlet weak var outLabelSubHeader: UILabel!
    
    @IBOutlet weak var outDateText: UITextField!
    
    @IBOutlet weak var outWeightText: UITextField!
    
    @IBOutlet weak var outPickerView: UIPickerView!
    
    var wholeNum = Array(0...99)
    var fractionNum = Array(0...99)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Load image
        let image = UIImage(named: "icons8-scale-24")
        outImageHeader.image = image
        
        //Load Header & Sub-Header
        outLabelHeader.text = "My Weight"
        outLabelSubHeader.text = "Add Record"
        
        //TODO: populate date field. Today's Date
        outDateText.text = dateToday(type: DATETIMEINFO.date)
        
        //TODO: pupulate weight field. Default 60
        outWeightText.text = "60.00"
        
        //Select the default value in pickerview.
        outPickerView.selectRow(60, inComponent: 0, animated: true)
        outPickerView.selectRow(0, inComponent: 1, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //TODO: prepare Weight to be send back to list controller.
        
        let identifier = segue.identifier
        
        if (identifier == "exitweight") {
            
            if let date = outDateText.text, let weightRecord = outWeightText.text {
                let vc = segue.destination as! WeightViewController
                
                let weight = Weight(id: -1, dateOfRecord: date, weightRecord: weightRecord)
                
                vc.newWeightRecord = weight
            }
        
        }
    }
    
    @IBAction func actSave(_ sender: Any) {
        performSegue(withIdentifier: "exitweight", sender: self)
    }
    
    
    func dateToday(type: DATETIMEINFO) -> String{
        
        let now = Date()
        
        let dff = DateFormatter()
        dff.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dff.locale = Locale(identifier: "en_US_POSIX")
        var dtNow: [String] = dff.string(from: now).components(separatedBy: " ")
        
        if (type == DATETIMEINFO.date) {
            return dtNow[0]
        }
        
        return dtNow[1]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return wholeNum.count
        }
        
        return fractionNum.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (component == 0) {
            return String(wholeNum[row])
        }
        
        return String(format: "%02d", fractionNum[row])

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let digitsValue = wholeNum[outPickerView.selectedRow(inComponent: 0)]
        let decimalValue = fractionNum[outPickerView.selectedRow(inComponent: 1)]
        
        outWeightText.text = "\(digitsValue).\(String(format: "%02d", decimalValue))"
    }
    
}
