//
//  RegistrationVC.swift
//  MRPro
//
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {

    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var confirmPasswordTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var phoneNumberTxtFld: UITextField!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var nameTxtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerBtn.layer.cornerRadius = self.registerBtn.frame.size.height/2.0

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func registerBtnTapped(_ sender: Any) {
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
            var dictRequest: [String : Any] = [:]

            dictRequest["name"] = self.nameTxtFld.text
            dictRequest["email"] = self.emailTxtFld.text
            dictRequest["phone"] = self.phoneNumberTxtFld.text
            dictRequest["password"] = self.passwordTxtFld.text
            
            API.sharedInstance.register(dictRequest) { (success, dictData) -> Void in
                
                if success == true {
                    print(dictData)
                    let userData = dictData as! NSDictionary
                    
                    UserDefaults.standard.set(userData["data"], forKey: "userData")
                    
                    self.performSegue(withIdentifier: "toProfile", sender: self)
                    
        
              
                    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
