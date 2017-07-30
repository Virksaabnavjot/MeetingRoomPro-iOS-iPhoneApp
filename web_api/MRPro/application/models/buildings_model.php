<?php

/**
*@author : Navjot Singh Virk
*File: buildings_model.php
*Project: MRPro
*Purpose: Handles buildings information
*Github: https://github.com/mrpro/
*Copyrights 2017-2018
**/

class Buildings_model extends CI_Model
{

    function __construct() {
        parent::__construct();

    }

     //get all building informtion
    function allBuildings()
    {
        $response = array();
        //query
        $query = $this->db->query("SELECT id,name,city,country,floors,address,phone,email,location FROM buildings");
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

     //for deleting building data
    function deleteBuilding($buildingId)
    {
    	 $response = array();
    	 $query = $this->db->query("DELETE FROM buildings WHERE id = $buildingId");


    	 if($query->num_rows()>0)
        {
            $response['status'] = 'success';
            $response['code'] = 'Record Deleted Successfully';

        }
        else
        {
            $response['status'] = 'failure';
            $response['code'] = 'database failure';

        }
        return $response;


    }

    //allows to search building by their name, city or country
    function buildingsSearch($text)
    {
    	$response = array();
      //query - search building by their name, city or country
    	$query=$this->db->query("SELECT id,name, city, country,floors,address,phone,email from buildings where name like '%$text%' ||  city like '%$text%'  ||  country like '%$text%' ");

    	 if($query->num_rows()>0)
        {
            $response['status'] = 'success';
             $response['data']=$query->result_array();
        }
        else
        {
            $response['status'] = 'failure';
            $response['code'] = 'No building found';

        }
        return $response;
    }
}
