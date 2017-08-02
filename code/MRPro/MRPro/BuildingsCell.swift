//
//  BuildingsCell.swift
//  MRPro
//  Purpose: This class help create a custom table view cell for displaying building information in the
//  buildings table view
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit

/*
 custom tableview cell for building data
 */
class BuildingsCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var numberOfFloorsLabel: UILabel!
    @IBOutlet weak var cellVu: UIView!
    @IBOutlet weak var countryLabel: UILabel!
}
