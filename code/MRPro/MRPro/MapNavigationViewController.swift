//
//  MapNavigationViewController.swift
//  MRPro
//
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
    
    let imgPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Meeting Room"
        self.nameLbl.text = meetingRoom.fullName
    
        self.nameLbl.adjustsFontSizeToFitWidth = true
        self.parentBuildingLbl.adjustsFontSizeToFitWidth = true
       // self.nameLbl.adjustsFontSizeToFitWidth
        self.floorLbl.text = "\(meetingRoom.floorNumber)"
        self.typeLbl.text = "\(meetingRoom.roomType)"
        self.capacityLbl.text = "\(meetingRoom.capacity)"
        self.parentBuildingLbl.text = "\(building.name)"
        self.phoneLbl.text = "\(meetingRoom.phone)"
        self.directionsLbl.text = "Directions : " + "\(meetingRoom.directions)"
        self.emailLbl.text = "\(meetingRoom.email)"

        let latDouble : Double = (meetingRoom.coordinate?.latitude)!
        
        let longDouble : Double = (meetingRoom.coordinate?.longitude)!

        
        self.coordinatesLbl.text = String(latDouble) + " ," + String(longDouble)
        self.coordinatesLbl.adjustsFontSizeToFitWidth  = true
        mapVu.delegate = self
        //mapVu.mapType = MKMapType.hybridFlyover
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var coordinates = building.coordinates
        if (coordinates.count >= 0)
        {
            let cord = CLLocation.init(latitude: coordinates[0].latitude, longitude: coordinates[0].longitude)
            self.centerMapOnLocation(cord)
        }
    }
    
    @IBAction func bookThisRoomBtnTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toBookThisRoom", sender: self)
    }
    @IBAction func photoGalleryForThisRoomBtnTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toPhotoGallery", sender: self)
    }
    @IBAction func uploadPhotosBtnTapped(_ sender: Any) {
        
        
        self.imgPicker.delegate = self
        
        let actionSheet : UIAlertController = UIAlertController(title: "", message: "Select Option", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let actionGallery = UIAlertAction(title:"Gallery", style: .default) { (action) in
            self.imgPicker.allowsEditing = true
            self.imgPicker.sourceType = .photoLibrary
            self.present(self.imgPicker, animated: true, completion: nil)
        }
        
        let actionCamera = UIAlertAction(title:"Camera", style: .default) { (action) in
            self.imgPicker.allowsEditing = true
            self.imgPicker.sourceType = .camera
            self.present(self.imgPicker, animated: true, completion: nil)
        }
        
        let actionCancel = UIAlertAction(title:"Cancel", style: .cancel) { (action) in
            
        }
        
        actionSheet.addAction(actionGallery)
        actionSheet.addAction(actionCamera)
        actionSheet.addAction(actionCancel)
        
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    @IBAction func reviewThisRoomBtnTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toRateVC", sender: self)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let img : UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        var dictRequest: [String : Any] = [:]
        
        dictRequest["picture"] = UIImageJPEGRepresentation(img, 0.1)
        dictRequest["roomID"] = String(self.meetingRoom.id)
        
        API.sharedInstance.uploadImage(dictRequest) { (success, dictData) -> Void in
            
            if success == true {
                print(dictData)
                let userData = dictData as! NSDictionary
                
                
                
                
                
            }else{
                
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
    
    
    //MARK: Buidling Controller
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
        mapVu.setRegion(coordinateRegion, animated: true)
    }
    
    func drawBuilding() {
        var coordinates = building.coordinates
        if (coordinates.count >= 0)
        {
            let cord = CLLocation.init(latitude: coordinates[0].latitude, longitude: coordinates[0].longitude)
            self.centerMapOnLocation(cord)
        }
        
        let polygon = MKPolygon(coordinates: &coordinates, count: coordinates.count)
        mapVu.add(polygon)
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
        self.mapVu.addAnnotation(annotation)
        mapVu.selectAnnotation(annotation, animated: true)
        
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        //    func renderer(for overlay: MKOverlay) -> MKOverlayRenderer?
        //    {
        if overlay is MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: overlay)
            polygonView.strokeColor = UIColor.red
            polygonView.fillColor = UIColor.lightGray
            polygonView.lineWidth = 0.8
            return polygonView
        }
        
        return MKOverlayRenderer()
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
        self.mapVu.showsUserLocation = true
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func tapOnCallButton(_ sender: UIButton) {
        print("call");
        guard let number = URL(string: "tel://" + "\(meetingRoom.phone)") else { return }
        UIApplication.shared.open(number)
    }
    
}
