//
//  MeetingRoomListTableViewController.swift
//  MRPro
//  Purpose: Helps display list of meeting rooms in a table view
//  Created by Nav
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit
import CoreLocation

/*
 Display List of Meeting rooms in the building which the user selected from the list in last screen
 */
class MeetingRoomListTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    //create building object
    var building: Building!
    
    //creating a array of rooms - usage: helps store filtered rooms from user search
    var filteredMeetingRooms: [MeetingRoom]!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        //add styling to search controller
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Search Meeting Rooms"
        searchController.searchBar.barTintColor = UIColor.black
        definesPresentationContext = true
    }
    
    //updating search results
    func updateSearchResults(for searchController: UISearchController) {
        
        //pass the user search text to method that will filter the results
        if let searchString = searchController.searchBar.text {
            
            //pass search text to the method
            filterMeetingRooms(searchString)
        }
    }
    
    //filters rooms based on user search text
    func filterMeetingRooms(_ searchString: String) {
        
        filteredMeetingRooms = building.rooms.filter() {
            return $0.name.lowercased().contains(searchString.lowercased())
        }
        
        tableView.reloadData()
    }
    
    //return the number of rows need for table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //checking if seach is active and user inpu is not blank
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredMeetingRooms.count
        } else {
            return building.rooms.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Custom Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as? MeetingRoomsCell else {
            return MeetingRoomsCell()
        }
        
        //room object instance
        let meetingRoom: MeetingRoom!
        
        //checking if seach is active and user inpu is not blank
        if searchController.isActive && searchController.searchBar.text != "" {
            meetingRoom = filteredMeetingRooms[indexPath.row] //get index
        } else {
            meetingRoom = building.rooms[indexPath.row]
        }
        
        //set room information to these variables
        let roomName = meetingRoom.name
        let floorNumber = meetingRoom.floorNumber
        let roomType = meetingRoom.roomType
        print("Room Name: ", roomName)
        
        //styling labels
        cell.nameLabel?.textColor = UIColor.black
        cell.floorNumberLabel?.textColor = UIColor.flatRed()
        cell.roomTypeLabel?.textColor = UIColor.flatBlue()
        
        //set the information to cell labels
        cell.nameLabel.text = roomName
        cell.floorNumberLabel.text = "Floor: \(String(floorNumber))"
        cell.roomTypeLabel.text = "Type: \(roomType)"
        
        cell.cellVu.layer.cornerRadius = 5.0
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "IndoorMapsSegue", sender: self)
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //performing segue to next screen and passing some data to it for further use
        if segue.identifier == "IndoorMapsSegue" {
            
            let row = self.tableView.indexPathForSelectedRow!.row
            let destinationController = segue.destination as? MapNavigationViewController
            
            destinationController?.building = building
            if searchController.isActive && searchController.searchBar.text != "" {
                destinationController?.meetingRoom = filteredMeetingRooms[row]
            } else {
                destinationController?.meetingRoom = building.rooms[row]
            }
        }
    }
}
