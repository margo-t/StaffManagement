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
        
        attemptFetch()
        
        print("Current Waiter")
        print(currentWaiter!.name ?? "non?")
        
        generateTestData()
        

        
    }
    
    //set up table view controller
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShiftCell", for: indexPath) as! ShiftCell
        
        //closure for shift
//        let shift = contr.object(at: (indexPath as NSIndexPath) as IndexPath)
//        cell.completedAction = { (self) in
//            cell.updateCompletion(shift: shift)
//        }


        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: ShiftCell, indexPath: NSIndexPath) {
        
        let shift = controller.object(at: indexPath as IndexPath)
        cell.configureCell(shift: shift)
    }
    
    //Navigation
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let obj = controller.fetchedObjects , obj.count > 0 {
//
//            let task = obj[indexPath.row]
//            performSegue(withIdentifier: "TaskDetailsVC", sender: task)
//
//        }
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "TaskDetailsVC" {
//
//            if let destination = segue.destination as? TaskDetailsViewController {
//
//                if let task = sender as? Task {
//                    destination.taskToEdit = task
//                }
//            }
//
//        }
//    }
    
    
    
    //connect to core data
    func attemptFetch() {
        
//        let context = (UIApplication.shared.delegate as! AppDelegate!).persistentStoreCoordinator.context
        
        
        //NSSortDescriptor *sortByName = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
        //self.waiters = [[[RestaurantManager sharedManager]currentRestaurant].staff sortedArrayUsingDescriptors:@[sortByName]];
        
        let fetchRequest: NSFetchRequest<Shift> = Shift.fetchRequest()
        let dateSort = NSSortDescriptor(key: "startTime", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: (appDelegate?.managedObjectContext)!, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        self.controller = controller
        
        do {
            try controller.performFetch()
            
        } catch {
            let error = error as NSError
            print("\(error)")
        }

        
        
//        let fetchRequest: NSFetchRequest<Shift> = Shift.fetchRequest()
//        let dateSort = NSSortDescriptor(key: "created", ascending: false)
//        fetchRequest.sortDescriptors = [dateSort]
//
//        //AppDelegate.saveContext()
//        //let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
//
//        controller.delegate = self
//        self.controller = controller
        
//        var aWaiter: Waiter?
//        var error: Error? = nil
//        let appDelegate = UIApplication.shared.delegate as? AppDelegate
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Waiter")
//        //var results = try appDelegate?.managedObjectContext.fetch(request)
//
//        do {
//            let results = try appDelegate?.managedObjectContext.fetch(request)
//            let resultsNum = (results?.count)!
//            if resultsNum > 0 {
//                print("results.count > 0?")
//                print("\(UInt(resultsNum))")
//                aWaiter = results![0] as? Waiter
//            }
//
//        } catch {
//            let error = error as NSError
//            print("\(error)")
//        }
        
        
        
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
        dateFormatterGet.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        //let
        
        let context = (appDelegate?.managedObjectContext)!
        
        //NSEntityDescription *waiterEntity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:_appDelegate.managedObjectContext];
        //let *aWaiter = Waiter()
        
        
        let entity = NSEntityDescription.entity(forEntityName: "Shift", in: context)!
        let shift = Shift(entity: entity, insertInto: context)
        //MyManagedObject *obj = [[MyManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:@"MyManagedObject" inManagedObjectContext:context] insertIntoManagedObjectContext:context];

//        let shift = Shift(entity: NSEntityDescription.entity(forEntityName: "Shift", in: context) ?? NSEntityDescription(), insertInto: context)
        
        //print(NSStringFromClass(shift.cl))
        //shift.toWaiter =
        shift.startTime = dateFormatterGet.date(from: "2016-02-29 12:24:26")
        shift.endTime = dateFormatterGet.date(from: "2016-02-29 16:24:26")

        //[aRestaurant addStaffObject:newWaiter];
        
        currentWaiter!.add(toShiftObject: shift)
        
        appDelegate?.saveContext()
        print(currentWaiter?.toShift?.count ?? 0);
        
    }
    



}
