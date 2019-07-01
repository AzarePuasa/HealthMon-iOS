//
//  ViewController.swift
//  HealthApp
//
//  Created by Noorazare B Puasa on 10/4/19.
//  Copyright © 2019 Noorazare B Puasa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var outTableView: UITableView!
    
    @IBOutlet weak var outSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var outImageHeader: UIImageView!
    
    @IBOutlet weak var outLabelHeader: UILabel!
    
    @IBOutlet weak var outLabelSubHeader: UILabel!
    
    var upcomingAppointments: [Appointment] = []
    
    var completedAppointments: [Appointment] = []
    
    enum APPTTYPE {
        case Upcoming
        case Completed
        
        func value() -> Int {
            switch self {
            case .Upcoming:
                    return 0
            case .Completed:
                    return 1
            }
        }
    }
    
    
    var dc = ApptDataController.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        outTableView.delegate = self
        outTableView.dataSource = self
        
        //Load image
        let image = UIImage(named: "calendarscope")
        outImageHeader.image = image
        
        
        //Load Header & Sub-Header
        outLabelHeader.text = "Appointment"
        outLabelSubHeader.text = "Appointments"
        
        upcomingAppointments = dc.upcomingAppointments
        completedAppointments = dc.completedAppointments
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (outSegmentedControl.selectedSegmentIndex ==  APPTTYPE.Upcoming.value()) {
            return dc.upcomingAppointments.count
        }
        
        return dc.completedAppointments.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ApptTableViewCell
        
        let row = indexPath.row
        
        var appointments: [Appointment] = []
        
        if (outSegmentedControl.selectedSegmentIndex ==  APPTTYPE.Upcoming.value()) {
            appointments = upcomingAppointments
        } else {
             appointments = completedAppointments
        }
        
        let appt = appointments[row]
        
        if let label = cell.outDate{
            label.text = appt.date
        }
        
        if let label = cell.outTime{
            label.text = appt.time
        }
        
        if let label = cell.outLocation{
            label.text = appt.location
        }
        
        return cell
    }
    
    
    @IBAction func actSegmentedControlChange(_ sender: UISegmentedControl) {
        outTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //check segmented control on which segue to use.
        let identifier = segue.identifier
        
        if (identifier == "view") {
            let vc = segue.destination as! UpcomingApptViewController
            
            if let indexPath = outTableView.indexPathForSelectedRow {
                let row = indexPath.row
                
                let upcomingappointment = upcomingAppointments[row]
                
                vc.id = upcomingappointment.id
                
                vc.isUpcoming = outSegmentedControl.selectedSegmentIndex
                    == APPTTYPE.Completed.value() ? false : true
            }
        }
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
        print("unwind Segue")
        
        upcomingAppointments = dc.upcomingAppointments
        completedAppointments = dc.completedAppointments
        
        outTableView.reloadData()
    }
}

