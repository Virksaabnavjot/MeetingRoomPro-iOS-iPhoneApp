//
//  RateViewController.swift
//  MRPro
//
//  Created by Nav on  7/28/17.
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit
import RateView

class RateViewController: UIViewController , UITableViewDelegate, UITableViewDataSource , UITextViewDelegate {

    @IBOutlet weak var inputViewHeight: NSLayoutConstraint!
    @IBOutlet weak var reviews: UITableView!
    @IBOutlet weak var rateVu: RateView!
    @IBOutlet weak var commentTxtVu: UITextView!
    @IBOutlet weak var submitBtn: UIButton!
    
    var meetingRoom: MeetingRoom!
    
    var userReviews = [Dictionary<String, Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reviews"
        self.rateVu.starFillColor = UIColor.orange
        self.rateVu.starNormalColor = UIColor.lightGray
        self.rateVu.canRate = true
        self.rateVu.starSize = 60
        
        self.commentTxtVu.layer.borderWidth = 1.0
        self.commentTxtVu.layer.borderColor = UIColor.gray.cgColor
        
        
        
        reviews.estimatedRowHeight = 70
        reviews.rowHeight = UITableViewAutomaticDimension

        getRatingsOfThisRoom()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitBtnTapped(_ sender: Any) {
        if (self.commentTxtVu.text.isEmpty)
        {
            self.displayAlert("Please Fill the comment Section")
        }
        else
        {
            var dictRequest: [String : Any] = [:]
            
            var userDict =  UserDefaults.standard.object(forKey: "userData") as! NSDictionary

            dictRequest["review"] = self.commentTxtVu.text
            dictRequest["rating"] = self.rateVu.rating
            dictRequest["userName"] = userDict["name"]
            dictRequest["roomID"] = self.meetingRoom.id
            dictRequest["userID"] = userDict["id"]
            
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
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
        
        cell.rateView.starFillColor = UIColor.orange
        cell.rateView.starNormalColor = UIColor.lightGray
        cell.rateView.canRate = false
        cell.rateView.starSize = 20
        
        
        cell.rateView.rating = Float(ratingObj["rating"]!)!
        cell.nameLbl.text = ratingObj["userName"];
        cell.commentLbl.text = ratingObj["review"];
        return cell
    }
    
    func textViewDidChange(_ textView: UITextView){
        reviews.beginUpdates()
        reviews.endUpdates()
    }
    
    
    //MARK: GetALL RATINGS
    func getRatingsOfThisRoom () {
    var dictRequest: [String : Any] = [:]
    
    dictRequest["roomID"] = self.meetingRoom.id
    
    API.sharedInstance.getRoomReviews(dictRequest) { (success, dictData) -> Void in
    
    if success == true {
    print(dictData)
    let userData = dictData as! NSDictionary
    
    
    self.userReviews = userData["data"] as! Array
    DispatchQueue.main.async {
    
    self.reviews.reloadData()
    
    }
    
    }else{
    
    self.displayAlert(dictData["code"] as! String!)
    
    
    }
}
    }
    



}
