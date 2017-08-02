//
//  UserLoginController.swift
//  MRPro
//  Purpose: Allows the user to login
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit
import SwiftyJSON
import ChameleonFramework
import Foundation

/*
 Class - Deals with user login
 */
class UserLoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!

    
    //Login button - activated when user clicks
    @IBAction func loginButton(_ sender: AnyObject) {
        
        //displaying alerts if user didn't input all the needed information
        if (self.emailTextField.text?.isEmpty)!
        {
            self.displayAlert("Email Missing")
        }
        else if (self.passwordTextField.text?.isEmpty)!
        {
            self.displayAlert("Password Missing")

        }
        else
        {
            var dictRequest: [String : Any] = [:]
            
            //get user entered details
            dictRequest["email"] = self.emailTextField.text
            dictRequest["password"] = self.passwordTextField.text
            
            //login request
            API.sharedInstance.login(dictRequest) { (success, dictData) -> Void in
                
                //if request is sucessfull
                if success == true {
                    print(dictData)
                    let userData = dictData as! NSDictionary
                    
                    //saving user details in user defaults for later use
                    UserDefaults.standard.set(userData["data"], forKey: "userData")
                    
                    //perform segue - login the user and show next screen
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                    
                }else{
                    //else display an alert with the status code / error message recieved
                    self.displayAlert(dictData["code"] as! String!)

                }
            }
            
        }
        
    }
    
    //display alert method - helps to display an alert
    func displayAlert(_ msg:String!,needDismiss:Bool = false,title:String = "MRPro")  {
        
        //creating instance of UIAlertController
        let alertController = UIAlertController(title:title, message:msg, preferredStyle: .alert)
        
        //assigning actions to alert
        let defaultAction = UIAlertAction(title:"ok", style: .cancel) { (action) in
            if needDismiss {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        
        //adding action to the alert controller
        alertController.addAction(defaultAction)
        
        //presenting the alert
        self.present(alertController, animated: true, completion: nil)
    }
    
    //signup button - takes the user to signup screen
    @IBAction func signUpBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "toSignUp", sender: self)

    }
    
    //view did load method - activated when the view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //styling the login button - making round corners
        self.loginBtn.layer.cornerRadius = self.loginBtn.frame.size.height/2.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

