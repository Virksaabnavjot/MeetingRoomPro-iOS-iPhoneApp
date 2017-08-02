//
//  MeetingRoomsCell.swift
//  MRPro
//  Purpose: Helps create a Custom UITableview cell to display meeting room and my meetings data in table view
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit

/*
 custom table view cell - different labels for all the information we will be dealing with for meeting rooms list and my meetings this cell is used in 2 different views
 */
class MeetingRoomsCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var buildingName: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var cellVu: UIView!
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var floorNumberLabel: UILabel!
}
