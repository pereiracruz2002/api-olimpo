<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Solicitacoes extends CI_Controller
{
    public function index() 
    {
      $this->load->model("User_info_model","info");

      $resultado = $this->info->getRequestsChefs();

      $dados["listagem"] = $resultado;

      $this->load->view('administrativo/solicitacoes',$dados);
    }

}
