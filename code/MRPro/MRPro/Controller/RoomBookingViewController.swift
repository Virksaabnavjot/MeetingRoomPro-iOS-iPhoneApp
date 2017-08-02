//
//  RoomBookingViewController.swift
//  MRPro
//  Purpose: Handle room booking
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit
import UIImageView_Letters

/*
 Allows the user to book a meeting room
 */
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
    
    //creating variables
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
        
        //make api request - to get list of users (we show this list to the user, if
        //the user wants to invite someone from this list to the meeting
        API.sharedInstance.getUsersList(dictRequest) { (success, dictData) -> Void in
            
            if success == true {
                print(dictData)
                let userData = dictData as! NSDictionary
                
                //array of users
                self.arrayOfUsers = userData["data"] as! Array
                DispatchQueue.main.async {
                    
                    //reload table view with new data
                    self.tblVu.reloadData()
                    
                }
                
            }else{
                //else show error message
                self.displayAlert(dictData["code"] as! String!)
                
                
            }
        }
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //retun number of users
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BookingUsersCell
        
        //set information to cell label
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
        
        //styling
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
    
    //allows to select time
    @IBAction func selectTimeBtnTapped(_ sender: Any) {
        let button = sender as! UIButton
        
        self.pickerVu.isHidden = false
        //  assigned Select dates buttons tag so that when click on Done button we can identify thatwhich button was selected
        self.pickerDoneBtn.tag = button.tag
        
    }
    
    //allows to pick a date for the meeting
    @IBAction func datePickerDoneBtnTapped(_ sender: Any) {
        
        self.pickerVu.isHidden = true
        let currentDate = self.datePckr.date
    
        //format date
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
            // we have set a tag in End Button equals to 20
        }
        
    }
    
    //helps cancel date picker
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
            //getting user data
            var dictRequest: [String : Any] = [:]
            dictRequest["title"] = self.meetingTitleTxtFld.text
            dictRequest["users"] = self.arrayOfSelectedUsers
            dictRequest["startDate"] = String(self.startTime)
            dictRequest["endDate"] = String(self.endTime)
            
            dictRequest["roomID"] = self.meetingRoom.id
            var userDict =  UserDefaults.standard.object(forKey: "userData") as! NSDictionary
            
            dictRequest["userID"] = userDict["id"]
            
            //make api request to book the room
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
    
    //helps display an alert
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
    
}
