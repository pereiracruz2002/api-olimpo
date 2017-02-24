<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Login extends CI_Controller
{
    public function index() 
    {

        $this->load->model('user_model','users');

        if($this->input->posts()){



            $where['username'] = $this->input->post('login');
            $where['status'] = 'enable';
            $where['user_type_id'] = 1;
            $admin = $this->users->get_where($where)->row();

    

            if($admin and $this->encrypt->decode($admin->password) == $this->input->post('senha')){
                unset($admin->password);
                $this->session->set_userdata('admin', $admin);
                
                redirect('administrativo/painel');
            }
        }

        $this->load->view('administrativo/login');
    }

    public function sair() 
    {
        $this->session->unset_userdata('admin');
        redirect('administrativo/login');
    }
}
