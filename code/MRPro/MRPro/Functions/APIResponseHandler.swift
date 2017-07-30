//
//  APIConstant.swift
//  MRPro
//  Purpose: This is a api response handler class
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
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
        
//        _ = BasicFunctions.Dict_to_object(dictTemp, obj: self)
        responseMessage = dictTemp["responseMessage"] as? String as AnyObject?? ?? "SERVER_ERROR" as AnyObject?
        
    }
}
