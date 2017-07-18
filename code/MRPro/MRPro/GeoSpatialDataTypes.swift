//
//  GeoSpatialDataTypes.swift
//  MRPro
//
//  Created by Nav on 18/07/2017.
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import Foundation
import CoreLocation

public struct GeoPolygon {
    var coordinates: [CLLocationCoordinate2D]
    
    init(coordinates: [CLLocationCoordinate2D]) {
        self.coordinates = coordinates
    }
}

public struct GeoPoint {
    var coordinates: CLLocationCoordinate2D?
    
    init(coordinates: CLLocationCoordinate2D?){
        self.coordinates = coordinates
    }
}
