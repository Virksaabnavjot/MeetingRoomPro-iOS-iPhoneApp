//
//  BuildingsCell.swift
//  MRPro
//
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//
//Class Purpose: This class help create a custom table view cell for displaying building information in the
//buildings table view

import UIKit

class BuildingsCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var numberOfFloorsLabel: UILabel!
    
    @IBOutlet weak var cellVu: UIView!
    @IBOutlet weak var countryLabel: UILabel!
}
