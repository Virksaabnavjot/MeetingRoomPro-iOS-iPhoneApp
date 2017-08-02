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
        
        //making request
        API.sharedInstance.searchBuildingList(dictRequest) { (success, dictData) -> Void in
            
            if success == true {
                print(dictData)
                let userData = dictData as! NSDictionary
                
                if ((userData["data"]) != nil)
                {
                    
                    //creating a custom json parser instance
                    let jsonParser = CustomJsonParser()
                    
                    //send the json to parser and get back the buildings array
                    self.buildings = jsonParser.parseServerBuildingJson(userData["data"] as! Array)
                    
                    //load the new data into the table view
                    self.tableView.reloadData()
                    
                    //end refreshing
                    self.refreshControl?.endRefreshing()
                    
                }
                
            }else{
                //set array as empty, reload and end refreshing in case of mishap
                self.buildings = []
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
                
            }
        }
    }
    
    /*
     Method return list of buildings
     */
    func apiRequestForBuildings()
    {
        
        let dictRequest: [String : Any] = [:]
        
        self.refreshControl?.beginRefreshing()
        
        //make api request to get building list
        API.sharedInstance.getBuildingList(dictRequest) { (success, dictData) -> Void in
            
            if success == true {
                print(dictData)
                let userData = dictData as! NSDictionary
                
                if ((userData["data"]) != nil)
                {
                    let jsonParser = CustomJsonParser()
                    //send the json to parser and get back the buildings array
                    self.buildings = jsonParser.parseServerBuildingJson(userData["data"] as! Array)
                    
                    //load the new data into the table view
                    self.tableView.reloadData()
                    
                    //end refreshing
                    self.refreshControl?.endRefreshing()
                    
                }
                
            }else{
                //else show an alert with the error
                self.displayAlert(dictData["code"] as! String!)
            }
        }
    }
    
    //display alert method- helps display an alert
    func displayAlert(_ msg:String!,needDismiss:Bool = false,title:String = "MRPro")  {
        
        //creating instance of ui alert controller
        let alertController = UIAlertController(title:title, message:msg, preferredStyle: .alert)
        
        //asign default actions for controller
        let defaultAction = UIAlertAction(title:"ok", style: .cancel) { (action) in
            if needDismiss {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        //add actions to controller
        alertController.addAction(defaultAction)
        
        //present the alert to the user
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        //get all buildings on referesh
        apiRequestForBuildings()
    }
    
    //return number of rows for table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let buildings = buildings else {
            return 0
        }
        
        //count number items in buildings array
        return buildings.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //retun our cusotom cell for showing the building information - BuildingsCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? BuildingsCell else {
            print("Unable to cast cell as BuildingsCell")
            return BuildingsCell()
        }
        
        
        if let buildings = buildings {
            //getting the building at each index of the array
            let building = buildings[indexPath.row]
            
            //adding some styling to the cell
            cell.nameLabel?.textColor = UIColor.flatBlack()
            cell.cityLabel?.textColor = UIColor.flatBlue()
            cell.numberOfFloorsLabel?.textColor = UIColor.flatRedColorDark()
            cell.countryLabel?.textColor = UIColor.flatForestGreen()
            
            //set information to the cell labels
            cell.nameLabel.text = building.name
            cell.cityLabel.text = "City: \(building.city)"
            cell.countryLabel.text = "Country: \(building.country)"
            cell.numberOfFloorsLabel.text = "Floors: \(building.numberOfFloors)"
            
            //cell styling
            cell.cellVu.layer.cornerRadius = 5.0
            cell.nameLabel.adjustsFontSizeToFitWidth = true
            cell.cityLabel.adjustsFontSizeToFitWidth = true
            cell.numberOfFloorsLabel.adjustsFontSizeToFitWidth = true
            cell.countryLabel.adjustsFontSizeToFitWidth = true
            cell.cityLabel.adjustsFontSizeToFitWidth = true
            cell.numberOfFloorsLabel.adjustsFontSizeToFitWidth = true
            
        } else {
            //else show a message
            print("Sorry,No building information available")
        }
        
        return cell
    }
    
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        var dictRequest: [String : Any] = [:]
        
        //getting the row number when a building is selected from the list
        //this helps us to get all the meeting rooms from that building
        currentBuilding = buildings?[indexPath.row]
        dictRequest["buildingID"] = buildings?[indexPath.row].id
        
        self.refreshControl?.beginRefreshing()
        
        //make request
        API.sharedInstance.getRoomList(dictRequest) { (success, dictData) -> Void in
            
            if success == true {
                print(dictData)
                let userData = dictData as! NSDictionary
                
                if ((userData["data"]) != nil)
                {
                    //create parser instance
                    let jsonParser = CustomJsonParser()
                    
                    //telling the parser to parse meeting room data and return an array of rooms
                    self.currentBuilding.rooms = jsonParser.parseServerMeetingRooms(userData["data"] as! Array)
                    
                    //perform segue to next screen/view
                    self.performSegue(withIdentifier: "MeetingRoomListSegue", sender: self)
                    
                }
                
            }else{
                //else display error message
                self.displayAlert(dictData["code"] as! String!)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //perform seque with an identifer
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
