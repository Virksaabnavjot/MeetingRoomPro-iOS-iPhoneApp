//
//  BuildingListTableViewController.swift
//  MRPro
//  Purpose: Helps to display buildings list and allow search
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import Foundation
import UIKit

/*
 Display buildings list and allow search
 */
class BuildingListTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    //create buildings array
    var buildings: [Building]?
    
    //create rooms array
    var meetingRvars: [MeetingRoom]?
    
    //create uisearch controller
    let searchController = UISearchController(searchResultsController: nil)
    
    //create a variable to store current building
    var currentBuilding : Building!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "Building List"
        
        //setting background color for the view
        view.backgroundColor = UIColor.white
        
        //hiding the navigation controller on swipe
        self.navigationController?.hidesBarsOnSwipe = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        //styling
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Search by Building Name"
        searchController.searchBar.barTintColor = UIColor.black
        definesPresentationContext = true
        
        self.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        //make web api request
        apiRequestForBuildings()
    }
    
    //updating the search results
    func updateSearchResults(for searchController: UISearchController) {
        
        //get the user input from search bar and call the api seach building method
        if let searchString = searchController.searchBar.text {
            
            //call the search buildings method
            apiSearchBuilding(stringToSearch: searchString)
        }
        else
        {
            //if the search bar text is empty show a list of all buildings
            apiRequestForBuildings()
        }
    }
    
    
    /*method returns building in accordance to user input - our api allow
    /search based on three factors- Use can search by Builing Name, City or Country the
    building is located in*/
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
        
        
        let path : String = Bundle.main.path(forResource: "jsonFile", ofType: "json") as String!
        let data:NSData = NSData.dataWithContentsOfMappedFile(path as String) as! NSData
        let jsonParser = CustomJsonParser()
        self.buildings = jsonParser.parseBuildingJson(data as Data)
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
        
    }
    
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        apiRequestForBuildings()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let buildings = buildings else {
            return 0
        }
        
        return buildings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? BuildingsCell else {
            print("Unable to cast cell as BuildingsCell")
            return BuildingsCell()
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
