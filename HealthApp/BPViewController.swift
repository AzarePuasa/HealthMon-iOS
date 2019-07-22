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
    
    var bpReading: BPReading?
    
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
        
        let identifier = segue.identifier
        
        if (identifier == "addBP") {
            let vc = segue.destination as! AddBPViewController
            
            vc.hidesBottomBarWhenPushed = true
        }
    }
    
    @IBAction func unwindBPSegue(_ sender: UIStoryboardSegue) {
        print("unwind Segue")
    
        // TODO: Handle return of new BP Reading.
        // Call Update BP Reading REST API endpoint.
        if let bpReading = bpReading {
            print(bpReading.describe())
            
            updateDailyBP()
        }
        
    }
    
    func updateDailyBP() {
        //TODO: save the new BPReading by making the API call.
        //The call depends on the BPReading Type field.
        
        //create Data object. This is a string
        
        if let bpReading = bpReading {
            let reading = "\(bpReading.systolic)/\(bpReading.diastolic)"
            
            //let obj = reading as AnyObject
            
            //let apptData = try! JSONSerialization.data(withJSONObject: reading, options: [])
            
            if (bpReading.type == AddBPViewController.BPTYPE.MORNING) {
                HTTPHandler.putAPIString(urlString: "http://localhost:9010/api/bpmorning/\(bpReading.dailyReadingId)", data: reading, completionHandler: putAPIUpdateBP)
            }
            
            if (bpReading.type == AddBPViewController.BPTYPE.AFTERNOON) {
                HTTPHandler.putAPIString(urlString: "http://localhost:9010/api/bpafternoon/\(bpReading.dailyReadingId)", data: reading, completionHandler: putAPIUpdateBP)
            }
            
            if (bpReading.type == AddBPViewController.BPTYPE.EVENING) {
                HTTPHandler.putAPIString(urlString: "http://localhost:9010/api/bpevening/\(bpReading.dailyReadingId)", data: reading, completionHandler: putAPIUpdateBP)
            }
        }
    }
    
    func putAPIUpdateBP(data: Data?) -> Void {
        if let data = data, let dataString = String(data: data, encoding: .utf8) {
            DispatchQueue.main.async {
                print("Updating BPDailyReading: \(dataString)")
                //update the appointment.
                self.fetchAllBPReadings()
                self.outTableView.reloadData()
            }
        }
    }
    

}
