<?php
class News extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('news_model');
        $this->load->helper('url_helper');
    }

    public function view($slug = null)
    {
        $slug = urldecode($slug);
        $data['news_item'] = $this->news_model->get_news($slug);

        if (empty($data['news_item'])) {
            show_404();
        }

        $data['title'] = $data['news_item']['title'];

        $this->load->view('templates/header', $data);
        $this->load->view('news/view', $data);
        $this->load->view('templates/footer');
    }

    public function index()
    {
        $data['news'] = $this->news_model->get_news();
        $data['title'] = 'News archive';

        $this->load->view('templates/header', $data);
        $this->load->view('news/index', $data);
        $this->load->view('templates/footer');
    }

    public function create()
    {
        $this->load->helper(array('form', 'url'));
        $this->load->library('form_validation');

        $data['title'] = 'Create a news item';

        $this->form_validation->set_rules('title', 'タイトル', 'required');
        $this->form_validation->set_rules('content', '本文', 'required',
       array('required' => '%s は必須です。'));

        if ($this->form_validation->run() === false) {
            $this->load->view('templates/header', $data);
            $this->load->view('news/create');
            $this->load->view('templates/footer');
        } else {
            $data['title'] = $this->input->post('title');
            $this->news_model->set_news();
            $this->load->view('news/success', $data);
        }
    }
}
