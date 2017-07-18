//
//  UserLoginController.swift
//  MRPro
//  Created by Nav on 15/04/2017.
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

