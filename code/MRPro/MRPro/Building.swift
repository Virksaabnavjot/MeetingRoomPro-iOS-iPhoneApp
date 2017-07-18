//
//  Building.swift
//  MRPro
//
//  Created by Nav on 05/01/2017.
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import Foundation
struct Building {
    let id: String
    let name: String
    let numberOfFloors: Int
    let coordinates: GeoPolygon
    let address: String
    let city: String
    let country: String
    let rooms: [MeetingRoom]
    
    init(id: String, name: String, numberOfFloors: Int, coordinates: GeoPolygon, address: String, city: String, country: String, rooms: [MeetingRoom]) {
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
