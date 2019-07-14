# Health Monitoring Application

This is an application created for my RP Specialist Dip in Mobile Application(C3209C). This is a document on its implementation 

## Introduction
There are 3 parts to the application
- Health Appointments
- Weight Records
- Blood Pressure Readings

## Health Appointments

### Health Appointments

#### Appointments
This view list the user's health appointments. The view makes use of 2 main IU Object; a segmented control with 2 labels; 'Upcoming' and 'Completed' and a table view. 

Appointmens data is stored remotely. So HealthMon makes a REST API call to pull the appointments data. The API responses with an array of Appointment data in JSON string. HealthMon reads the JSON response and turns it into an array of Appointment object. HealthMon then categorized the appointments based on the dates. If the appointment date/time is later current date/time, it will be categorize as Upcoming while appointment that are before current date/time, it will be categorize as Completed. HealthMon then loads the appointment into the appropriate segmented control.
