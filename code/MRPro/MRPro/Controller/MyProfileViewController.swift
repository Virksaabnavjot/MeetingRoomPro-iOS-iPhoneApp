//
//  MyProfileViewController.swift
//  MRPro
//  Purpose: Handles User Profile
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit

/*
 Helps display user information in My Profile section of the app
 */
class MyProfileViewController: UIViewController {
    
    
    @IBOutlet weak var myProfileScrollView: UIScrollView!
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        
        myProfileScrollView.tintColor = UIColor.orange
        
        // get user defaults - the ones we saved in memory when used loged in
        let userDict =  UserDefaults.standard.object(forKey: "userData") as! NSDictionary

        //show the user details in my profile
        self.nameLbl.text = userDict["name"] as? String
        self.emailLbl.text = userDict["email"] as? String

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
