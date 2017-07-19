//
//  CustomJsonParser.swift
//  MRPro
//
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

class CustomJsonParser {
    
    func parseBuildingJson(_ jsonData: Data) -> [Building] {
        
        let json = JSON(data: jsonData, options: .mutableContainers, error: nil)
        let buildingsJson = json["information"]
        var buildings = [Building]()
        var coordinates = [CLLocationCoordinate2D]()
        
        for index in 0..<buildingsJson.count {
            let buildingJson = buildingsJson[index]
            
            let meetingRooms = parseMeetingRoomsJson(jsonData, buildingIndex: index)
            
            for index in 0..<buildingJson["shape"]["coordinates"][0].count {
                
                let coordinateJson = buildingJson["shape"]["coordinates"][0][index]
                
                if let coordinate = parseCoordinate(coordinateJson) {
                    coordinates.append(coordinate)
                }
            }
            
            let building = Building(id: buildingJson["id"].stringValue,
                                    name: buildingJson["name"].stringValue,
                                    numberOfFloors: buildingJson["numberOfFloors"].intValue,
                                    coordinates: coordinates,
                                    address: buildingJson["address"].stringValue,
                                    city: buildingJson["city"].stringValue,
                                    country: buildingJson["country"].stringValue, rooms: meetingRooms)
            
            buildings.append(building)
            coordinates.removeAll()
        }
        return buildings
    }
    
    func parseMeetingRoomsJson(_ jsonData: Data, buildingIndex: Int) -> [MeetingRoom] {
        
        var meetingRooms = [MeetingRoom]()
        let json = JSON(data: jsonData, options: .mutableContainers, error: nil)
        let meetingRoomsJson = json["information"][buildingIndex]["meetingRooms"]
        
        
        for index in 0..<meetingRoomsJson.count {
            
            var meetingRoomJson = meetingRoomsJson[index]
            
            let coordinateJson = meetingRoomsJson[index]["shape"]["coordinates"]
            let coordinate = parseCoordinate(coordinateJson)
            
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
                                          city: meetingRoomJson["city"].stringValue)
            
            meetingRooms.append(meetingRoom)
        }
        
        return meetingRooms
    }
    
    func parseCoordinate(_ coordinateJson: JSON) -> CLLocationCoordinate2D? {
        
        guard let latitudeValue = coordinateJson[0].rawValue as? NSNumber,
            let longitudeValue = coordinateJson[1].rawValue as? NSNumber else {
                print("Unable to parse coordinate values")
                return nil
        }
        
        let latitude = CLLocationDegrees(latitudeValue)
        let longitude = CLLocationDegrees(longitudeValue)
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        return coordinate
    }
}
