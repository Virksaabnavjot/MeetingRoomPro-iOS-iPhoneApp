//
//  Building.swift
//  MRPro
//  Purpose: Defining a struct for building object
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//


import Foundation
import CoreLocation

/*
 struct for building object
 */
struct Building {
    let id: String
    let name: String
    let numberOfFloors: Int
    let coordinates: [CLLocationCoordinate2D]
    let address: String
    let city: String
    let country: String
    var rooms: [MeetingRoom]
    
    init(id: String, name: String, numberOfFloors: Int, coordinates: [CLLocationCoordinate2D], address: String, city: String, country: String, rooms: [MeetingRoom]) {
        self.id = id
        self.name = name
        self.numberOfFloors = numberOfFloors
        self.coordinates = coordinates
        self.address = address
        self.city = city
        self.country = country
        self.rooms = rooms
    }
}
