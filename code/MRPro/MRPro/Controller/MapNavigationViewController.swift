//
//  MapNavigationViewController.swift
//  MRPro
//  Purpose: One of the most important classes - Handles map view, draw building on the map
//  point the room the the building/map and show user's current location, alow to upload images to server alongside show all meeting room related information, allow to make a call, and
//  have buttons/segue to all important functionality of the app.
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit
import MapKit

class MapNavigationViewController: UIViewController , MKMapViewDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate ,CLLocationManagerDelegate {
    let regionRadius: CLLocationDistance = 200
    var building: Building!
    var meetingRoom: MeetingRoom!
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapVu: MKMapView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var parentBuildingLbl: UILabel!
    @IBOutlet weak var capacityLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var coordinatesLbl: UILabel!
    @IBOutlet weak var directionsLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var floorLbl: UILabel!
    
    @IBOutlet weak var bookThisRoomBtn: UIButton!
    @IBOutlet weak var photoGalleryBtn: UIButton!
    @IBOutlet weak var uploadPhotosBtn: UIButton!
    @IBOutlet weak var reviewRoomBtn: UIButton!
    
    //create image picker - used for image upload feature
    let imgPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Meeting Room"
        self.nameLbl.text = meetingRoom.fullName
        
        //add styling
        self.nameLbl.adjustsFontSizeToFitWidth = true
        self.parentBuildingLbl.adjustsFontSizeToFitWidth = true
        self.floorLbl.text = "\(meetingRoom.floorNumber)"
        self.typeLbl.text = "\(meetingRoom.roomType)"
        self.capacityLbl.text = "\(meetingRoom.capacity)"
        self.parentBuildingLbl.text = "\(building.name)"
        self.phoneLbl.text = "\(meetingRoom.phone)"
        self.directionsLbl.text = "Directions : " + "\(meetingRoom.directions)"
        self.emailLbl.text = "\(meetingRoom.email)"
        
        //get room coordinates
        let latDouble : Double = (meetingRoom.coordinate?.latitude)!
        
        let longDouble : Double = (meetingRoom.coordinate?.longitude)!
        
        //set coordinate ot labels
        self.coordinatesLbl.text = String(latDouble) + " ," + String(longDouble)
        self.coordinatesLbl.adjustsFontSizeToFitWidth  = true
        mapVu.delegate = self
        
        //set the map type to hybid
        mapVu.mapType = MKMapType.hybridFlyover
        
        if let meetingRoomCoordinate = meetingRoom.coordinate {
            let meetingRoomLocation = CLLocation(latitude: meetingRoomCoordinate.latitude,
                                                 longitude: meetingRoomCoordinate.longitude)
            //center map according to meeting room location to fir the screen well
            centerMapOnLocation(meetingRoomLocation)
        }
        
        //draw building on the map
        drawBuilding()
        
        //add metting room to the building
        addMeetingRoomAnnotation()
        
        //get user permissions for location services
        getLocationServicesAuthorisation()
        
