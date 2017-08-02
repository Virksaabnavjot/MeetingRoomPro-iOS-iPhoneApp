//
//  RegistrationViewController.swift
//  MRPro
//  Purpose: Handles user registration/signup
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit

/*
 User Registration
 */
class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var confirmPasswordTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var phoneNumberTxtFld: UITextField!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var nameTxtFld: UITextField!
    override func viewDidLoad() {
        
        //load view
        super.viewDidLoad()
        
        // styling the register button - round corners
        self.registerBtn.layer.cornerRadius = self.registerBtn.frame.size.height/2.0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //when register button is tapped
    @IBAction func registerBtnTapped(_ sender: Any) {
        
        //check if user have inputted necessary data in all fields, if not show an error alert
        if (self.nameTxtFld.text?.isEmpty)!
        {
            self.displayAlert("Name Missing")
            
        }
        else if (self.emailTxtFld.text?.isEmpty)!
        {
            self.displayAlert("Email Missing")
            
        }
        else if (self.phoneNumberTxtFld.text?.isEmpty)!
        {
            self.displayAlert("Phone Number Missing")
            
        }
        else if (self.passwordTxtFld.text?.isEmpty)!
        {
            self.displayAlert("Password Missing")
            
        }
        else if (self.confirmPasswordTxtFld.text?.isEmpty)!
        {
            self.displayAlert("Confirm Password Missing")
            
        }
        else if (self.passwordTxtFld.text != self.confirmPasswordTxtFld.text)
        {
            self.displayAlert("Confirm Password doesnot match with Password")
            
        }
        else
        {
            //else proceed with registration
            var dictRequest: [String : Any] = [:]
            
            //get user inputted data/details
            dictRequest["name"] = self.nameTxtFld.text
            dictRequest["email"] = self.emailTxtFld.text
            dictRequest["phone"] = self.phoneNumberTxtFld.text
            dictRequest["password"] = self.passwordTxtFld.text
            
            //make api request to register
            API.sharedInstance.register(dictRequest) { (success, dictData) -> Void in
                
                //if request if sucessful
                if success == true {
                    print(dictData)
                    let userData = dictData as! NSDictionary
                    
                    //save user data in user defaults
                    UserDefaults.standard.set(userData["data"], forKey: "userData")
                    
                    //perform segue/transition to next screen
                    self.performSegue(withIdentifier: "toProfile", sender: self)
                    
                    
                }else{
                    
                    //else display alert with error message
                    self.displayAlert(dictData["code"] as! String!)
                    
                }
            }
            
        }
        
    }
    
    //display alert method
    func displayAlert(_ msg:String!,needDismiss:Bool = false,title:String = "MRPro")  {
        
        //create instance
        let alertController = UIAlertController(title:title, message:msg, preferredStyle: .alert)
        
        //assign actions to alert
        let defaultAction = UIAlertAction(title:"ok", style: .cancel) { (action) in
            if needDismiss {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        //add actions
        alertController.addAction(defaultAction)
        
        //show/present alert
        self.present(alertController, animated: true, completion: nil)
    }
    
}
