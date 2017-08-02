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
            
            dictRequest["email"] = self.emailTextField.text
            dictRequest["password"] = self.passwordTextField.text
            
            API.sharedInstance.login(dictRequest) { (success, dictData) -> Void in
                
                if success == true {
                    print(dictData)
                    let userData = dictData as! NSDictionary
                    
                    UserDefaults.standard.set(userData["data"], forKey: "userData")
                    
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                    
                    
                    
                    
                }else{
                    
                    self.displayAlert(dictData["code"] as! String!)

                }
            }
            

        }
        
        
    }
    func displayAlert(_ msg:String!,needDismiss:Bool = false,title:String = "MRPro")  {
        
        let alertController = UIAlertController(title:title, message:msg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title:"ok", style: .cancel) { (action) in
            if needDismiss {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func signUpBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "toSignUp", sender: self)


    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor(patternImage: UIImage(named: "myProfileIcon.png")!)
        
        self.loginBtn.layer.cornerRadius = self.loginBtn.frame.size.height/2.0
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

