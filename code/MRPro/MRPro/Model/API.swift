//
//  API.swift
//  MRPro
//  Purpose: This class helps to make api calls
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit
import KVNProgress
import Alamofire

open class API: NSObject {
    
    //Initialization of Singleton SharedInstance of API Class
    let NO_NETWORK: String = "No internet Conection - please check your internet connection and try again later"
    let SERVER_ERROR = "Not able to connect with server, please try again later"
    
    //creating a struct
    struct Singleton {
        static let sharedInstance = API() //shared instance
    }
    
    class var sharedInstance: API {
        return Singleton.sharedInstance
    }
    
    //completion handler -takes a string and returns void
    public typealias completionHandler = ((Bool,Dictionary<String, Any>)->Void)?
    public typealias completionHandlerCardUpload = ((Bool,Dictionary<String, AnyObject>?,CGFloat,Bool)->Void)?
    
    
    //Error and Response Handler
    fileprivate func displayError(_ error:NSError!,needDismiss:Bool = false){
        
        if error != nil {
            if error.code == -1009 || error.code == -1001{
            }else{
            }
        }
    }
    
    //handling errors
    fileprivate func handleError(_ obj:APIResponseHandler, errorAlert:Bool = true){
        
        if obj.status == false {
            if errorAlert {
                let dictError = obj.responseMessage as? String
            }
        }
    }
    
    //response handler
    fileprivate func getResponseHandler(_ dictTemp:Dictionary<String,AnyObject?>!)->APIResponseHandler{
        
        let obj:APIResponseHandler = APIResponseHandler()
        obj.setResponse(dictTemp)
        return obj
        
    }
    
    //login
    func login(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        //showing progress bar using kvnprogress framework
        KVNProgress.show()
        
        //making request to api
        APIRequestMethods.apiPostCallWithOutEncoding(API_Login, params: dicRequest) {(jsonData, error, statusCode) -> Void in
            if error != nil {
                //dismiss progress bar and show the error if error exists
                KVNProgress.dismiss(completion: {
                    self.displayError(error, needDismiss: false)
                })
            }else{
                //if the status code is success get json data
                let code = jsonData?["status"] as? String
                if (code == "success") {
                    KVNProgress.dismiss(completion: {
                        block!(true,jsonData!)
                    })
                }else{
                    KVNProgress.dismiss(completion: {
                        block!(false,jsonData!)
                    })
                }
            }
        }
    }
    
    
    //Register User
    func register(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        //showing progress bar using kvnprogress framework
        KVNProgress.show()
        
        //making api request
        APIRequestMethods.apiPostCallWithOutEncoding(API_Register, params: dicRequest) {(jsonData, error, statusCode) -> Void in
            if error != nil {
                KVNProgress.dismiss(completion: {
                    self.displayError(error, needDismiss: false)
                })
            }else{
                //if the status code is success get json data
                let code = jsonData?["status"] as? String
                if (code == "success") {
                    KVNProgress.dismiss(completion: {
                        block!(true,jsonData!)
                    })
                }else{
                    KVNProgress.dismiss(completion: {
                        block!(false,jsonData!)
                    })
                }
            }
        }
        
        
    }
    
    
    //getting the available buildings list
    func getBuildingList(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()
        
        //making api request
        APIRequestMethods.apiPostCallWithOutEncoding(API_BuildingList, params: dicRequest) {(jsonData, error, statusCode) -> Void in
            if error != nil {
                KVNProgress.dismiss(completion: {
                    self.displayError(error, needDismiss: false)
                })
            }else{
                //if the status code is success get json data
                let code = jsonData?["status"] as? String
                if (code == "success") {
                    KVNProgress.dismiss(completion: {
                        block!(true,jsonData!)
                    })
                }else{
                    KVNProgress.dismiss(completion: {
                        block!(false,jsonData!)
                    })
                }
            }
        }
    }
    
    //getting the meeting rooms list
    func getRoomList(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()
        
        APIRequestMethods.apiPostCallWithOutEncoding(API_RoomsList, params: dicRequest) {(jsonData, error, statusCode) -> Void in
            if error != nil {
                KVNProgress.dismiss(completion: {
                    self.displayError(error, needDismiss: false)
                })
            }else{
                //if the status code is success get json data
                let code = jsonData?["status"] as? String
                if (code == "success") {
                    KVNProgress.dismiss(completion: {
                        block!(true,jsonData!)
                    })
                }else{
                    KVNProgress.dismiss(completion: {
                        block!(false,jsonData!)
                    })
                }
            }
        }
        
        
    }
    
    //allowing search for buildings
    func searchBuildingList(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        APIRequestMethods.apiPostCallWithOutEncoding(API_BuildingSearch, params: dicRequest) {(jsonData, error, statusCode) -> Void in
            if error != nil {
            }else{
                //if the status code is success get json data
                let code = jsonData?["status"] as? String
                if (code == "success") {
                    block!(true,jsonData!)
                }else{
                    block!(false,jsonData!)
                }
            }
        }
    }
    
