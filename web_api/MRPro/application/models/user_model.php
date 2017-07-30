<?php

/**
*@author : Navjot Singh Virk
*File: user_model.php
*Purpose: Handles User registration and login
*Project: MRPro
*Github: https://github.com/mrpro/
*Copyrights 2017-2018
**/

class User_model extends CI_Model
{

  function __construct() {
    parent::__construct();


  }

  //update user
  function   updateUser($name,$userID,$deviceToken,$pictureurl){

    $response = array();

    $query = $this->db->query("SELECT * FROM users WHERE id = $userID");

    if ($query->num_rows!=0) {
      # code...
      $add_data = array('name' =>$name, 'deviceToken'=>$deviceToken,"picture" => $pictureurl);
      $this->db->where('id', $userID);

      if ($this->db->update('users', $add_data)) {
        # code...

        $response['status'] = 'success';
        $response['data']=$this->findUSerWithID($userID);
      }

      else {

        $response['status'] = 'failure';
        $response['code']   = 'database failure';

      }
    }

    else
    {
      $response['status'] = 'failure';
      $response['code']   = 'No user against this credentials';
    }

    return $response;
  }


  // post user
  function postUser($name,$email,$password,$phone,$deviceToken,$picture) {
    $response = array();
    //fetches all the records from users table.
    $query = $this->db->get_where('users', array('email' => $email));

    if ($query->num_rows() == 0) {

      $query = $this->db->get_where('users', array('phone' => $phone));

      if ($query->num_rows() == 0) {
        $add_data = array('name' =>$name,'email' => $email, 'password' => $password ,'phone'=>$phone, 'deviceToken'=>$deviceToken,"picture" => $picture );

        if ($this->db->insert('users', $add_data)) {
          $userID=$this->db->insert_id();

          return $this->signIn($email,$password);

        } else {

          $response['status'] = 'failure';
          $response['code'] = 'database failure';
        }
      }
      else
      {
        $response['status'] = 'failure';
        $response['code'] = 'Account agaisnt this Mobile Number Already Exist Please Login';
      }
    }
    else
    {
      //meaningful error messages
      $response['status'] = 'failure';
      $response['code'] = 'Account agaisnt this Email Already Exist Please Login';

    }
    return $response;
  }

  //sign in
  function signIn($email,$password) {
    $response = array();

    //db query
    $query = $this->db->get_where('users', array('email' => $email , 'password' => $password)) ;

    if ($query->num_rows() == 0) {

      //meaningful error messages
      $response['status'] = 'failure';
      $response['code'] = 'Email or Password is Incorrect';

    }
    else
    {
      $query = $query->result_array();
      $data = $query[0];
      $id=$data['id'];

      //get dictionary on first index of query array
      $response['status'] = 'success';
      $response['data'] = $this->findUSerWithID($id);

    }
    return $response;
  }

  //func to find the user by their id and return data
  function findUSerWithID($userID){
    $query = $this->db->query("SELECT * FROM users WHERE id = $userID");
    $query = $query->result_array();
    $data = $query[0];

    return $data;

  }

  //creating a hash
  public function createhash($email) {
    return hash('sha512', $email . time());
  }

  //for uploading users profile picture
  function uploadPicture($userID,$data){
    $response=array();
    $this->db->where('id', $userID);
    $this->db->set('picture', $data);
    if (!$this->db->update('users')) {
      $response['status'] = 'failure';
      $response['code'] = 'database failure';

    }
    else
    {
      $response['status'] = 'success';
      $response['data']=$this->findUSerWithID($userID);
    }
    return $response;

  }

  function updateToken($deviceToken,$userID)
  {
    $this->db->where('id', $userID);
    $this->db->set('deviceToken', $deviceToken);
    $this->db->update('users');
    return "success";
  }

  function findUSersWithID($userID){
    $query = $this->db->query("SELECT * FROM users WHERE id != $userID");

    if ($query->num_rows() == 0) {
      $response['status'] = 'failure';
      $response['code'] = 'No User Exist';
    }
    else
    {
      //to get dictionary on first index of query array
      $response['status'] = 'success';
      $response['data'] =  $query->result_array();
    }
    return $response;
  }
}
