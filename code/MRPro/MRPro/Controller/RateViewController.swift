//
//  RateViewController.swift
//  MRPro
//  Purpose: Handles User Rating and Reviews
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit
import RateView

/*
 Allow the user to see previous room reviews and allows to post a review and rate the room
 */
class RateViewController: UIViewController , UITableViewDelegate, UITableViewDataSource , UITextViewDelegate {
    
    @IBOutlet weak var inputViewHeight: NSLayoutConstraint!
    @IBOutlet weak var reviews: UITableView!
    @IBOutlet weak var rateVu: RateView!
    @IBOutlet weak var commentTxtVu: UITextView!
    @IBOutlet weak var submitBtn: UIButton!
    
    //meeitng room object
    var meetingRoom: MeetingRoom!
    
    //user reviews dictionary
    var userReviews = [Dictionary<String, Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set title
        self.title = "Reviews"
        
        //styling
        self.rateVu.starFillColor = UIColor.orange
        self.rateVu.starNormalColor = UIColor.lightGray
        self.rateVu.canRate = true
        self.rateVu.starSize = 60
        self.commentTxtVu.layer.borderWidth = 1.0
        self.commentTxtVu.layer.borderColor = UIColor.gray.cgColor
        
        reviews.estimatedRowHeight = 70
        reviews.rowHeight = UITableViewAutomaticDimension
        
        //get all room ratings/reviews
        getRatingsOfThisRoom()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    //this button allows the user to subit his/her review
    @IBAction func submitBtnTapped(_ sender: Any) {
        
        //basic check if comment box empty show alert
        if (self.commentTxtVu.text.isEmpty)
        {
            self.displayAlert("Please Fill the comment Section")
        }
        else
        {
            var dictRequest: [String : Any] = [:]
            
            //get usre data saved in user defaults - when the user logged in
            var userDict =  UserDefaults.standard.object(forKey: "userData") as! NSDictionary
            
            //get review information from user inputs
            dictRequest["review"] = self.commentTxtVu.text
            dictRequest["rating"] = self.rateVu.rating
            dictRequest["userName"] = userDict["name"]
            dictRequest["roomID"] = self.meetingRoom.id
            dictRequest["userID"] = userDict["id"]
            
            //make api request to post the review
            API.sharedInstance.postReview(dictRequest) { (success, dictData) -> Void in
                
                if success == true {
                    print(dictData)
                    
                    self.displayAlert("Review Successfully Posted")
                    let userData = dictData as! NSDictionary
                    
                    self.userReviews = userData["data"] as! Array
                    DispatchQueue.main.async {
                        self.inputViewHeight.constant = 0
                        self.reviews.reloadData()
                        
                    }
                    
                }
                    
                else{
                    
                    self.displayAlert(dictData["code"] as! String!)
                    
                }
            }
            
        }
    }
    
    //helps display alert
    func displayAlert(_ msg:String!,needDismiss:Bool = false,title:String = "MRPro")  {
        
        //create ui alert controller
        let alertController = UIAlertController(title:title, message:msg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title:"ok", style: .cancel) { (action) in
            if needDismiss {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        alertController.addAction(defaultAction)
        
        //present alert
        self.present(alertController, animated: true, completion: nil)
    }
    
    //return count of number of reviews
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return userReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let ratingObj = userReviews[indexPath.row] as! [String : String]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
        cell.commentLbl.delegate = self
        cell.nameLbl.adjustsFontSizeToFitWidth = true
        
        //styling
        cell.rateView.starFillColor = UIColor.orange
        cell.rateView.starNormalColor = UIColor.lightGray
        cell.rateView.canRate = false
        cell.rateView.starSize = 20
        
        //set information
        cell.rateView.rating = Float(ratingObj["rating"]!)!
        cell.nameLbl.text = ratingObj["userName"];
        cell.commentLbl.text = ratingObj["review"];
        return cell
    }
    
    func textViewDidChange(_ textView: UITextView){
        reviews.beginUpdates()
        reviews.endUpdates()
    }
    
    
    //get all review/ratings for the room
    func getRatingsOfThisRoom () {
        var dictRequest: [String : Any] = [:]
        
        dictRequest["roomID"] = self.meetingRoom.id
        
        //make api request
        API.sharedInstance.getRoomReviews(dictRequest) { (success, dictData) -> Void in
            
            //if the status code is sucess proceed
            if success == true {
                print(dictData)
                let userData = dictData as! NSDictionary
                
                
                self.userReviews = userData["data"] as! Array
                DispatchQueue.main.async {
                    
                    self.reviews.reloadData()
                    
                }
                
            }else{
                //else display error message
                self.displayAlert(dictData["code"] as! String!)
                
            }
        }
    }

}
