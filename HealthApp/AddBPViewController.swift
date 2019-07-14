//
//  AddBPViewController.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 14/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import UIKit

class AddBPViewController: UIViewController {

    @IBOutlet weak var outImageHeader: UIImageView!
    
    @IBOutlet weak var outLabelHeader: UILabel!
    
    @IBOutlet weak var outLabelSubHeader: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Load image
        let image = UIImage(named: "icons8-bp-24")
        outImageHeader.image = image
        
        //Load Header & Sub-Header
        outLabelHeader.text = "Blood Pressure"
        outLabelSubHeader.text = "Add BP Reading"
        
        //TODO: Autopopulate the date field and Type field.
        //Type field:
        //MORNING if time is after 7am and before 12pm.
        //AFTERNOON if time is after 12pm and before 7pm.
        //EVENING if time is after 7pm and before 12am.
        //INVALID if time is after 12am to 7am.
        
        //if type is INVALID, disable save button.
        
        //set default systolic pickerview to 120
        //set default diastolic pickerview to 80
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //TODO: Send data back to BPViewController
        
    }
    

}
