//
//  CustomJsonParser.swift
//  MRPro
//  Purpose: This file helps parse building and meeting room data from json
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

/*
 *Helps parse building and meeting room data from json
 */
class CustomJsonParser {
    
    //this function parses the building data -> usage in unit testing
    func parseBuildingJson(_ jsonData: Data) -> [Building] {
        
        let json = JSON(data: jsonData, options: .mutableContainers, error: nil)
        let buildingsJson = json["information"]
        
        //create building object array- to store all buildings
        var buildings = [Building]()
        
        //creating coordinates array - to save all the coordinates of building polygon
        var coordinates = [CLLocationCoordinate2D]()
        
        //loop through data
        for index in 0..<buildingsJson.count {
            let buildingJson = buildingsJson[index]
            
            //parse the meeting room data from json
            let meetingRooms = parseMeetingRoomsJson(jsonData, buildingIndex: index)
            
            //loop through data
            for index in 0..<buildingJson["shape"]["coordinates"][0].count {
                
                let coordinateJson = buildingJson["shape"]["coordinates"][0][index]
                
                if let coordinate = parseCoordinate(coordinateJson) {
                    coordinates.append(coordinate)
                }
            }
            
            //assign information to building object
            let building = Building(id: buildingJson["id"].stringValue,
                                    name: buildingJson["name"].stringValue,
                                    numberOfFloors: buildingJson["numberOfFloors"].intValue,
                                    coordinates: coordinates,
                                    address: buildingJson["address"].stringValue,
                                    city: buildingJson["city"].stringValue,
                                    country: buildingJson["country"].stringValue, rooms: meetingRooms)
            
            //appending the building to the BUILDINGS array
            buildings.append(building)
            coordinates.removeAll()
            
        }
        
        //returning all buildings
        return buildings
    }
    
    //parses the buildings data from the web api
    func parseServerBuildingJson(_ jsonData: Array<Any>) -> [Building] {
        
        //creating building object array - to store all buildings
        var buildings = [Building]()
        
        //loop through json data
        for index in 0..<jsonData.count {
            let buildingJson = jsonData[index] as! [String:String]
            
            //call parse coordinates method and pass it json data
            var coordinates = parseLocationString(jsonData: buildingJson)
            
            //assign information to building object
            let building = Building(id: buildingJson["id"]!,
                                    name: buildingJson["name"]!,
                                    numberOfFloors: Int(buildingJson["floors"]!)!,
                                    coordinates: coordinates,
                                    address: buildingJson["address"]!,
                                    city: buildingJson["city"]!,
                                    country: buildingJson["country"]!, rooms: [])
            
            //append building to the array
            buildings.append(building)
            coordinates.removeAll()
        }
        
        //return all the buildings
        return buildings
    }
    
    //parses the coordinates for building
    func parseLocationString(jsonData: [String : String]) ->  [CLLocationCoordinate2D]{
        var response = [ CLLocationCoordinate2D]()
        if  jsonData["location"] != nil {
            
            //get the location data from the json
            let location : String! = jsonData["location"]
            let latLongsArr : [String] = location.components(separatedBy: ",")
            
            for latLongObj in latLongsArr {
                
                let coordinatesArr : [String] = latLongObj.components(separatedBy: " ")
                var lat : Double = 0.0
                var long : Double = 0.0
                for value in coordinatesArr {  // some strings have extra spaces between latitude and longitude so we need to make a filter to trim white spaces
                    
                    if value.characters.count > 3  {
                        if lat == 0.0 {
                            lat = Double(value)!
                        }
                        else if long == 0.0
                        {
                            long =  Double(value)!
                        }
                    }
                }
                let coordinates = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
                response.append(coordinates)
            }
        }
        
        //return coordinates
        return response;
        
    }
    
