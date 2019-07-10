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
    
    var fetchResults: [Appointment] = []
    
    var appointment: Appointment!
    
    let GET_ALL_APPT_URL = "http://localhost:9010/api/appointments"
    let CREATE_APPT_URL = "http://localhost:9010/api/appointment"
    
    enum DATETIMEINFO {
        case date
        case time
    }
    
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
        
        fetchAllAppointment()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func fetchAllAppointment() {
        HTTPHandler.getAPI(urlString: GET_ALL_APPT_URL, completionHandler: parseDataIntoAppts)
    }
    
    func parseDataIntoAppts(data: Data?) -> Void {
        if let data = data {
            let object = ApptJSONParser.parseAppts(data: data)
            if let object = object {
                self.fetchResults = ApptDataProcessor.mapJsonToAppts(object: object)
                print("Fetch Result: \(fetchResults.count)")
                self.upcomingAppointments = upcomingAppointments(appointments: self.fetchResults)
                self.completedAppointments = completedAppointments(appointments: self.fetchResults)
                
                print("Upcoming: \(self.upcomingAppointments.count)")
                print("Completed: \(self.completedAppointments.count)")

                DispatchQueue.main.async {
                    self.outTableView.reloadData()
                    print("Updating View")
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (outSegmentedControl.selectedSegmentIndex ==  APPTTYPE.Upcoming.value()) {
            // return dc.upcomingAppointments.count
            return upcomingAppointments.count
        }
        
        //return dc.completedAppointments.count
        return completedAppointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("function: \(#function)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ApptTableViewCell
        
        var appointments: [Appointment] = []
        
        if (outSegmentedControl.selectedSegmentIndex ==  APPTTYPE.Upcoming.value()) {
            appointments = upcomingAppointments
        } else {
            appointments = completedAppointments
        }
        if (appointments.count > 0) {
            let row = indexPath.row
            
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
                
                if (outSegmentedControl.selectedSegmentIndex ==  APPTTYPE.Upcoming.value()) {
                    let upcomingappointment = upcomingAppointments[row]
                    
                    vc.id = upcomingappointment.id
                    
                    vc.isUpcoming = true
                } else {
                    let completedappointment = completedAppointments[row]
                    
                    vc.id = completedappointment.id
                    
                    vc.isUpcoming = false
                }
            }
        }
    }
    
    func createAppointment() {
        
        //create Data object
        let date = "\(appointment.date) \(appointment.time)" as AnyObject
        let loc = appointment.location as AnyObject
        let pur = appointment.purpose as AnyObject
        
        let apptDict: [String: AnyObject] = ["datetime": date,
                                             "location":loc, "purpose": pur]
        
        let apptData = try! JSONSerialization.data(withJSONObject: apptDict, options: [])
        
        HTTPHandler.postAPI(urlString: CREATE_APPT_URL, dataToUpload: apptData, completionHandler: postAPICreateAppts)
    }
    
    func updateAppointment() {
        //create Data object
        let date = "\(appointment.date) \(appointment.time)" as AnyObject
        let loc = appointment.location as AnyObject
        let pur = appointment.purpose as AnyObject
        
        let apptDict: [String: AnyObject] = ["datetime": date,
                                             "location":loc, "purpose": pur]
        
        let apptData = try! JSONSerialization.data(withJSONObject: apptDict, options: [])
        
        HTTPHandler.putAPI(urlString: "http://localhost:9010/api/appointment/\(appointment.id)", dataToUpload: apptData, completionHandler: putAPIUpdateApp)
    }
    
    func postAPICreateAppts(data: Data?) -> Void {
        if let data = data, let dataString = String(data: data, encoding: .utf8) {
            DispatchQueue.main.async {
                print("Adding New Appointment: \(dataString)")
                //update the appointment.
                self.fetchAllAppointment()
                self.outTableView.reloadData()
            }
        }
    }
    
    func putAPIUpdateApp(data: Data?) -> Void {
        if let data = data, let dataString = String(data: data, encoding: .utf8) {
            DispatchQueue.main.async {
                print("Updating Appointment: \(dataString)")
                //update the appointment.
                self.fetchAllAppointment()
                self.outTableView.reloadData()
            }
        }
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
        print("unwind Segue")
        
        //check id of apptData
        if (appointment.id == -1) {
            //call postAPI to create new appointment.
            print("New Appointment")
            createAppointment()
        } else {
            //call putAPI to update appointment.
            print("Update Existing Appointment")
            updateAppointment()
        }
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
    
    func convertToDate(dateString: String, timeString: String) -> Date {
        let dateFormatter = DateFormatter()
        
        let dateToConvert = "\(dateString) \(timeString)"
        
        print("dateToConvert: \(dateToConvert)")
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let date = dateFormatter.date(from: dateToConvert) else {
            fatalError("Fail to convert String to Date ⚠️")
        }
        
        return date
    }
    
    //for each appointment, compare current date with
    //current date/time.
    //if later than current date/time, add to list
    func upcomingAppointments(appointments: [Appointment]) -> [Appointment] {
        
        var upcomingAppts: [Appointment] = []
        
        let currentdate = Date()
        
        for appointment in appointments {
            let apptDateTime = convertToDate(dateString: appointment.date, timeString: appointment.time)
            
            if (apptDateTime > currentdate) {
                upcomingAppts.append(appointment)
                
                print("Upcoming: Date: \(dateToday(type: DATETIMEINFO.date)) time: \(dateToday(type: DATETIMEINFO.date))")
            }
        }
        
        return upcomingAppts
    }
    
    //for each appointment, compare current date with
    //current date/time.
    //if earlier than current date/time, add to list
    func completedAppointments(appointments: [Appointment]) -> [Appointment] {
        var completedAppts: [Appointment] = []
        
        let currentdate = Date()
        
        for appointment in appointments {
            let apptDateTime = convertToDate(dateString: appointment.date, timeString: appointment.time)
            
            if (apptDateTime < currentdate) {
                completedAppts.append(appointment)
                
                print("Completed: Date: \(dateToday(type: DATETIMEINFO.date)) time: \(dateToday(type: DATETIMEINFO.date))")
            }
        }

        return completedAppts
    }
}

