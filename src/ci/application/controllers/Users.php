<?php
class Users extends CI_Controller {

        public function __construct()
        {
                parent::__construct();
                $this->load->model('users_model');
                $this->load->helper('url_helper');
        }

        public function view($id = NULL)
        {
           $data['user'] = $this->users_model->get_users($id);

           if (empty($data['user']))
           {
                show_404();
           }

           $data['title'] = $data['user']['title'];

           $this->load->view('templates/header', $data);
           $this->load->view('users/view', $data);
           $this->load->view('templates/footer');
        }
        
        public function index()
        {
           $data['users'] = $this->users_model->get_users();
           $data['title'] = 'Users list';

           $this->load->view('templates/header', $data);
           $this->load->view('users/index', $data);
           $this->load->view('templates/footer');
        }
        
        
}