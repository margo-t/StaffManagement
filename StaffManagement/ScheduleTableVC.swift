//
//  ScheduleTableVC.swift
//  StaffManagement
//
//  Created by margot on 2018-01-29.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import UIKit
import CoreData

class ScheduleTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var controller: NSFetchedResultsController<Shift>!
    var shifts: [Shift] = [];
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var currentWaiter:  Waiter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        attemptFetch(segmentType: "future")
        
        print("Current Waiter")
        print(currentWaiter!.name ?? "non?")
        
        //generateTestData()
        }
    
    
    
    @IBAction func segmentByTime(_ sender: Any) {
        switch segment.selectedSegmentIndex
        {
            case 0:
                print("First Segment Selected")
                attemptFetch(segmentType: "future")
                tableView.reloadData()
            
            
            case 1:
                print("Second Segment Selected")
                attemptFetch(segmentType: "past")
                tableView.reloadData()
            
            
            default:
            break
        }
        
    }
    @IBAction func toNewShift(_ sender: UIBarButtonItem) {
        
        print("button to toNewShift")
        performSegue(withIdentifier: "toNewShift", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if "toNewShift" == segue.identifier {
            
            print("prepareForSegue2")
            let yourNextViewController = (segue.destination as! NewShiftVC)
            yourNextViewController.currentWaiter = currentWaiter
        }

    }
    
    //set up table view controller
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //set up link to custom view cell here
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShiftCell", for: indexPath) as! ShiftCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: ShiftCell, indexPath: NSIndexPath) {
        
        let shift = controller.object(at: indexPath as IndexPath)
        cell.configureCell(shift: shift)
    }
    
    
    //connect to core data
    func attemptFetch(segmentType: String) {
        
        // request for all Shifts and ordered by start time
        let fetchRequest: NSFetchRequest<Shift> = Shift.fetchRequest()
        let dateSort = NSSortDescriptor(key: "startTime", ascending: true)
        fetchRequest.sortDescriptors = [dateSort]
        
        //sort out shifts belonging to the current waiter name
        let waiterShiftsPredicate = NSPredicate(format: "waiterName == %@", (currentWaiter?.name)!)
        fetchRequest.predicate = waiterShiftsPredicate
        
        //view upcoming or past shifts
        if (segmentType == "future"){
            print("type future")
            let shiftsPredicate = NSPredicate(format: "startTime > %@", Date() as CVarArg)
            let additionalPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [waiterShiftsPredicate, shiftsPredicate])
            fetchRequest.predicate = additionalPredicate
        } 
        else {
             print("type past")
            let pastShiftsPredicate = NSPredicate(format: "startTime < %@", Date() as CVarArg)
            let additionalPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [waiterShiftsPredicate, pastShiftsPredicate])
            fetchRequest.predicate = additionalPredicate
        }

        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: (appDelegate?.managedObjectContext)!, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        self.controller = controller
        
        do {
            try controller.performFetch()
            
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = controller.sections {
            return sections.count
        }
        
        return 0
    }
    
    //fetched results controller for displaying data
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            
            
        case.insert:
            if let indexPath = newIndexPath {
                
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        case.delete:
            if let indexPath = indexPath {
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
            
        case.update:
            if let indexPath = indexPath {
                
                let cell = tableView.cellForRow(at: indexPath) as! ShiftCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
                
            }
            break
            
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            if let indexPath = indexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
            
        }
    }

  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    //populate with test data
    func generateTestData() {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let context = (appDelegate?.managedObjectContext)!
        
        
        let entity = NSEntityDescription.entity(forEntityName: "Shift", in: context)!
        let shift = Shift(entity: entity, insertInto: context)

        shift.startTime = dateFormatterGet.date(from: "2018-02-05 12:00:00")
        shift.endTime = dateFormatterGet.date(from: "2018-02-05 16:00:00")
        shift.waiterName = currentWaiter?.name
        
        currentWaiter!.add(toShiftObject: shift)
        
        appDelegate?.saveContext()
        print(currentWaiter?.toShift?.count ?? 0);
        
    }
    
}
