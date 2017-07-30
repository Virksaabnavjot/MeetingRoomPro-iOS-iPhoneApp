//
//  BuildingListTableViewController.swift
//  MRPro
//
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import Foundation
import UIKit
//import ChameleonFramework

class BuildingListTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
   
    var buildings: [Building]?
    var meetingRvars: [MeetingRoom]?
    let apiRootUrl = "https://navsingh.org.uk/mrpro/"
    let searchController = UISearchController(searchResultsController: nil)
    
    var currentBuilding : Building!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "Building List"
        //setting background color for the view
        view.backgroundColor = UIColor.white
        self.navigationController?.hidesBarsOnSwipe = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Search by Building Name"
        searchController.searchBar.barTintColor = UIColor.black
        definesPresentationContext = true
        
        self.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
//        sendServiceRequests("")
        apiRequestForBuildings()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text {
//            sendServiceRequests(searchString)
//            apiRequestForBuildings()
            apiSearchBuilding(stringToSearch: searchController.searchBar.text!)
        }
        else
        {
            apiRequestForBuildings()
        }
    }
    
    
    func apiSearchBuilding(stringToSearch: String)
    {
        var dictRequest: [String : Any] = [:]
        dictRequest["text"] = stringToSearch
        self.refreshControl?.beginRefreshing()
        
        API.sharedInstance.searchBuildingList(dictRequest) { (success, dictData) -> Void in
            
            if success == true {
                print(dictData)
                let userData = dictData as! NSDictionary
                
                if ((userData["data"]) != nil)
                {
                    
                    let jsonParser = CustomJsonParser()
                    
                    self.buildings = jsonParser.parseServerBuildingJson(userData["data"] as! Array)
                    
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                    
                }
                
                
                
                
                
                
            }else{
                
                self.buildings = []
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
                
                
                
            }
        }
    }
    
    func apiRequestForBuildings()
    {
//        parseServerBuildingJson
        
        let dictRequest: [String : Any] = [:]

        self.refreshControl?.beginRefreshing()
        
        API.sharedInstance.getBuildingList(dictRequest) { (success, dictData) -> Void in
            
            if success == true {
                print(dictData)
                let userData = dictData as! NSDictionary
                
                if ((userData["data"]) != nil)
                {
                    let jsonParser = CustomJsonParser()

                    self.buildings = jsonParser.parseServerBuildingJson(userData["data"] as! Array)

                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                    
                }
                
                
                
                
                
                
            }else{
                
                self.displayAlert(dictData["code"] as! String!)
                
                
            }
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
    func sendServiceRequests(_ searchText: String) {
        /**
        sendRequest("buildings?name=\(searchText)") {
            data in
            let jsonParser = CustomJsonParser()
            self.buildings = jsonParser.parseBuildingJson(data)
            DispatchQueue.main.async {
                [unowned self] in
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
 **/
        
        let path : String = Bundle.main.path(forResource: "jsonFile", ofType: "json") as String!
        let data:NSData = NSData.dataWithContentsOfMappedFile(path as String) as! NSData
        let jsonParser = CustomJsonParser()
        self.buildings = jsonParser.parseBuildingJson(data as Data)
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
        
    }
    
    func sendRequest(_ serviceEndpoint: String, completion: @escaping (_ data: Data) -> ()) {
        
        let session = URLSession.shared
        let request = createRequest(serviceEndpoint)
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 500..<600:
                    print("Server error \(httpResponse.statusCode)")
                case 400..<500:
                    print("Client request error \(httpResponse.statusCode)")
                default:
                    if let data = data {
                        completion(data)
                    } else {
                        print("There is no available data")
                    }
                }
            } else {
                print("Unknown error occured. Please check if your web api is up and running")
            }
        })
        
        task.resume()
    }
    
    func createRequest(_ serviceEndpoint: String) -> URLRequest {
        
        let username = "virksaabnavjot@gmail.com"
        let password = "Mtkh6767"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: Data = loginString.data(using: String.Encoding.utf8.rawValue)!
        let base64LoginString = loginData.base64EncodedString(options: .lineLength64Characters)
        
        let url = URL(string: ("\(apiRootUrl)/\(serviceEndpoint)").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        return request as URLRequest
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
//        sendServiceRequests("")
        apiRequestForBuildings()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let buildings = buildings else {
            return 0
        }
        
        return buildings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SelfDesignedBuildingsTableViewCell else {
            print("Unable to cast cell as SelfDesignedBuildingsTableViewCell")
            return SelfDesignedBuildingsTableViewCell()
        }
        
        if let buildings = buildings {
            let building = buildings[indexPath.row]
            //cell.backgroundColor = UIColor.blue
            cell.nameLabel?.textColor = UIColor.flatBlack()
            cell.cityLabel?.textColor = UIColor.flatBlue()
            cell.numberOfFloorsLabel?.textColor = UIColor.flatRedColorDark()
            cell.countryLabel?.textColor = UIColor.flatForestGreen()
            cell.nameLabel.text = building.name
            cell.cityLabel.text = "City: \(building.city)"
            cell.countryLabel.text = "Country: \(building.country)"
            cell.numberOfFloorsLabel.text = "Floors: \(building.numberOfFloors)"
            cell.cellVu.layer.cornerRadius = 5.0
           
            cell.nameLabel.adjustsFontSizeToFitWidth = true
            cell.cityLabel.adjustsFontSizeToFitWidth = true
            cell.numberOfFloorsLabel.adjustsFontSizeToFitWidth = true
            cell.countryLabel.adjustsFontSizeToFitWidth = true
            cell.cityLabel.adjustsFontSizeToFitWidth = true
            cell.numberOfFloorsLabel.adjustsFontSizeToFitWidth = true
           
        } else {
            print("Sorry,No building information available")
        }
        
        return cell
    }
    
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        var dictRequest: [String : Any] = [:]
        currentBuilding = buildings?[indexPath.row]
        dictRequest["buildingID"] = buildings?[indexPath.row].id

        self.refreshControl?.beginRefreshing()
        
        API.sharedInstance.getRoomList(dictRequest) { (success, dictData) -> Void in
            
            if success == true {
                print(dictData)
                let userData = dictData as! NSDictionary
                
                if ((userData["data"]) != nil)
                {
                    let jsonParser = CustomJsonParser()
                    
                    
                    self.currentBuilding.rooms = jsonParser.parseServerMeetingRooms(userData["data"] as! Array)
                    
                    self.performSegue(withIdentifier: "MeetingRoomListSegue", sender: self)

                    
                }
                
                
                
                
                
                
            }else{
                
                self.displayAlert(dictData["code"] as! String!)
                
                
            }
        }

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MeetingRoomListSegue" {
            let row = self.tableView.indexPathForSelectedRow!.row
            var building: Building?
            
            if let buildings = buildings {
                building = buildings[row]
            } else {
                print("Sorry,No building information available")
            }
            
            let destinationController = segue.destination as? MeetingRoomListTableViewController
            destinationController?.building = currentBuilding //building
        }
    }
}
