//
//  APIConstant.swift
//  MRPro
//  Purpose: This file stores all the constant at one placed to be used throughout the app
//  References: This class have been implemented using the idea from internet to store all constant at one place
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import Foundation
import UIKit


//Webservice URL - I am using 000webhost.com fro hosting the web service its a free hosting service
let API_URL = "https://mrpro.000webhostapp.com/MRProApp/MRPro/MRPro/index.php/"

//api request end-points
let API_DeviceRegistration = "registerDevice.php"
let API_Register = "user/postUser"
let API_Login = "user/signIn"
let API_BuildingList = "buildings/allBuildings"
let API_RoomsList = "rooms/allRooms"
let API_BuildingSearch = "buildings/buildings_search"
let API_GetAllUsers = "user/getUsers"
let API_BookRoom = "rooms/bookRoom"
let API_GetPhotos = "rooms/getRoomsImage"
let API_UploadImage = "rooms/room_image"
let API_PostReview = "rooms/postReview"
let API_MyMeetingRooms = "rooms/getAllBookings"
let API_RoomRatings = "rooms/getRoomReviews"

//marking: other useful constants
let PRE_IS_LOGIN = "isLogin"
let PRE_IS_FIRST = "isFirstTime"

let PRE_USER_INFO = "userInfo"
let PRE_DeviceToken = "DeviceToken"
let PRE_IS_SOCIAL = "isFromSocial"

let USER_LATITUDE = "latitude"
let USER_LONGITUDE = "longitude"
let USER_LOCATION_UPDATED_ON = "updatedTime"

typealias dismissViewClosure = (_ success:Bool, _ dictData:Any?)->Void

func Localizable(_ string:String!)->String{
    return  NSLocalizedString(string, comment:string)
}

var Timestamp: TimeInterval {
    return Date().timeIntervalSince1970 * 1000
}

// getting device id
var deviceID: String {
    get{
        return UIDevice.current.identifierForVendor!.uuidString
    }
}

//getting localized model
var deviceLocalizedModel: String {
    get{
        return UIDevice.current.localizedModel
    }
}

//getting device model
var deviceModel: String {
    get{
        return UIDevice.current.model
    }
}

//getting system version
var deviceSystemVersion: String {
    get{
        return UIDevice.current.systemVersion
    }
}

//for getting the device system name
var deviceSystemName: String {
    get{
        return UIDevice.current.systemName
    }
}

//for getting the device name
var deviceName: String {
    get{
        return UIDevice.current.name
    }
}

//getting device app version
var deviceAppVerName : String {
    get{
        let ver : String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? ""
        return ver
    }
}

