//
//  BPViewController.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 14/7/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import UIKit

class BPViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var outTableView: UITableView!
    
    @IBOutlet weak var outImageHeader: UIImageView!
    
    @IBOutlet weak var outLabelHeader: UILabel!
    
    @IBOutlet weak var outLabelSubHeader: UILabel!
    
    var DailyBPReadings: [BPDailyReading] = []
    
    var bpReadingPeriod: BPReading?
    
    let GET_ALL_BPREADING_URL = "http://localhost:9010/api/bpreadings"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Load image
        let image = UIImage(named: "icons8-bp-24")
        outImageHeader.image = image
        
        //Load Header & Sub-Header
        outLabelHeader.text = "Blood Pressure"
        outLabelSubHeader.text = "BP Readings"
        
        //TODO: Fetch BP Daily Readings. Each row will
        // return id, date, morningbp, afternoonbp & eveningbp.
        fetchAllBPReadings()
    }
    
    func fetchAllBPReadings() {
        HTTPHandler.getAPI(urlString: GET_ALL_BPREADING_URL, completionHandler: parseDataIntoDailyReadings)
    }
    
    func parseDataIntoDailyReadings(data: Data?) -> Void {
        if let data = data {
            let object = JSONParser.parseItems(data: data)
            if let object = object {
                self.DailyBPReadings = BPDataProcessor.mapJsonToDailyBPReadings(object: object)
                print("BP Readings Fetched: \(DailyBPReadings.count)")
                
                DispatchQueue.main.async {
                    self.outTableView.reloadData()
                    print("Updating View")
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DailyBPReadings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bpcell", for: indexPath) as! BPTableViewCell
        
        let row = indexPath.row
        
        let dailyBPReading = DailyBPReadings[row]
        
        if let label = cell.outLabelDate{
            label.text = dailyBPReading.date
        }
        
        if let label = cell.outLabelMorningBP{
            label.text = dailyBPReading.morningBP
        }
        
        if let label = cell.outLabelAfternoonBP{
            label.text = dailyBPReading.afternoonBP
        }
        
        if let label = cell.outLabelEveningBP{
            label.text = dailyBPReading.eveningBP
        }
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func unwindBPSegue(_ sender: UIStoryboardSegue) {
        print("unwind Segue")
    
        //TODO: Handle return of new BP Reading.
        // Call Update BP Reading REST API endpoint.
        if let bpReading = bpReadingPeriod {
            print(bpReading.describe())
        }
        
    }
    

}
