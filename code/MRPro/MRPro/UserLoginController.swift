//
//  UserLoginController.swift
//  MRPro
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit
import SwiftyJSON
import ChameleonFramework
import Foundation

class UserLoginController: UIViewController {
    let loginUrl = "https://www.navsingh.org.uk/mrpro/api/login.php"
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func loginButton(_ sender: AnyObject) {
        
    performSegue(withIdentifier: "loginSegue", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "myProfileIcon.png")!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

