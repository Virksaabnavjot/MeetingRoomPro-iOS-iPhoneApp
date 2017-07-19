//
//  MeetingRoomListTableViewController.swift
//  MRPro
//
//  Created by Nav on 18/07/2017.
//  Copyright © 2017 MeetingRoom Pro | Navjot Singh Virk | Gymandnutrition.com | Navsingh.org.uk. All rights reserved.
//

import UIKit
import CoreLocation

class MeetingRoomListTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    var building: Building!
    var filteredMeetingRooms: [MeetingRoom]!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Search Meeting Rooms"
        searchController.searchBar.barTintColor = UIColor.red
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchString = searchController.searchBar.text {
            filterMeetingRooms(searchString)
        }
    }
    
    func filterMeetingRooms(_ searchString: String) {
        
        filteredMeetingRooms = building.rooms.filter() {
            return $0.name.lowercased().contains(searchString.lowercased())
        }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredMeetingRooms.count
        } else {
            return building.rooms.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as? SelfDesignedMeetingRoomsTableViewCell else {
            return SelfDesignedMeetingRoomsTableViewCell()
        }
        
        let meetingRoom: MeetingRoom!
        if searchController.isActive && searchController.searchBar.text != "" {
            meetingRoom = filteredMeetingRooms[indexPath.row]
        } else {
            meetingRoom = building.rooms[indexPath.row]
        }
        
        let roomName = meetingRoom.name
        let floorNumber = meetingRoom.floorNumber
        let roomType = meetingRoom.roomType
        print("Room Name: ", roomName)
        
        cell.nameLabel?.textColor = UIColor.black
        cell.floorNumberLabel?.textColor = UIColor.flatRed()
        cell.roomTypeLabel?.textColor = UIColor.flatBlue()
        
        cell.nameLabel.text = roomName
        cell.floorNumberLabel.text = "Floor: \(String(floorNumber))"
        cell.roomTypeLabel.text = "Type: \(roomType)"
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "IndoorMapsSegue" {
            
            let row = self.tableView.indexPathForSelectedRow!.row
            let destinationController = segue.destination as? IndoorMapsViewController
            
            destinationController?.building = building
            if searchController.isActive && searchController.searchBar.text != "" {
                destinationController?.meetingRoom = filteredMeetingRooms[row]
            } else {
                destinationController?.meetingRoom = building.rooms[row]
            }
        }
    }
}
