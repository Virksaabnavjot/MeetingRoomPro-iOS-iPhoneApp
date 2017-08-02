//
//  MRProTests.swift
//  MRProTests
//  Purpose: Uniting testing
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import XCTest
import CoreLocation

@testable import MRPro

class MRProTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    //function to return data from the file
    func jsonFromFile() -> Data {
        //setting the path to our local json file
        let path = Bundle.main.path(forResource: "jsonFile", ofType: "json")
        //get the json data from the file
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path!))
        
        return jsonData!
    }
    
    
    /*
     function to ensure the json data for building object can be parsed
     sucessfully or not
     */
    
    func testCanParseBuidingInfoFromJson() {
        
        //Custom class for parsing building and meeting room json
        let jsonParser = CustomJsonParser() //creating instance of parser class
        let jsonData = jsonFromFile() //getting the json form file
        let buildings = jsonParser.parseBuildingJson(jsonData)
        let extractedBuilding = buildings[0]// getting the building at index zero
        
        //saving all the building information in variables
        let buildingName = extractedBuilding.name
        let buildingId = extractedBuilding.id
        let city = extractedBuilding.city
        let country = extractedBuilding.country
        let numberOfFloors = extractedBuilding.numberOfFloors
        
        //testing with the data from file and check if tests fail or pass
        XCTAssertEqual(buildingName, "NCI")
        XCTAssertEqual(buildingId, "DUB01")
        XCTAssertEqual(city, "Dublin")
        XCTAssertEqual(country, "Ireland")
        XCTAssertEqual(numberOfFloors, 3)
    }
    
    /*
     Function to test if building coordinates from json can be parsed
     */
    
    func testCanParseBuidingCoordinatesFromJson() {
        //creating instance of parser class
        let jsonParser = CustomJsonParser()
        //calling the json from file function that returns json data
        let jsonData = jsonFromFile()
        
        //creating an array of coordinates
        let buildingCoordinates = [
            CLLocationCoordinate2D(latitude: 53.294974000000003, longitude: -6.4266310000000004),
            CLLocationCoordinate2D(latitude: 53.294846999999997, longitude: -6.4264190000000001),
            CLLocationCoordinate2D(latitude: 53.294288999999999, longitude: -6.4268879999999999),
            CLLocationCoordinate2D(latitude: 53.294325999999998, longitude: -6.4271940000000001),
            CLLocationCoordinate2D(latitude: 53.294974000000003, longitude: -6.4266310000000004)
        ]
        
        //creating a variable and seeting it equal to all the building data
        let buildings = jsonParser.parseBuildingJson(jsonData)
        //get the building at index zero
        let extractedBuildingShape = buildings[0]
        
        //for loop - that iterates through the building coordinates and
        //check if the longitude and latitude at each index matches or not
        for i in 0..<buildingCoordinates.count {
            
            //long and lat from the created array of coordinates - buildingCoordinates
            let longitude = buildingCoordinates[i].longitude
            let latitude = buildingCoordinates[i].latitude
            
            //long and lat from the building from json file
            let extractedLatitude = extractedBuildingShape.coordinates[i].latitude
            let extractedLongitude = extractedBuildingShape.coordinates[i].longitude
            
            //testing
            XCTAssertEqual(longitude, extractedLongitude)
            XCTAssertEqual(latitude, extractedLatitude)
        }
    }
    
    
    /*
     Function to test if room information from json can be parsed
     */
    
    func testCanParseMeetingRoomInfoFromJson() {
        let jsonParser = CustomJsonParser()
        let jsonData = jsonFromFile()
        //getting all the meeting rooms available in the building
        let meetingRooms = jsonParser.parseMeetingRoomsJson(jsonData, buildingIndex: 1)
        //getting the first meeting room
        let meetingRoom = meetingRooms.first!
        
        //saving the room information in variables
        let roomName = meetingRoom.name
        let roomId = meetingRoom.id
        let floorNumber = meetingRoom.floorNumber
        let capacity = meetingRoom.capacity
        let buildingId = meetingRoom.buildingId
        
        //test
        XCTAssertEqual(roomName, "SCR 3")
        XCTAssertEqual(roomId, 6)
        XCTAssertEqual(floorNumber, 3)
        XCTAssertEqual(capacity, 3)
        XCTAssertEqual(buildingId, "National College of Ireland")
    }
    
    
    /*
     Function to test if meeting room coordinates from json can be parsed
     */
    
    func testCanParseMeetingRoomCoodinatesFromJson() {
        let jsonParser = CustomJsonParser()
        let jsonData = jsonFromFile()
        
        //creating a set of coordinate using CLLocationCoordinate2D
        let coordinate = CLLocationCoordinate2D(latitude: 43.294846, longitude: -7.426421)
        
        //getting the meeitng rooms
        let meetingRooms = jsonParser.parseMeetingRoomsJson(jsonData, buildingIndex: 1)
        
        //getting the lat and long of meeting room at index zero
        let latitude = meetingRooms[0].coordinate?.latitude
        let longitude = meetingRooms[0].coordinate?.longitude
        
        //test
        XCTAssertEqual(latitude, coordinate.latitude)
        XCTAssertEqual(longitude, coordinate.longitude)
    }
    
}
