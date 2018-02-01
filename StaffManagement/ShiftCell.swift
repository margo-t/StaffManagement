//
//  ShiftCellTableViewCell.swift
//  StaffManagement
//
//  Created by margot on 2018-01-29.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import UIKit

class ShiftCell: UITableViewCell {
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var MonthLabel: UILabel!
    @IBOutlet weak var DOWLabel: UILabel!
    @IBOutlet weak var startShiftLabel: UILabel!
    @IBOutlet weak var EndShiftLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(shift: Shift) {
        
        let startTime = shift.startTime!
        
        let finishTime = shift.endTime!
        
        
        DateLabel.text = startTime.toString(dateFormat: "dd")
        MonthLabel.text = startTime.toString(dateFormat: "MMMM")
        DOWLabel.text = startTime.toString(dateFormat: "E")
        startShiftLabel.text = startTime.toString(dateFormat: "HH:mm")
        EndShiftLabel.text = finishTime.toString(dateFormat: "HH:mm")
    }

}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
