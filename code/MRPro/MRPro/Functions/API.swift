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
    
    struct Singleton {
        static let sharedInstance = API()
    }
    
    class var sharedInstance: API {
        return Singleton.sharedInstance
    }
    
    
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
    
    
    fileprivate func handleError(_ obj:APIResponseHandler, errorAlert:Bool = true){
        
        if obj.status == false {
            if errorAlert {
                let dictError = obj.responseMessage as? String
            }
        }
    }
    
    fileprivate func getResponseHandler(_ dictTemp:Dictionary<String,AnyObject?>!)->APIResponseHandler{
        
        let obj:APIResponseHandler = APIResponseHandler()
        obj.setResponse(dictTemp)
        return obj
        
    }
    
    //LOGIN
    func login(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()
        
        APIRequestMethods.apiPostCallWithOutEncoding(API_Login, params: dicRequest) {(jsonData, error, statusCode) -> Void in
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
    
    
    //Register User
    func register(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()
        
        
        APIRequestMethods.apiPostCallWithOutEncoding(API_Register, params: dicRequest) {(jsonData, error, statusCode) -> Void in
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
    
    
    func getBuildingList(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()
        
        
        APIRequestMethods.apiPostCallWithOutEncoding(API_BuildingList, params: dicRequest) {(jsonData, error, statusCode) -> Void in
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
    
    func getRoomList(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()

        APIRequestMethods.apiPostCallWithOutEncoding(API_RoomsList, params: dicRequest) {(jsonData, error, statusCode) -> Void in
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
    
    func searchBuildingList(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        APIRequestMethods.apiPostCallWithOutEncoding(API_BuildingSearch, params: dicRequest) {(jsonData, error, statusCode) -> Void in
            if error != nil {
            }else{
                
                let code = jsonData?["status"] as? String
                if (code == "success") {
                        block!(true,jsonData!)
                }else{
                        block!(false,jsonData!)
                }
            }
        }
    }
    
    
    func getUsersList(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()
        
        APIRequestMethods.apiPostCallWithOutEncoding(API_GetAllUsers, params: dicRequest) {(jsonData, error, statusCode) -> Void in
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
    
    func bookRoom(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()
        
        APIRequestMethods.apiPostCallWithOutEncoding(API_BookRoom, params: dicRequest) {(jsonData, error, statusCode) -> Void in
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
    
    func getRoomImages(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()
        
        APIRequestMethods.apiPostCallWithOutEncoding(API_GetPhotos, params: dicRequest) {(jsonData, error, statusCode) -> Void in
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
    
    func getAllMyMeetings(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()
        
        
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
    
    
    func uploadImage(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()
        APIRequestMethods.apiUploadMultipartCall(API_UploadImage, params: dicRequest) { (data, error, statusCode, success) -> Void in
            
            if success == true {
                
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
                KVNProgress.dismiss(completion: {

                })
            }
        }
    }


    func getRoomReviews(_ dicRequest:Dictionary<String,Any>?,block:completionHandler){
        
        KVNProgress.show()
        
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
