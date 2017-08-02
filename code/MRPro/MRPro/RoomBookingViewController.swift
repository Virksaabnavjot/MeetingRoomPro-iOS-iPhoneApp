//
//  RoomBookingViewController.swift
//  MRPro
//  Purpose:
//  Created by Nav on  7/26/17.
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit
import UIImageView_Letters

class RoomBookingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var startTime : Int = 0
    var endTime : Int = 0
    @IBOutlet weak var meetingTitleTxtFld: UITextField!
    
    @IBOutlet weak var tblVu: UITableView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var pickerVu: UIView!
    @IBOutlet weak var pickerDoneBtn: UIButton!
    @IBOutlet weak var pickerCancelBtn: UIButton!
    @IBOutlet weak var datePckr: UIDatePicker!
    @IBOutlet weak var bookThisRoomBtn: UIButton!

    @IBOutlet weak var endTimeButton: UIButton!
    var meetingRoom: MeetingRoom!

    var selectedDateString : String!
    var arrayOfSelectedUsers : Array<String> = []
    var arrayOfUsers = [Dictionary<String, String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.pickerVu.isHidden = true
        datePckr.minimumDate = Date()
        var dictRequest: [String : Any] = [:]
        var userDict =  UserDefaults.standard.object(forKey: "userData") as! NSDictionary
        
        dictRequest["userID"] = userDict["id"]
        
        API.sharedInstance.getUsersList(dictRequest) { (success, dictData) -> Void in
            
            if success == true {
                print(dictData)
                let userData = dictData as! NSDictionary
                
                
                self.arrayOfUsers = userData["data"] as! Array
                DispatchQueue.main.async {

                    self.tblVu.reloadData()
                
                }
                
            }else{
                
                self.displayAlert(dictData["code"] as! String!)
                
                
            }
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfUsers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BookingUsersCell
        cell.nameLbl?.text = arrayOfUsers[indexPath.row]["name"]
        cell.imgVu.setImageWith(arrayOfUsers[indexPath.row]["name"])
        if (arrayOfSelectedUsers.contains(arrayOfUsers[indexPath.row]["id"]!))
        {
            cell.checkImgVu.image = UIImage.init(named: "checkmark")
        }
        else
        {
            cell.checkImgVu.image = UIImage.init(named: "")
        }
        cell.imgVu.layer.cornerRadius = cell.imgVu.frame.size.width/2.0
        cell.imgVu.clipsToBounds = true
        cell.checkImgVu.layer.borderColor = UIColor.lightGray.cgColor
        cell.checkImgVu.layer.borderWidth = 1.0
        cell.checkImgVu.layer.cornerRadius = 2.0
        
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if (arrayOfSelectedUsers.contains(arrayOfUsers[indexPath.row]["id"]!))
        {
            let indexOfId =  arrayOfSelectedUsers.index(of: arrayOfUsers[indexPath.row]["id"]!)
            arrayOfSelectedUsers.remove(at: indexOfId!)
            self.tblVu.reloadData()
            
        }
        else
        {
            arrayOfSelectedUsers.append(arrayOfUsers[indexPath.row]["id"]!)
            self.tblVu.reloadData()

            
        }
    }
    @IBAction func selectTimeBtnTapped(_ sender: Any) {
        let button = sender as! UIButton

        self.pickerVu.isHidden = false
        self.pickerDoneBtn.tag = button.tag   //  assigned Select dates buttons tag so that when click on Done button we can identify that  which button was selected
        
    }

    @IBAction func datePickerDoneBtnTapped(_ sender: Any) {
        
        self.pickerVu.isHidden = true
        let currentDate = self.datePckr.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d yy, h:mm a"
        selectedDateString = dateFormatter.string(from: currentDate)
        let button = sender as! UIButton
        if button.tag == 10 {
            startTime =  Int(self.datePckr.date.timeIntervalSince1970)
            self.startButton.setTitle(selectedDateString, for: .normal)
        }
        else if button.tag == 20 {
            endTime =  Int(self.datePckr.date.timeIntervalSince1970)
            self.endButton.setTitle(selectedDateString, for: .normal)
            // we have set a tag in End Button equals to 20 and
        }
        
    }
    @IBAction func datePickerCancelBtnTapped(_ sender: Any) {
        self.pickerVu.isHidden = true

    }
    @IBAction func bookThisRoomBtnTapped(_ sender: Any) {
        
        //displaying alerts if any of the fields is empty when booking a room
        if (self.meetingTitleTxtFld.text?.isEmpty == true)
        {
            self.displayAlert("Title Missing!")
        }
        else if (selectedDateString.isEmpty == true)
        {
            self.displayAlert("Date Missing!")

        }
        else if (startTime == 0)
        {
            self.displayAlert("Start Time Missing")
            
        }
        else if (endTime == 0)
        {
            self.displayAlert("End Time Missing")
            
        }
        else
        {
            var dictRequest: [String : Any] = [:]
            dictRequest["title"] = self.meetingTitleTxtFld.text
            dictRequest["users"] = self.arrayOfSelectedUsers
            dictRequest["startDate"] = String(self.startTime)
            dictRequest["endDate"] = String(self.endTime)

           
            
            dictRequest["roomID"] = self.meetingRoom.id
            var userDict =  UserDefaults.standard.object(forKey: "userData") as! NSDictionary
            
            dictRequest["userID"] = userDict["id"]
            
            API.sharedInstance.bookRoom(dictRequest) { (success, dictData) -> Void in
                
                if success == true {
                    print(dictData)
                    let userData = dictData as! NSDictionary
                    
                    
                    self.navigationController?.popViewController(animated: true)
                        
                    }
                    
                else{
                    
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