    //getting a list of all users
    func getUsersList(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()
        
        //making request
        APIRequestMethods.apiPostCallWithOutEncoding(API_GetAllUsers, params: dicRequest) {(jsonData, error, statusCode) -> Void in
            if error != nil {
                KVNProgress.dismiss(completion: {
                    self.displayError(error, needDismiss: false)
                })
            }else{
                
                //if the status code is success get json data
                let code = jsonData?["status"] as? String
                if (code == "success") {
                    KVNProgress.dismiss(completion: {
                        block!(true,jsonData!)
                    })
                }else{
                    KVNProgress.dismiss(completion: {
                        block!(false,jsonData!)
                    })
                }
            }
        }
    }
    
    //handles room booking
    func bookRoom(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()
        
        //making request
        APIRequestMethods.apiPostCallWithOutEncoding(API_BookRoom, params: dicRequest) {(jsonData, error, statusCode) -> Void in
            if error != nil {
                KVNProgress.dismiss(completion: {
                    self.displayError(error, needDismiss: false)
                })
            }else{
                //if the status code is success get json data
                let code = jsonData?["status"] as? String
                if (code == "success") {
                    KVNProgress.dismiss(completion: {
                        block!(true,jsonData!)
                    })
                }else{
                    KVNProgress.dismiss(completion: {
                        block!(false,jsonData!)
                    })
                }
            }
        }
    }
    
    //getting room images (gallery)
    func getRoomImages(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()
        
        //request
        APIRequestMethods.apiPostCallWithOutEncoding(API_GetPhotos, params: dicRequest) {(jsonData, error, statusCode) -> Void in
            if error != nil {
                KVNProgress.dismiss(completion: {
                    self.displayError(error, needDismiss: false)
                })
            }else{
                //getting the data
                let code = jsonData?["status"] as? String
                if (code == "success") {
                    KVNProgress.dismiss(completion: {
                        block!(true,jsonData!)
                    })
                }else{
                    KVNProgress.dismiss(completion: {
                        block!(false,jsonData!)
                    })
                }
            }
        }
    }
    
    func postReview(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()
        
        APIRequestMethods.apiPostCallWithOutEncoding(API_PostReview, params: dicRequest) {(jsonData, error, statusCode) -> Void in
            if error != nil {
                KVNProgress.dismiss(completion: {
                    self.displayError(error, needDismiss: false)
                })
            }else{
                
                let code = jsonData?["status"] as? String
                if (code == "success") {
                    KVNProgress.dismiss(completion: {
                        block!(true,jsonData!)
                    })
                }else{
                    KVNProgress.dismiss(completion: {
                        block!(false,jsonData!)
                    })
                }
            }
        }
    }
    
    //getting the my meetings data (the room bookings)
    func getAllMyMeetings(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()
        //make request
        APIRequestMethods.apiPostCallWithOutEncoding(API_MyMeetingRooms, params: dicRequest) {(jsonData, error, statusCode) -> Void in
            if error != nil {
                KVNProgress.dismiss(completion: {
                    self.displayError(error, needDismiss: false)
                })
            }else{
                
                let code = jsonData?["status"] as? String
                if (code == "success") {
                    KVNProgress.dismiss(completion: {
                        block!(true,jsonData!)
                    })
                }else{
                    KVNProgress.dismiss(completion: {
                        block!(false,jsonData!)
                    })
                }
            }
        }
    }
    
    //uploading images to server
    func uploadImage(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()
        //making request
        APIRequestMethods.apiUploadMultipartCall(API_UploadImage, params: dicRequest) { (data, error, statusCode, success) -> Void in
            
            if success == true {
                //if the status code == sucess proceed
                let code = data?["status"] as? String
                if (code == "success") {
                    
                    KVNProgress.dismiss(completion: {
                        block?(true, data! as Dictionary<String, Any>)
                    })
                }else{
                    KVNProgress.dismiss(completion: {
                        if (data != nil) {
                            block!(false,data!)
                        }else{
                            
                        }
                    })
                }
            }else{
                //else dismiss progess bar
                KVNProgress.dismiss(completion: {
                    
                })
            }
        }
    }
    
    //get the reiews of the roomss
    func getRoomReviews(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()
        //make request
        APIRequestMethods.apiPostCallWithOutEncoding(API_RoomRatings, params: dicRequest) {(jsonData, error, statusCode) -> Void in
            if error != nil {
                KVNProgress.dismiss(completion: {
                    self.displayError(error, needDismiss: false)
                })
            }else{
                
                let code = jsonData?["status"] as? String
                if (code == "success") {
                    KVNProgress.dismiss(completion: {
                        block!(true,jsonData!)
                    })
                }else{
                    KVNProgress.dismiss(completion: {
                        block!(false,jsonData!)
                    })
                }
            }
        }
    }
}
