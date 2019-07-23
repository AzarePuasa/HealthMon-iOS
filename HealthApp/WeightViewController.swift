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
    
    let GET_ALL_WEIGHT_URL = "http://localhost:9010/api/weights"
    let CREATE_WEIGHT_URL = "http://localhost:9010/api/weight"
    
    var newWeightRecord: Weight!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        outTableView.delegate = self
        outTableView.dataSource = self
        
        //Load image
        let image = UIImage(named: "icons8-scale-24")
        outImageHeader.image = image
        
        //Load Header & Sub-Header
        outLabelHeader.text = "My Weight"
        outLabelSubHeader.text = "Weight Records"
        
        //TODO: get weight records.
        fetchAllWeights()
    }
    
    func fetchAllWeights() {
        HTTPHandler.getAPI(urlString: GET_ALL_WEIGHT_URL, completionHandler: parseDataIntoWeights)
    }
    
    func parseDataIntoWeights(data: Data?) -> Void {
        //TODO: closure for getAPI
        if let data = data {
            let object = JSONParser.parseItems(data: data)
            
            if let object = object {
                self.weightRecords = WeightDataProcessor.mapJsonToWeights(object: object)
                print("Weight Records Fetched: \(weightRecords.count)")
                
                DispatchQueue.main.async {
                    self.outTableView.reloadData()
                    print("Updating View")
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weightRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weightcell", for: indexPath) as! WeightTableViewCell
        
        //TODO: map data to label.
        let row = indexPath.row
        
        let weightRecord = weightRecords[row]
        
        if let label = cell.outDate {
            label.text = weightRecord.date
        }
        
        if let label = cell.outWeightRecord {
            label.text = weightRecord.weight
        }
        
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let identifier = segue.identifier
        
        if (identifier == "addweight") {
            let vc = segue.destination as! AddWeightViewController
            
            vc.hidesBottomBarWhenPushed = true
        }
    }
    
    @IBAction func unwindWeightSegue(_ sender: UIStoryboardSegue) {
        print("unwind Segue")
        
        let identifier = sender.identifier
        
        if (identifier == "exitweight") {
            createWeight()
        } else if (identifier == "exitNotWeight") {
            print("Weight Notification")
        }
    }
    
    func createWeight() {
        //TODO: start process of creating new Weight Record
        
        //create Data object
        let date = newWeightRecord.date as AnyObject
        let weight = newWeightRecord.weight as AnyObject
        
        let weightDict: [String: AnyObject] = ["date": date,
                                             "weight":weight]
        
        let weightData = try! JSONSerialization.data(withJSONObject: weightDict, options: [])
        
        HTTPHandler.postAPI(urlString: CREATE_WEIGHT_URL, dataToUpload: weightData, completionHandler: postAPICreateWeight)
        
    }
    
    func postAPICreateWeight(data: Data?) -> Void {
        //TODO: fetch all weights again
        if let data = data, let dataString = String(data: data, encoding: .utf8) {
            DispatchQueue.main.async {
                print("Adding New Weight: \(dataString)")
                //update the appointment.
                self.fetchAllWeights()
                self.outTableView.reloadData()
            }
        }
    }

}
