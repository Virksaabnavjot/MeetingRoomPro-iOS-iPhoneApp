//
//  MyMeetingsViewController.swift
//  MRPro
//
//  Created by Nav 
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit

class MyMeetingsViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    @IBOutlet weak var tblVu: UITableView!
    var arrayOfRooms = [Dictionary<String, Any>]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dictRequest: [String : Any] = [:]
        var userDict =  UserDefaults.standard.object(forKey: "userData") as! NSDictionary
        
        dictRequest["userID"] = userDict["id"]
        
        API.sharedInstance.getAllMyMeetings(dictRequest) { (success, dictData) -> Void in
            
            if success == true {
                print(dictData)
                let userData = dictData as! NSDictionary
                
                
                self.arrayOfRooms = userData["data"] as! Array
                DispatchQueue.main.async {
                    
                    self.tblVu.reloadData()
                    
                }
                
            }else{
                
                self.displayAlert(dictData["code"] as! String!)
                
                
            }
        }

    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOfRooms.count
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as? MeetingRoomsCell else {
            return MeetingRoomsCell()
        }
        
       
        let meetingRoom = arrayOfRooms[0] 
        
        let roomName = meetingRoom["roomName"] as! String
        let floorNumber = meetingRoom["floorNumber"]
        let buildingNameStr = meetingRoom["buildingName"] as! String
        
        print("Room Name: ", roomName)
        
        cell.nameLabel?.textColor = UIColor.black
        cell.buildingName?.textColor = UIColor.flatRed()
        
        cell.nameLabel.text = roomName
        cell.floorNumberLabel.text = "Floor: " + (floorNumber as! String)
        cell.buildingName.text = "Building: " + buildingNameStr
        
        cell.buildingName.adjustsFontSizeToFitWidth = true
        cell.nameLabel.adjustsFontSizeToFitWidth = true
        
        cell.endDate.adjustsFontSizeToFitWidth = true
        cell.startDate.adjustsFontSizeToFitWidth = true
        
        cell.startDate.text = returnDateString(inputDate: meetingRoom["startDate"] as! String)
        
        cell.endDate.text = returnDateString(inputDate: meetingRoom["endDate"] as! String)

        
        
        cell.cellVu.layer.cornerRadius = 5.0
        
        return cell
    }
    
    func returnDateString(inputDate : String)-> String{
        let dateFormatter = DateFormatter()
        let date = NSDate(timeIntervalSince1970: TimeInterval((inputDate as NSString).integerValue))
        if date == nil {
            return ""
        }
        dateFormatter.dateFormat = "MMM d yy, h:mm a"
        
        return dateFormatter.string(from: date as Date)
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
