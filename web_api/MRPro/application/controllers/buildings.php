<?php defined('BASEPATH') OR exit('No direct script access allowed');

/**
*@author : Navjot Singh Virk
*File: buildings.php
*Purpose: handles building related operations
*Project: MRPro
*Github: https://github.com/mrpro/
*Copyrights 2017-2018
**/

class Buildings extends REST_Controller {

  public function __construct()
  {
    parent::__construct();
    $this->load->helper(array('form', 'url'));
    $this->load->model('buildings_model');
  }

  //get all available buildings
  function allBuildings_post()
  {
    $response= $this->buildings_model->allBuildings();
    $this->response($response,200);
  }

  //allows deletation
  function deleteBuildingWithId()
  {
    $response = array();


    $this->load->helper('string');

    $buildingId =$this->post("buildingId");

    if(!$buildingId)
    {
      $response['status']='failure';
      $response['code']='Building Id Missing';
    }
    else
    {
      $response= $this->buildings_model->deleteBuilding($buildingId);
    }

    $this->response($response,200);

  }

  //allows search
  function buildings_search_post()
  {
    $response = array();
    $text = $this->post('text');
    $response= $this->buildings_model->buildingsSearch($text); //call the method and pass the user search text
    $this->response($response,200);
  }

}
