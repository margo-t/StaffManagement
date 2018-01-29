//
//  ScheduleTableVC.swift
//  StaffManagement
//
//  Created by margot on 2018-01-29.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import UIKit

class ScheduleTableVC: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    public var titleName: String = "Nho"
   // public var currentWaiter: Waiter = Waiter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.text = titleName

    }



}
