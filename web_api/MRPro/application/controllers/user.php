<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
*@author : Navjot Singh Virk
*File: user.php
*Purpose: handles user login and registration operations
*Project: MRPro
*Github: https://github.com/mrpro/
*Copyrights 2017-2018
**/

class User extends REST_Controller {

	function __construct()
	{
		parent::__construct();
		$this->load->model('user_model');
	}

	// test: just for testing purpose that database is connected or not
	function test_post(){
		$this->response("ok",200);
	}

	// sign up as well as update user api
	function postUser_post()
	{
		$response=array();
		$this->load->helper('string');
		$email=$this->post("email");
		$password = $this->post("password");
		$phone = $this->post("phone");
		$name=$this->post("name");
		$deviceToken=$this->post("deviceToken");

		$userID = $this->post('userID'); // if userID exists take this as an update request

		if(!$email)
		{
			$response['status']='failure';
			$response['code']='Email Missing';
		}
		else if(!$password)
		{
			$response['status']='failure';
			$response['code']='Password Missing';
		}

		else if (!$phone) {

			$response['status']='failure';
			$response['code']='phone Missing';
		}
		else if (!$name) {

			$response['status']='failure';
			$response['code']='name Missing';
		}

		else
		{

			$code= random_string('alnum', 5);
			if (!$deviceToken) {
				$deviceToken='SIMULATOR';
			}

			$config['upload_path'] = './uploads/';
			$config['allowed_types'] = 'jpg|jpeg|png';
			$config['max_size'] = '0';
			$config['max_width'] = '0';
			$config['max_height'] = '0';
			$config['encrypt_name'] = TRUE;

			//Load upload library and initialize configuration

			$this->load->library('upload',$config);
			$this->upload->initialize($config);

			if (!($this->upload->do_upload('picture'))) {
				$pictureurl = "";
				$response= $this->user_model->postUser($name,$email,$password,$phone,$deviceToken,$pictureurl);

			}

			else
			{
				$fileData = $this->upload->data();

				$this->load->helper('url');

				$pictureurl = 'uploads/' . $fileData['file_name'];


				$response= $this->user_model->postUser($name,$email,$password,$phone,$deviceToken,$pictureurl);

			}
		}

		$this->response($response,200);
	}

  //handles updating user data
	function updateUser_post(){

		$response=array();
		$this->load->helper('string');
		$userID = $this->post('userID');
		$name=$this->post("name");
		$deviceToken=$this->post("deviceToken");

		$userID = $this->post('userID'); // if userID exists take this as an update request

		if(!$userID)
		{
			$response['status']='failure';
			$response['code']='userID Missing';
		}


		else if (!$name) {

			$response['status']='failure';
			$response['code']='name Missing';
		}

		else
		{

			$code= random_string('alnum', 5);
			if (!$deviceToken) {
				$deviceToken='SIMULATOR';
			}

			$config['upload_path'] = './uploads/';
			$config['allowed_types'] = 'jpg|jpeg|png';
			$config['max_size'] = '0';
			$config['max_width'] = '0';
			$config['max_height'] = '0';
			$config['encrypt_name'] = TRUE;

			//Load upload library and initialize configuration

			$this->load->library('upload',$config);
			$this->upload->initialize($config);

			if (!($this->upload->do_upload('picture'))) {

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


				$response= $this->user_model->updateUser($name,$userID,$deviceToken,$pictureurl);

			}
		}

		$this->response($response,200);
	}

	//handles user sign in
	function signIn_post()
	{
		$response=array();
		$email=$this->post("email");
		$password = $this->post("password");

		if(!$email)
		{
			$response['status']='failure';
			$response['code']='Email Missing';
		}
		else if(!$password)
		{
			$response['status']='failure';
			$response['code']='Password Missing';
		}
		else
		{

			$response= $this->user_model->signIn($email,$password);

		}

		$this->response($response,200);
	}

	function getUsers_post(){
		$response = array();
		$userID = $this->post("userID");
		$response = $this->user_model->findUSersWithID($userID);
		$this->response($response,200);

	}
}
