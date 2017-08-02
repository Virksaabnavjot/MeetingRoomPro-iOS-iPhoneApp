//
//  APIRequestMethods.swift
//  MRPro
//  Purpose: This file contains api request methods
//  Reference: This is implemented with the help of SwiftyJson https://github.com/SwiftyJSON/SwiftyJSON
//

import Foundation
import UIKit

import Alamofire
import SwiftyJSON

//creating an extension to DataRequest - extensions in swift as name suggests allows to add additional functionality
extension DataRequest {
    public func debugLog() -> Self {
        #if DEBUG
            debugPrint("API Name :::::::::::::::::: %@",self.request!.url ?? "No URL",terminator: "\n\n")
            debugPrint(self)
            debugPrint(terminator:"\n\n")
        #endif
        return self
    }
}


extension DataRequest {
    
    /**
     Adds a handler to be called once the request has finished.
     
     :param: completionHandler A closure to be executed once the request has finished. The closure takes 4 arguments: the URL request, the URL response, if one was received, the SwiftyJSON enum, if one could be created from the URL response and data, and any error produced while creating the SwiftyJSON enum.
     
     :returns: The request.
     */
    @discardableResult
    public func responseSwiftyJSON(_ completionHandler: @escaping (URLRequest, HTTPURLResponse?, SwiftyJSON.JSON, NSError?) -> Void) -> Self {
        return responseSwiftyJSON(queue: nil, options:JSONSerialization.ReadingOptions.allowFragments, completionHandler:completionHandler)
    }
    
    
    /**
     Adds a handler to be called once the request has finished.
     
     :param: queue The queue on which the completion handler is dispatched.
     :param: options The JSON serialization reading options. `.AllowFragments` by default.
     :param: completionHandler A closure to be executed once the request has finished. The closure takes 4 arguments: the URL request, the URL response, if one was received, the SwiftyJSON enum, if one could be created from the URL response and data, and any error produced while creating the SwiftyJSON enum.
     
     :returns: The request.
     */
    
    @discardableResult
    public func responseSwiftyJSON(queue: DispatchQueue? = nil, options: JSONSerialization.ReadingOptions = .allowFragments, completionHandler:@escaping (URLRequest, HTTPURLResponse?, SwiftyJSON.JSON, NSError?) -> Void)
        -> Self {
            
            return response(queue: queue, responseSerializer: DataRequest.jsonResponseSerializer(options: options), completionHandler: { (dataResponse) in
                
                
                DispatchQueue.global(qos: .default).async(execute: {
                    
                    print(dataResponse.result.value ?? "No Result comes")
                    
                    var responseJSON: JSON
                    if dataResponse.result.isFailure
                    {
                        responseJSON = JSON.null
                    } else {
                        responseJSON = SwiftyJSON.JSON(dataResponse.result.value!)
                    }
                    (queue ?? DispatchQueue.main).async(execute: {
                        completionHandler(dataResponse.request!, dataResponse.response, responseJSON, dataResponse.result.error as NSError?)
                    })
                })
            })
    }
    
}



class APIRequestMethods: SessionManager {
    
    //MARK: POST API
    
    class func apiPostCall(_ apiName:String,params:Dictionary<String,Any>? = nil,block mainBlock:((Dictionary<String,Any>?,NSError?,Int)->Void?)?){
        
        let strUrl: String = API_URL + apiName
        
        self.default.request(strUrl, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding(options: []), headers: nil).debugLog().responseSwiftyJSON({ (requestD, responseD, jsonData, error) in
            
            if error == nil {
                
                debugPrint(jsonData)
                debugPrint(requestD)
                debugPrint(responseD ?? "No http response POST")
                print(responseD?.statusCode ?? "NO Status Code")
                
                mainBlock?(jsonData.dictionaryObject as Dictionary<String, Any>?,error,(responseD?.statusCode)!)
                
            }else{
                mainBlock?(nil,error,(responseD?.statusCode ?? 0)!)
            }
        })
    }
    
    //MARK: POST Without API
    class func apiPostCallWithOutEncoding(_ apiName:String,params:Dictionary<String,Any>? = nil,block mainBlock:((Dictionary<String,Any>?,NSError?,Int)->Void?)?){
        
        let strUrl: String = API_URL + apiName
        
        self.default.request(strUrl, method: HTTPMethod.post, parameters: params, headers: nil).debugLog().responseSwiftyJSON({ (requestD, responseD, jsonData, error) in
            
            if error == nil {
                
                debugPrint(jsonData)
                debugPrint(requestD)
                debugPrint(responseD ?? "No http response")
                print(responseD?.statusCode ?? "NO Status Code")
                
                mainBlock?(jsonData.dictionaryObject as Dictionary<String, Any>?,error,(responseD?.statusCode)!)
                
            }else{
                mainBlock?(nil,error,(responseD?.statusCode ?? 0)!)
            }
        })
    }
    
    
    //MARK: GET API
    class func apiGetCall(_ apiName:String,params:Dictionary<String,Any>? = nil,block mainBlock:((Dictionary<String,Any>?,NSError?,Int)->Void?)?){
        
