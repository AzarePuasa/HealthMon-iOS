# Health Monitoring Application

This is an application created for my RP Specialist Dip in Mobile Application(C3209C). This is a document on its implementation 

## Introduction
When the app is loaded, user is presented with a view with 3 tabs. 
- Health Appointments
- Weight Records
- Blood Pressure Readings

## Health Appointments 
This function enables users to perform list, view, add and edit health appointments.

### Health Appointments

#### Appointments
This viewcontroller list the user's health appointments. The view makes use of 2 main IU Object; a segmented control with 2 labels; 'Upcoming' and 'Completed' and a table view. 

Appointments data are stored in a remote db. So HealthMon makes a get request to a REST API server to pull all the Appointments. The server returns a response containing an array of Appointment data in the JSON string format. HealthMon reads the JSON and turns it into an array of Appointment object. HealthMon then categorized the Appointments based on the date variable. If the appointment date/time is later current date/time, it will be categorize as 'Upcoming' while Appointment object with date that are before current date/time, it will be categorize as 'Completed'. HealthMon then loads the appointment into the appropriate segmented control.

The Segmented control enables user to switch between the categories. HealthMon uses the Appointment array that is initialized when the view is loaded. The Upcoming tab will load the Appointments in UpcomingAppointment array while Completed tab loads the Appointments in UpcomingAppointment. When the view is loaded, the Upcoming tab is displayed.

The Appointments view controller also handles creation of new Appointments and editing of current Appointment. A new appointment will come from AddApptViewController while edited Appointment will come from EditApptViewController. These 2 viewcontrollers will makes use of unwind segue. The unwind segue method differentiates between these 2 by its id. Id for new Appointment is -1 while edited Appointment is a non-zero integer.

For new Appointment, this VC will convert the Appointment object into JSON and then makes a post request to the REST API server and then makes a get request to get the Appointments and then updates the table view. If the Appointment is edited, this VC will convert the Appointment object into JSON and makes a put request to the REST API server and then makes a get request to get the Appointments and then updates the table view.

When user clicks on the '+' at the top right of the screen, a show segue directs user to Add Appointment screen. 

Clicking on a row invoke a show segue to the View Appointment screen. The selected appointment details will be send forward to the View Appointment View controller

### Add Appointment

### View Appointment