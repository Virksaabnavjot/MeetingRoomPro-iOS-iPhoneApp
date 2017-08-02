//
//  MyMeetingsViewController.swift
//  MRPro
//  Purpose: Handles My Meetings aka (the list of room booking for My meetings)
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit

/*
 My Meetings Controller
 */
class MyMeetingsViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tblVu: UITableView!
    
    //rooms array
    var arrayOfRooms = [Dictionary<String, Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dictRequest: [String : Any] = [:]
        
        //getting user information saved when login and using it to request data for this user
        var userDict =  UserDefaults.standard.object(forKey: "userData") as! NSDictionary
        dictRequest["userID"] = userDict["id"]
        
        //make request to get my meetings
        API.sharedInstance.getAllMyMeetings(dictRequest) { (success, dictData) -> Void in
            
            //if request is sucessful
            if success == true {
                print(dictData)
                let userData = dictData as! NSDictionary
                
                // array of rooms
                self.arrayOfRooms = userData["data"] as! Array
                DispatchQueue.main.async {
                    
                    //show data in table view
                    self.tblVu.reloadData()
                    
                }
                
            }else{
                //else show an alert with error message
                self.displayAlert(dictData["code"] as! String!)
                
            }
        }
    }
    
    //table view - counting number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //counting the rooms arrays size and using it for table view rows size
        return arrayOfRooms.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //calling the MeeingRoomsCell - which is a custom cell for table view
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as? MeetingRoomsCell else {
            return MeetingRoomsCell()
        }
        
        //getting room information/details
        let meetingRoom = arrayOfRooms[0]
        let roomName = meetingRoom["roomName"] as! String
        let floorNumber = meetingRoom["floorNumber"]
        let buildingNameStr = meetingRoom["buildingName"] as! String
        
        //print
        print("Room Name: ", roomName)
        
        //set the information to cells labels
        cell.nameLabel?.textColor = UIColor.black
        cell.buildingName?.textColor = UIColor.flatRed()
        cell.nameLabel.text = roomName
        cell.floorNumberLabel.text = "Floor: " + (floorNumber as! String)
        cell.buildingName.text = "Building: " + buildingNameStr
        
        //constrants
        cell.buildingName.adjustsFontSizeToFitWidth = true
        cell.nameLabel.adjustsFontSizeToFitWidth = true
        cell.endDate.adjustsFontSizeToFitWidth = true
        cell.startDate.adjustsFontSizeToFitWidth = true
        
        //calling returnDateString method
        cell.startDate.text = returnDateString(inputDate: meetingRoom["startDate"] as! String)
        cell.endDate.text = returnDateString(inputDate: meetingRoom["endDate"] as! String)
        
        //styling
        cell.cellVu.layer.cornerRadius = 5.0
        
        return cell
    }
    
    //method return date string -  to return a date string
    func returnDateString(inputDate : String)-> String{
        
        //date formatter
        let dateFormatter = DateFormatter()
        let date = NSDate(timeIntervalSince1970: TimeInterval((inputDate as NSString).integerValue))
        if date == nil {
            return ""
        }
        //setting the date format
        dateFormatter.dateFormat = "MMM d yy, h:mm a"
        
        //return the results
        return dateFormatter.string(from: date as Date)
        
    }
    
    //display alert method
    func displayAlert(_ msg:String!,needDismiss:Bool = false,title:String = "MRPro")  {
        
        //create ui alert controller
        let alertController = UIAlertController(title:title, message:msg, preferredStyle: .alert)
        //assign actions
        let defaultAction = UIAlertAction(title:"ok", style: .cancel) { (action) in
            if needDismiss {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        //add actions to alert controller
        alertController.addAction(defaultAction)
        
        //present the alert
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


