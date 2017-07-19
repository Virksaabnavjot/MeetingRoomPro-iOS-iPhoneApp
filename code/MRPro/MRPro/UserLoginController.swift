//
//  UserLoginController.swift
//  MRPro
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import ChameleonFramework

class UserLoginController: UIViewController {

    @IBAction func loginButton(_ sender: AnyObject) {
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting a custom color for the view
        view.backgroundColor = UIColor.white
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

