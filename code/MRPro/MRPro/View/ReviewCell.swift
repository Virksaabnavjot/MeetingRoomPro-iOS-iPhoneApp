//
//  ReviewCell.swift
//  MRPro
//  Purpose: This is a table view cell for displaying user reviews
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit
import RateView

/*
 custom tableview cell for room review data
 */
class ReviewCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var commentLbl: UITextView!
    @IBOutlet weak var rateView: RateView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
