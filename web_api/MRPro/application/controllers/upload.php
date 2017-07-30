<?php defined('BASEPATH') OR exit('No direct script access allowed');

/**
*@author : Navjot Singh Virk
*File: upload.php
*Purpose: Handles image upload
*Project: MRPro
*Github: https://github.com/mrpro/
*Copyrights 2017-2018
**/

class Upload extends REST_Controller {

  public function __construct()
  {
    parent::__construct();
    $this->load->helper(array('form', 'url'));
  }

  //handles image upload
  function do_upload_post(){

    $config['upload_path']   = './upload/';
    $config['allowed_types'] = 'gif|jpeg|jpg|png';
    $config['max_size']      = '0';
    $config['max_width']     = '0';
    $config['max_height']    = '0';


    $this->load->library('upload',$config);

    if (![$this->upload->do_upload('fileNameKey')]) {
      # code...

      $error = array('error' => $this->upload->display_errors());

      $response['status'] = 'failure';
      $response['code']   = $error;

      $this->response($response,200);
    }

    else {

      $data = $this->upload->data();
      $this->load->helper('url');
      $fileNameKey = base_url('upload/'.$data['file_name']);


      $response['code'] = $fileNameKey;


      $this->insert($fileNameKey);

      $response['status'] = 'success';
      $this->response($response,200);
    }


    return $response;
  }

  function insert($fileNameKey){

    $this->db->query("INSERT into user (age) values('fileNameKey')");

  }


}
