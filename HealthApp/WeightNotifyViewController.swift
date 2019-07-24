//
//  WeightNotifyViewController.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 24/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import UIKit

class WeightNotifyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    
    @IBAction func actBtnDone(_ sender: Any) {
        performSegue(withIdentifier: "exitNotWeight", sender: self)
    }
    
}
