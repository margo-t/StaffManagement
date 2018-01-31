//
//  NewShiftVC.swift
//  StaffManagement
//
//  Created by margot on 2018-01-31.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import UIKit

class NewShiftVC: ViewController {
    
    @IBOutlet weak var dateLabel: UITextField!
    @IBOutlet weak var startLabel: UITextField!
    @IBOutlet weak var finishLabel: UITextField!
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    let timePicker2 = UIDatePicker()
    var shiftDate = Date()
    var startTime = Date()
    var endTime = Date()
    
    var currentWaiter:  Waiter?
    var appDelegate2 = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func saveShiftLabel(_ sender: Any) {
        
        if (dateLabel.text != "" && startLabel.text != "" && finishLabel.text != "") {
            
            let context = (appDelegate2.managedObjectContext)
            
            let entity = NSEntityDescription.entity(forEntityName: "Shift", in: context!)
            let shift = Shift(entity: entity!, insertInto: context)
            
            shift.startTime = startTime
            shift.endTime = endTime
            shift.waiterName = currentWaiter?.name
            
            currentWaiter!.add(toShiftObject: shift)
            
            appDelegate2.saveContext()
            print(currentWaiter?.toShift?.count ?? 0);
            
            NotificationCenter.default.post(name: NSNotification.Name("reload_data"), object: self)
            navigationController?.popViewController(animated: true)
        }
        else {
            let alert = UIAlertController(title: "Warning!", message: "All fields must contain text", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showDatePicker()
        showTimePicker()
        showEndTimePicker()
        
        print("viewDidLoad - NewShiftVC")
        print(currentWaiter?.name ?? "nho")
    }
    
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        let today = NSDate()
        let nextYear = NSCalendar.current.date(byAdding: Calendar.Component.year,
            value: 1, //one year from now
            to: today as Date)
        
        datePicker.minimumDate = Date()
        datePicker.maximumDate = nextYear
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(NewShiftVC.donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(NewShiftVC.cancelPicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: true)
        
        dateLabel.inputAccessoryView = toolbar
        dateLabel.inputView = datePicker
        
    }
    

    
    func showTimePicker(){
        
        //Formate Time
        timePicker.datePickerMode = .time
        timePicker.minuteInterval = 15

        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(NewShiftVC.doneStartPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(NewShiftVC.cancelPicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: true)
        
        
        startLabel.inputAccessoryView = toolbar
        startLabel.inputView = timePicker
        
    }
    
    func showEndTimePicker(){
        
        //Formate Time
        timePicker2.datePickerMode = .time
        timePicker2.minuteInterval = 15
        timePicker2.timeZone = NSTimeZone.local
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(NewShiftVC.doneFinishPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(NewShiftVC.cancelPicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: true)
        
        
        finishLabel.inputAccessoryView = toolbar
        finishLabel.inputView = timePicker2
        
    }

    
    func doneStartPicker(){
        
        if (dateLabel.text != "") {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            startLabel.text = formatter.string(from: timePicker.date)
            startTime = getShift(givenDate: dateLabel.text!, givenTime: startLabel.text!)
            print(startTime)
            self.view.endEditing(true)
        }
        else {
            let alert = UIAlertController(title: "Warning!", message: "Add date first", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            
        }
        
    }
    
    func doneFinishPicker(){
        
        if (startLabel.text != "") {
            
            
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            finishLabel.text = formatter.string(from: timePicker2.date)
            endTime = getShift(givenDate: dateLabel.text!, givenTime: finishLabel.text!)
            
            print(endTime)
            
            if endTime>startTime{
                self.view.endEditing(true)
            }
            else {
                let alert = UIAlertController(title: "Warning!", message: "Shift can't end before starting", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.view.endEditing(true)
            }
            
        }
        else {
            let alert = UIAlertController(title: "Warning!", message: "Add start time first", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
        }
        
    }
    
    func donedatePicker(){
        
        shiftDate = datePicker.date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateLabel.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    func cancelPicker(){
        self.view.endEditing(true)
    }

    func getShift(givenDate: String, givenTime: String) -> Date
    {
        let composedDate = givenDate+" "+givenTime
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dateTime = formatter.date(from: composedDate)
        
        return dateTime!
    }
}

extension Date {
    
    var localTime: String {
        return description(with: NSLocale.current)
    }
}