    //parse json meeting room data from web api
    func parseServerMeetingRooms(_ jsonData: Array<Any>) -> [MeetingRoom] {
        
        //create meeting room object array - to store al rooms
        var meetingRooms = [MeetingRoom]()
        
        //loop through json data
        for index in 0..<jsonData.count {
            
            var meetingRoomJson = jsonData[index] as! [String:String]
            
            //rooms latitude n longitude
            let latitude : Double = Double(meetingRoomJson["latitude"] as String!)!
            let longitude : Double = Double(meetingRoomJson["longitude"] as String!)!
            
            //assign the values to room object
            let meetingRoom = MeetingRoom(id: Int(meetingRoomJson["roomId"]!)!,
                                          buildingId: meetingRoomJson["buildingId"]!,
                                          name: meetingRoomJson["name"]!,
                                          floorNumber: Int(meetingRoomJson["floorNumber"]!)!,
                                          coordinate: CLLocationCoordinate2DMake(latitude, longitude),
                                          capacity: Int(meetingRoomJson["capacity"]!)!,
                                          roomType: meetingRoomJson["type"]!,
                                          fullName: meetingRoomJson["name"]!,
                                          phone: meetingRoomJson["phone"]!,
                                          street: "",
                                          city: "", directions : meetingRoomJson["directions"]!, email : meetingRoomJson["email"]!)
            
            //append the meeting room to Meeting ROOMS array
            meetingRooms.append(meetingRoom)
        }
        
        //return the rooms array
        return meetingRooms
    }
    
    //parses json data for meeting rooms -> Usage in unit tests
    func parseMeetingRoomsJson(_ jsonData: Data, buildingIndex: Int) -> [MeetingRoom] {
        
        //create array
        var meetingRooms = [MeetingRoom]()
        
        let json = JSON(data: jsonData, options: .mutableContainers, error: nil)
        
        //rooms json - setting path where to find data
        let meetingRoomsJson = json["information"][buildingIndex]["meetingRooms"]
        
        //loop through json data for meeting rooms
        for index in 0..<meetingRoomsJson.count {
            
            var meetingRoomJson = meetingRoomsJson[index]
            
            //get the coordinates data for room
            let coordinateJson = meetingRoomsJson[index]["shape"]["coordinates"]
            
            //call the parse method and pass the corrdinates data to it and get the parsed results
            let coordinate = parseCoordinate(coordinateJson)
            
            //assign values to meeting room object
            let meetingRoom = MeetingRoom(id: meetingRoomJson["id"].intValue,
                                          buildingId: meetingRoomJson["buildingId"].stringValue,
                                          name: meetingRoomJson["name"].stringValue,
                                          floorNumber: meetingRoomJson["floorNumber"].intValue,
                                          coordinate: coordinate,
                                          capacity: meetingRoomJson["capacity"].intValue,
                                          roomType: meetingRoomJson["roomType"].stringValue,
                                          fullName: meetingRoomJson["fullName"].stringValue,
                                          phone: meetingRoomJson["phone"].stringValue,
                                          street: meetingRoomJson["street"].stringValue,
                                          city: meetingRoomJson["city"].stringValue,
                                          directions: meetingRoomJson["directions"].stringValue,
                                          email: meetingRoomJson["email"].stringValue)
            
            //append
            meetingRooms.append(meetingRoom)
        }
        
        return meetingRooms
    }
    
    //parses the coordinates -> usage in unit tests as well
    func parseCoordinate(_ coordinateJson: JSON) -> CLLocationCoordinate2D? {
        
        //telling which to find latitude and longitude values at
        guard let latitudeValue = coordinateJson[0].rawValue as? NSNumber,
            let longitudeValue = coordinateJson[1].rawValue as? NSNumber else {
                print("Unable to parse coordinate values")
                return nil
        }
        
        let latitude = CLLocationDegrees(latitudeValue)
        let longitude = CLLocationDegrees(longitudeValue)
        
        //create coordinates for map view usage using CLLocation Coordinate 2D from Corelocation
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        //returning the results/coordinate
        return coordinate
    }
}


