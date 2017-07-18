//
//  IndoorMapsViewController.swift
//  MRPro
//
//  Created by Nav on 18/07/2017.
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import CoreLocation
import UIKit
import MapKit

class IndoorMapsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let regionRadius: CLLocationDistance = 200
    var building: Building!
    var meetingRoom: MeetingRoom!
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var indoorMapInformationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.mapType = MKMapType.hybridFlyover
        
        if let meetingRoomCoordinate = meetingRoom.coordinate {
            let meetingRoomLocation = CLLocation(latitude: meetingRoomCoordinate.latitude,
                                                 longitude: meetingRoomCoordinate.longitude)
            
            centerMapOnLocation(meetingRoomLocation)
        }
        
        drawBuilding()
        
        addMeetingRoomAnnotation()
        
        getLocationServicesAuthorisation()
        
        showUserCurrentLocation()
    }
    
    func getLocationServicesAuthorisation() {
        let status = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined || status ==  .denied || status == .restricted {
            locationManager.requestWhenInUseAuthorization()
            
            if status == .denied {
                showAlertToEnableLocationServicesInSettings()
                showUserCurrentLocation()
            }
        }
    }
    
    func showUserCurrentLocation() {
        locationManager.activityType = CLActivityType.fitness
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
    }
    
    func showAlertToEnableLocationServicesInSettings() {
        let alertController = UIAlertController(title: "Authorisation Denied", message: "Please enable location services for this app", preferredStyle: .alert)
        let openSettingsAction = UIAlertAction(title: "Open Settings", style: .default) {
            UIAlertAction in
            UIApplication.shared.openURL(URL(string:UIApplicationOpenSettingsURLString)!)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            UIAlertAction in
            print("Opening settings canceled by user")
        }
        
        alertController.addAction(openSettingsAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func drawBuilding() {
        var coordinates = building.coordinates
        let polygon = MKPolygon(coordinates: &coordinates, count: coordinates.count)
        mapView.add(polygon)
    }
    
    func addMeetingRoomAnnotation() {
        guard let coordinate = meetingRoom.coordinate else {
            print("Meeting room coordinate not available to add annotation")
            return
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = meetingRoom.name
        annotation.subtitle = "Floor: \(meetingRoom.floorNumber), Capacity: \(meetingRoom.capacity)"
        self.mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: overlay)
            polygonView.strokeColor = UIColor.red
            polygonView.fillColor = UIColor.lightGray
            polygonView.lineWidth = 0.8
            return polygonView
        }
        
        return MKOverlayRenderer()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let cell = indoorMapInformationTableView.dequeueReusableCell(withIdentifier: "IndoorMapsInfoCell", for: indexPath) as? SelfDesignedIndoorMapsInformationTableViewCell else {
            print("Unable to cast cell as CustomIndoorMapsTableViewCell")
            return SelfDesignedIndoorMapsInformationTableViewCell()
        }
        cell.nameLabel.text = meetingRoom.fullName
        cell.floorNumberLabel.text = "Floor: \(meetingRoom.floorNumber)"
        cell.roomTypeLabel.text = "Room Type: \(meetingRoom.roomType)"
        cell.capacityLabel.text = "Capacity: \(meetingRoom.capacity)"
        cell.buildingNameLabel.text = "Building: \(building.name)"
        
        return cell
    }
    
    
}
