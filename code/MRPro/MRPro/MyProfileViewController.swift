//
//  MyProfileViewController.swift
//  MRPro
//
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {
    
    
    @IBOutlet weak var myProfileScrollView: UIScrollView!
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        //setting a custom color for the view
        //view.backgroundColor = UIColor.white
        myProfileScrollView.tintColor = UIColor.orange
        
        let userDict =  UserDefaults.standard.object(forKey: "userData") as! NSDictionary

        self.nameLbl.text = userDict["name"] as? String
        self.emailLbl.text = userDict["email"] as? String

        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
