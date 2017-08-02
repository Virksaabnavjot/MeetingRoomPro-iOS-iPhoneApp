//
//  APIConstant.swift
//  MRPro
//  Purpose: This is a api response handler class
//  Reference: This is implemented with the help of SwiftyJson https://github.com/SwiftyJSON/SwiftyJSON
//

import UIKit
import Foundation
@objc

open class APIResponseHandler: NSObject {
    
    var status: Bool = false
    var responseMessage: AnyObject?
    var responseCode: AnyObject?
    var data: AnyObject?
    var isMatched: Bool = false
    
    func setResponse(_ dictTemp:Dictionary<String,AnyObject?>!){
        responseMessage = dictTemp["responseMessage"] as? String as AnyObject?? ?? "SERVER_ERROR" as AnyObject?
        
    }
}
