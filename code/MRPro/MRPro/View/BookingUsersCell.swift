//
//  BookingUsersCell.swift
//  MRPro
//  Purpose: helps create a custom table cell to display information
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit

/*
 custom tableview cell to show users list in booking view (helps send booking invites)
 */
class BookingUsersCell: UITableViewCell {

    @IBOutlet weak var imgVu: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var checkImgVu: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
