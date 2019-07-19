//
//  AddBPViewController.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 14/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import UIKit

class AddBPViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var outImageHeader: UIImageView!
    
    @IBOutlet weak var outLabelHeader: UILabel!
    
    @IBOutlet weak var outLabelSubHeader: UILabel!
    
    @IBOutlet weak var outDateText: UITextField!
    
    @IBOutlet weak var outTextType: UITextField!
    
    @IBOutlet weak var outBtnSave: UIBarButtonItem!
    
    @IBOutlet weak var outPickerViewSystolic: UIPickerView!
    
    @IBOutlet weak var outPickerViewDiastolic: UIPickerView!
    
    let GET_BP_BY_DATE_URL = "http://localhost:9010/api/getreadingbydate/"
    
    var systolicRange = Array(70...190)
    var diastolicRange = Array(40...100)
    
    var bpReading: BPDailyReading?
    
    var bpType: BPTYPE?
    
    enum BPTYPE: CaseIterable {
        case MORNING
        case AFTERNOON
        case EVENING
        case INVALID
        
        func startTime() -> Int {
            switch self {
            case .MORNING:
                return 7
            case .AFTERNOON:
                return 13
            case .EVENING:
                return 18
            case .INVALID:
                return 0
            }
        }
        
        func endTime() -> Int {
            switch self {
            case .MORNING:
                return 13
            case .AFTERNOON:
                return 18
            case .EVENING:
                return 24
            case .INVALID:
                return 7
            }
        }
        
        func description() -> String {
            switch self {
            case .MORNING:
                return "MORNING"
            case .AFTERNOON:
                return "AFTERNOON"
            case .EVENING:
                return "EVENING"
            case .INVALID:
                return "INVALID"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Load image
        let image = UIImage(named: "icons8-bp-24")
        outImageHeader.image = image
        
        //Load Header & Sub-Header
        outLabelHeader.text = "Blood Pressure"
        outLabelSubHeader.text = "Add BP Reading"
        
        //TODO: Autopopulate the date field.
        let today = HealthMonCommon.dateToday(type: HealthMonCommon.DATETIMEINFO.date)
        
        outDateText.text = today
        
        outDateText.isEnabled = false
        
        //TODO: Autopopulate the Type field.
        //MORNING if time is after 7am and before 1pm.
        //AFTERNOON if time is after 1pm and before 7pm.
        //EVENING if time is after 7pm and before 12am.
        //INVALID if time is after 12am to 7am.
        let time = HealthMonCommon.dateToday(type: HealthMonCommon.DATETIMEINFO.time)
        
        let timeComponent: [String] = time.components(separatedBy: ":")
        
        if let hour = Int(timeComponent[0]) {
            for type in BPTYPE.allCases {
                if ((hour >= type.startTime()) && (hour < type.endTime())){

                    bpType = type
                }
            }
        }
        
        outTextType.isEnabled = false
        outTextType.text = bpType?.description()
        
        //if type is INVALID, disable save button.
        if (bpType == BPTYPE.INVALID) {
            outBtnSave.isEnabled = false
        }
        
        //set default systolic pickerview to 120
        //set default diastolic pickerview to 80
        
        let defaultSystolic = 120
        let defaultDiastolic = 80
        
        let defaultsystolicPos = getIndexOfValue(valueArr: systolicRange, searchValue: defaultSystolic)
        
        let defaultDiastolicPos = getIndexOfValue(valueArr: diastolicRange, searchValue: defaultDiastolic)
        
        outPickerViewSystolic.selectRow(defaultsystolicPos, inComponent: 0, animated: true)
        outPickerViewDiastolic.selectRow(defaultDiastolicPos, inComponent: 0, animated: true)
        
        // check BP Daily Reading exist for today's date.
        // If exist get that Daily Reading record.
        // else create new BP Daily Reading record.
        
        getTodaysBPReading(url: "http://localhost:9010/api/getreadingbydate/\(today)" )
    }
    
    func getTodaysBPReading(url: String) {
        HTTPHandler.getAPI(urlString: url, completionHandler: parseDataIntoBP)
    }
    
    func parseDataIntoBP(data: Data?) -> Void {
        if let data = data {
            let object = JSONParser.parseItem(data: data)
             if let object = object {
                self.bpReading = BPDataProcessor.mapJsonToDailyBPReading(object: object)
                
                if let tempBPReading = self.bpReading {
                    print("Daily BP Reading with id \(tempBPReading.id)")
                } else {
                    print("Creating New BP Daily Reading entry")
                }
            }
        }
    }
    
    @IBAction func actSave(_ sender: Any) {
        //TODO: Perform unwind seque to BPViewController.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if(pickerView == outPickerViewSystolic) {
            return 1
        }
        
        if(pickerView == outPickerViewDiastolic) {
            return 1
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == outPickerViewSystolic) {
            return systolicRange.count
        }
        
        if(pickerView == outPickerViewDiastolic) {
            return diastolicRange.count
        }
        
       return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == outPickerViewSystolic) {
            return String(systolicRange[row])
        }
        
        if(pickerView == outPickerViewDiastolic) {
            return String(diastolicRange[row])
        }
        
        return nil
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //TODO: Get the values from all the fields.
        //Date, Type, Systolic & Diastolic.
        
        //TODO: Send data back to BPViewController
    }
    
    func getIndexOfValue(valueArr: [Int], searchValue: Int) -> Int {
        var index = 0
        
        for value in valueArr {
            if (value == searchValue) {
                return index
            } else {
                index = index + 1
            }
        }
        
        return -1
    }
    

}
