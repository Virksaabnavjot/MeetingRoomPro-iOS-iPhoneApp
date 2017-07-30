<?php defined('BASEPATH') OR exit('No direct script access allowed');

/**
*@author : Navjot Singh Virk
*File: rooms.php
*Purpose: handles room related operations
*Project: MRPro
*Github: https://github.com/mrpro/
*Copyrights 2017-2018
**/


class Rooms extends REST_Controller {

  public function __construct()
  {
    parent::__construct();
    $this->load->model('rooms_model');
  }


  //getting all room data at a given building id
  function allRooms_post()
  {

    $response = array();

    $buildingID = $this->post('buildingID');

    $response= $this->rooms_model->allRooms($buildingID);

    $this->response($response,200);
  }

  //handles room booking
  function bookRoom_post(){

    $response = array();
    $roomID = $this->post("roomID");
    $title = $this->post("title");
    $userID = $this->post("userID");
    $startDate = $this->post("startDate");
    $endDate = $this->post("endDate");
    $otherUsers = $this->post("users");
    $response= $this->rooms_model->bookRooms($roomID,$title,$userID,$startDate, $endDate,$otherUsers);

    $this->response($response,200);
  }

  //return all room bookings/My meetings
  function getAllBookings_post()
  {
    $response=array();
    $userID = $this->post("userID");
    $response =  $this->rooms_model->getAllBookings($userID);
    $this->response($response,200);

  }

  //helps add/upload images to the galley
  function room_image_post(){

    $response=array();
    $this->load->helper('string');
    $roomID = $this->post('roomID');
    $config['upload_path'] = './uploads/';   // configure the path. we have an upload folder use that folder to upload data. All the images are poseted there
    $config['allowed_types'] = 'jpg|jpeg|png';
    $config['max_size'] = '0';
    $config['max_width'] = '0';
    $config['max_height'] = '0';
    $config['encrypt_name'] = TRUE;

    //Load upload library and initialize configuration

    $this->load->library('upload',$config);
    $this->upload->initialize($config);

    if (!($this->upload->do_upload('picture'))) {
      // picture is the kye against which data is sent on server.
      //if the image does not exist against this key throw an error

      $response['status'] = 'failure';

      $error = array('error' => $this->upload->display_errors());

      $response['code'] = $error;

      $this->response($response, 200);
    }

    else
    {
      $fileData = $this->upload->data();

      $this->load->helper('url');

      $pictureurl = 'uploads/' . $fileData['file_name'];


      $response= $this->rooms_model->updateRoomPics($roomID,$pictureurl);

    }

    $this->response($response,200);

  }

  //getting all the pics to show in photo gallery
  function getRoomsImage_post(){
    $response=array();

    $roomID = $this->post('roomID');
    $response= $this->rooms_model->geteRoomPics($roomID);
    $this->response($response,200);

  }

  //handles/post reviews for rooms
  function postReview_post()
  {
    $roomID = $this->post("roomID");
    $review= $this->post("review");
    $rating = $this->post("rating");

    $userID = $this->post("userID");
    $userName = $this->post("userName");

    $response= $this->rooms_model->postReview($roomID,$review,$rating,$userID,$userName);
    $this->response($response,200);

  }

  //handles/gets the user reviews for the room to show in user review feature of the app
  function getRoomReviews_post(){
    $response = array();
    $roomID = $this->post("roomID");
    $response= $this->rooms_model->getReviews($roomID);
    $this->response($response,200);

  }
}