        //helps show current location of the user
        showUserCurrentLocation()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //buildings voordinates
        var coordinates = building.coordinates
        if (coordinates.count >= 0)
        {
            let cord = CLLocation.init(latitude: coordinates[0].latitude, longitude: coordinates[0].longitude)
            self.centerMapOnLocation(cord)
        }
    }
    
    //peform segue to room booking feature
    @IBAction func bookThisRoomBtnTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toBookThisRoom", sender: self)
    }
    
    //perform segue to photo gallery feature
    @IBAction func photoGalleryForThisRoomBtnTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toPhotoGallery", sender: self)
    }
    
    //allow the user to upload images to the photo gallery of the room
    @IBAction func uploadPhotosBtnTapped(_ sender: Any) {
        
        self.imgPicker.delegate = self
        
        //show an alert
        let actionSheet : UIAlertController = UIAlertController(title: "", message: "Select Option", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        //action to allow the user to pick image/photo form the phoe gallery
        let actionGallery = UIAlertAction(title:"Gallery", style: .default) { (action) in
            self.imgPicker.allowsEditing = true
            self.imgPicker.sourceType = .photoLibrary
            self.present(self.imgPicker, animated: true, completion: nil)
        }
        
        //allow user to use camera for taking picture to upload
        let actionCamera = UIAlertAction(title:"Camera", style: .default) { (action) in
            self.imgPicker.allowsEditing = true
            self.imgPicker.sourceType = .camera
            self.present(self.imgPicker, animated: true, completion: nil)
        }
        
        //give a cancel option if user decides to not upload an image
        let actionCancel = UIAlertAction(title:"Cancel", style: .cancel) { (action) in
            
        }
        
        //add actions to the alert
        actionSheet.addAction(actionGallery)
        actionSheet.addAction(actionCamera)
        actionSheet.addAction(actionCancel)
        
        //present the alert
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    //perform segue to room reviews feature
    @IBAction func reviewThisRoomBtnTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toRateVC", sender: self)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //image picker controller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let img : UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        var dictRequest: [String : Any] = [:]
        
        dictRequest["picture"] = UIImageJPEGRepresentation(img, 0.1)
        dictRequest["roomID"] = String(self.meetingRoom.id)
        
        //make api request and upload image to the server
        API.sharedInstance.uploadImage(dictRequest) { (success, dictData) -> Void in
            
            if success == true {
                print(dictData)
                let userData = dictData as! NSDictionary
                
                
            }else{
                //else show error message
                self.displayAlert(dictData["code"] as! String!)
                
            }
        }
        
        self.dismiss(animated: true) {
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //seques to different features based on identifiers
        if segue.identifier == "toBookThisRoom" {
            
            let destinationController = segue.destination as? RoomBookingViewController
            
            destinationController?.meetingRoom = meetingRoom
            
        }
        
        if segue.identifier == "toPhotoGallery" {
            
            let destinationController = segue.destination as? PhotoGalleryViewController
            
            destinationController?.meetingRoom = meetingRoom
            
        }
        
        if segue.identifier == "toRateVC" {
            
            let destinationController = segue.destination as? RateViewController
            
            destinationController?.meetingRoom = meetingRoom
            
        }
    }
    
    //helps display alert
    func displayAlert(_ msg:String!,needDismiss:Bool = false,title:String = "MRPro")  {
        
        let alertController = UIAlertController(title:title, message:msg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title:"ok", style: .cancel) { (action) in
            if needDismiss {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    //location permissions
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
    
    //center the map
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapVu.setRegion(coordinateRegion, animated: true)
    }
    
    //helps draw the building (polygon) coordinates array on the map view
    func drawBuilding() {
        //get the building coordinates
        var coordinates = building.coordinates
        if (coordinates.count >= 0)
        {
            let cord = CLLocation.init(latitude: coordinates[0].latitude, longitude: coordinates[0].longitude)
            self.centerMapOnLocation(cord)
        }
        //create polygon with the coordinates
        let polygon = MKPolygon(coordinates: &coordinates, count: coordinates.count)
        
        //add the polygon to map view
        mapVu.add(polygon)
    }
    
    //helps add the meeting room to the map view as an annotation
    func addMeetingRoomAnnotation() {
        guard let coordinate = meetingRoom.coordinate else {
            print("Meeting room coordinate not available to add annotation")
            return
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        //Style the annotation with room information
        annotation.title = meetingRoom.name
        annotation.subtitle = "Floor: \(meetingRoom.floorNumber), Capacity: \(meetingRoom.capacity)"
        
        //add room annotation
        self.mapVu.addAnnotation(annotation)
        mapVu.selectAnnotation(annotation, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: overlay)
            //style the polyogon
            polygonView.strokeColor = UIColor.red
            polygonView.fillColor = UIColor.lightGray
            polygonView.lineWidth = 0.8
            return polygonView
        }
        
        return MKOverlayRenderer()
    }
    
    //deals with location services authorisation
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
    
    //helps show users current location
    func showUserCurrentLocation() {
        locationManager.activityType = CLActivityType.fitness
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.mapVu.showsUserLocation = true
        locationManager.startUpdatingLocation()
    }
    
    //call button- allows the user to make a call by clicking the phone number
    //this will help the user to easily contact the prime contact of that room for assistance
    @IBAction func tapOnCallButton(_ sender: UIButton) {
        print("call");
        guard let number = URL(string: "tel://" + "\(meetingRoom.phone)") else { return }
        UIApplication.shared.open(number)
    }
    
}
