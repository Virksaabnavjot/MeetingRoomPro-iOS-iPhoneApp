<?php

/**
*@author : Navjot Singh Virk
*File: rooms_model.php
*Project: MRPro
*Purpose: Handle room information
*Github: https://github.com/mrpro/
*Copyrights 2017-2018
**/

class Rooms_model extends CI_Model
{

  function __construct() {
    parent::__construct();
  }


  function allRooms($buildingID)
  {
    //creating an array
    $response = array();
    //query
    $query = $this->db->query("SELECT  rooms.roomId,rooms.buildingId, rooms.floorNumber,rooms.name,rooms.capacity,rooms.type,rooms.phone,rooms.email, rooms.directions , X(rooms.coordinates) as latitude ,Y(rooms.coordinates) as longitude FROM rooms  where buildingId = '$buildingID'");


    if($query->num_rows()>0)
    {
      $response['status'] = 'success';
      $response['data']=$this->findRating($query->result_array());

    }
    else
    {
      $response['status'] = 'failure';
      $response['code'] = 'database failure';

    }
    return $response;
  }


  // return average rating of user reviews
  function findRating($data)
  {
    $result = array();
    for ($i = 0; $i< count($data);$i++){

      $obj = $data[$i];
      $roomID = $data[$i]["roomId"];

      $obj["rating"] = "0";

      //query and get the average rating for the user reviews for meeting room given by usres
      $query = $this->db->query("SELECT AVG(rating) as rating FROM room_reviews  where roomID = $roomID");
      if($query->num_rows()>0)
      {
        $obj["rating"] = !$query->result_array()[0]["rating"]? "0.0" :$query->result_array()[0]["rating"];
      }
      else
      {
        $obj["rating"] = "0";

      }

      array_push($result, $obj);
    }
    //return the result
    return $result;

  }

  //Handles Meeting room booking and ensures if the room is already booked on a certain time it can be booked
  //again by the same or other users
  function bookRooms($roomID,$title,$userID,$startDate, $endDate,$otherUsers){

    $result = $this->canBookRoom($startDate,$endDate,$roomID);
    if ($result == "FALSE")
    {
      $response['status'] = 'failure';
      $response['code'] = 'This room is already Booked on these time slots';
      return $response;
    }
    $add_data = array("roomID"=>$roomID,"title"=>$title,"startDate"=>$startDate,"endDate"=>$endDate,"userID"=>$userID);
    if ($this->db->insert('bookings', $add_data)) {
      $insert_id = $this->db->insert_id();
      for ($i = 0 ; $i < count($otherUsers); $i++)
      {
        $obj = $otherUsers[$i];

        $data = array("bookingID"=>$insert_id,"userID"=>$obj);
        $this->db->insert('booking_invitations', $data);


      }
      $response['status'] = 'success';
      $response['code']="Meeting Created Successfuly";
    }
    else
    {
      $response['status'] = 'failure';
      $response['code'] = 'database failure';
    }
    return $response;

  }

  //also handles room booking
  function canBookRoom($startDate,$endDate,$roomID)
  {
    $result = "TRUE";
    $query = $this->db->query("SELECT * FROM bookings  where roomID = $roomID");
    if($query->num_rows()>0)
    {
      $bookings=$query->result_array();


      for ($i =0 ; $i < count($bookings);  $i++)
      {
        $bookStartTime = $bookings[$i]["startDate"];
        $bookEndTime = $bookings[$i]["endDate"];

        if ($startDate >= $bookStartTime  && $startDate <=$bookEndTime)
        {
          $result = "FALSE";
          return $result;
        }
        if ($endDate >= $bookStartTime  && $endDate <= $bookEndTime)
        {
          $result = "FALSE";
          return $result;

        }
      }
    }
    return $result;

  }

  //func to get all the bookings/My Meeting
  function getAllBookings($userID){
    $query = $this->db->query("SELECT bookings.*,buildings.name as buildingName, buildings.id as buildingID ,rooms.name as roomName,rooms.floorNumber , rooms.type  from bookings join rooms on rooms.roomId = bookings.roomID join buildings on buildings.id = rooms.buildingId where userID = $userID");

    if($query->num_rows()>0)
    {
      $response['status'] = 'success';
      $response['data']=$this->getParticipantsForMeetings($query->result_array());
    }
    else
    {
      $response['status'] = 'failure';
      $response['code'] = 'database failure';

    }
    return $response;
  }

  //func to get booked meetings invites/participants
  function getParticipantsForMeetings($array)
  {
    $result = array();
    for ($i=0; $i < count($array); $i++) {
      $bookingID = $array[$i]["id"];

      $obj = $array[$i];

      $query = $this->db->query("SELECT bookingID, users.* from booking_invitations  join users on users.id = booking_invitations.userID where bookingID = $bookingID");
      if($query->num_rows()>0)
      {
        $obj["users"] = $query->result_array();

      }
      else
      {
        $obj["users"] = array();

      }

      array_push($result, $obj);
    }

    return $result;
  }

  //func for adding new pics to photo gallery
  function updateRoomPics($roomID,$pictureurl){
    $add_data = array("roomID"=>$roomID,"url"=>$pictureurl);

    if ($this->db->insert('room_pictures', $add_data))
    {
      $response['status'] = 'success';
      $response['code'] = 'image uploaded Successfuly';

    }
    else
    {
      $response['status'] = 'failure';
      $response['code'] = 'database failure';

    }

    return $response;
  }

  // func to get all the photos of a room to show in the photo gallery of the app
  function geteRoomPics($roomID){
    $response = array();
    $query = $this->db->query("SELECT * FROM room_pictures  where roomID = $roomID");
    if($query->num_rows()>0)
    {
      $response['status'] = 'success';
      $response['data']=$query->result_array();

    }
    else
    {
      $response['status'] = 'failure';
      $response['code'] = 'database failure';

    }
    return $response;
  }

  //allows the usre to post a review/rating for a meeting room
  function postReview($roomID,$review,$rating,$userID,$userName){

    $response = array();
    $add_data = array("roomID"=>$roomID,"review"=>$review,"rating"=>$rating,"userID"=>$userID,"userName"=>$userName);

    if ($this->db->insert('room_reviews', $add_data))
    {
      $response['status'] = 'success';
      $response['code'] = 'added Successfuly';
      $roomQuery = $this->db->query("SELECT * FROM room_reviews  where roomID = $roomID");
      if($roomQuery->num_rows()>0)
      {
        $response['data']=$roomQuery->result_array();

      }
      else
      {
        $response['data']= array();
      }

    }
    else
    {
      $response['status'] = 'failure';
      $response['code'] = 'database failure';

    }

    return $response;

  }

  //function to return all the user reviews
  function getReviews($roomID){
    $response = array();

    $query = $this->db->query("SELECT * FROM room_reviews  where roomID = $roomID");
    if($query->num_rows()>0)
    {
      $response['status'] = 'success';
      $response['data']=$query->result_array();

    }
    else
    {
      $response['status'] = 'failure';
      $response['code'] = 'database failure';

    }
    return $response;

  }
}
