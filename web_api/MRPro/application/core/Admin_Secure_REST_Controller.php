<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Admin_Secure_REST_Controller extends REST_Controller {

protected $admin;
protected $headers;
	function __construct(){
		parent::__construct();
		$this->headers = array();
		  foreach ($_SERVER as $k => $v)
		  {
			  if (substr($k, 0, 5) == "HTTP_")
			  {
				  $k = str_replace('_', ' ', substr($k, 5));
				  $k = str_replace(' ', '-', ucwords(strtolower($k)));
				  $this->headers[$k] = $v;
			  }
		  }
		
		if (@!$this->headers['Token'])
		{
			$r = array();
			$r['status'] = 'failure';
			$r['code'] = 'authentication parameters missing';

			$this->response($r, 200);
			exit;
		}
		else
		{
		
				$query = $this->db->get_where('admin', array('token' => $this->headers['Token']));
				if ($query->num_rows() == 0)
				{
				$r['status'] = 'failure';
				$r['code'] = 'please login first';
				$this->response($r, 200);
				exit;
				}
				else
				{
					$this->admin = $query->row();

				}

		}
			
	}
	
}