        let strUrl: String = API_URL + apiName
        
        self.default.request(strUrl, method: HTTPMethod.get, parameters: params, encoding: JSONEncoding(options: []), headers: nil).debugLog().responseSwiftyJSON({ (requestD, responseD, jsonData, error) in
            
            if error == nil {
                
                debugPrint(jsonData)
                debugPrint(requestD)
                debugPrint(responseD ?? "No http response GET")
                print(responseD?.statusCode ?? "NO Status Code")
                
                mainBlock?(jsonData.dictionaryObject as Dictionary<String, Any>?,error,(responseD?.statusCode)!)
                
            }else{
                mainBlock?(nil,error,(responseD?.statusCode ?? 0)!)
            }
        })
    }
    
    //MARK: GET Without Encoding API
    class func apiGetCallWithOutEncoding(_ apiName:String,params:Dictionary<String,Any>? = nil,block mainBlock:((Dictionary<String,Any>?,NSError?,Int)->Void?)?){
        
        let strUrl: String = API_URL + apiName
        
        self.default.request(strUrl, method: HTTPMethod.get, parameters: params, headers: nil).debugLog().responseSwiftyJSON({ (requestD, responseD, jsonData, error) in
            
            if error == nil {
                
                debugPrint(jsonData)
                debugPrint(requestD)
                debugPrint(responseD ?? "No http response")
                print(responseD?.statusCode ?? "NO Status Code")
                
                mainBlock?(jsonData.dictionaryObject as Dictionary<String, Any>?,error,(responseD?.statusCode)!)
                
            }else{
                mainBlock?(nil,error,(responseD?.statusCode ?? 0)!)
            }
        })
    }
    
    //MARK: GET With Multipart API
    class func apiUploadMultipartCall(_ apiName:String,params:Dictionary<String,Any>? = nil,block mainBlock:((Dictionary<String,Any>?,NSError?,Int,Bool)->Void?)?){
        
        let filename: String = "imageUser.jpg"
        
        
        let apiUrl: String = API_URL + apiName
        
        self.default.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in params! {
                if (key != "picture")  {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
            
            // Contact Update
            if (params?.index(forKey: "picture") != nil) {
                if params!["picture"] is Data {
                    multipartFormData.append(params!["picture"] as! Data, withName: "picture", fileName: filename, mimeType: "image/jpg")
                }
            }
            
            
        }, to: apiUrl) { (result) in
            
            switch result {
            case .success(let upload, _, _) :
                
                upload.uploadProgress(closure: { (progress) in
                    
                }).responseSwiftyJSON({ (requestD, responseD, jsonData, error) in
                    if error != nil{
                        mainBlock?(nil,error as NSError?, 400,false)
                    }else{
                        mainBlock?(jsonData.dictionaryObject as Dictionary<String, Any>?,error,(responseD?.statusCode)!,true)
                    }
                })
                break
            case .failure(let encodingError):
                mainBlock?(nil,encodingError as NSError?, 400,false)
                break
            }
        }
    }
    
    
    
    class func apiUploadMultipartCallWithHeaders(_ apiName:String,headers:HTTPHeaders,params:Dictionary<String,Any>? = nil,block mainBlock:((Dictionary<String,Any>?,NSError?,Int,Bool)->Void?)?){
        
        let filename: String = "imageUser.jpg"
        
        
        let apiUrl: String = API_URL + apiName
        
        self.default.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in params! {
                if (key != "picture")  {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
            
            if (params?.index(forKey: "picture") != nil) {
                if params!["picture"] is Data {
                    multipartFormData.append(params!["picture"] as! Data, withName: "picture[0]", fileName: filename, mimeType: "image/jpg")
                }
            }
            
            
        }, usingThreshold: 100000, to: apiUrl, method: HTTPMethod.post, headers: headers) { (result) in
            
            switch result {
            case .success(let upload, _, _) :
                
                upload.uploadProgress(closure: { (progress) in
                }).responseSwiftyJSON({ (requestD, responseD, jsonData, error) in
                    if error != nil{
                        mainBlock?(nil,error as NSError?, 400,false)
                    }else{
                        mainBlock?(jsonData.dictionaryObject as Dictionary<String, Any>?,error,(responseD?.statusCode)!,true)
                    }
                })
                break
            case .failure(let encodingError):
                mainBlock?(nil,encodingError as NSError?, 400,false)
                break
            }
        }
        
    }
    
    
}
