//
//  WeightViewController.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 11/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import UIKit

class WeightViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var outImageHeader: UIImageView!
    
    @IBOutlet weak var outLabelHeader: UILabel!
    
    @IBOutlet weak var outLabelSubHeader: UILabel!
    
    @IBOutlet weak var outTableView: UITableView!
    
    var weightRecords: [Weight]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        outTableView.delegate = self
        outTableView.dataSource = self
        
        //Load image
        let image = UIImage(named: "icons8-scale-24")
        outImageHeader.image = image
        
        //Load Header & Sub-Header
        outLabelHeader.text = "Weight"
        outLabelSubHeader.text = "Weight Records"
        
        //TODO: get weight records.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weightRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
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
