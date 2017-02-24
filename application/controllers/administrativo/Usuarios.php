<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
include_once(dirname(__FILE__).'/BaseCrud.php');

class Usuarios extends BaseCrud
{
	var $modelname = 'user'; /* Nome do model sem o "_model" */
	var $base_url = 'administrativo/usuarios';
	var $actions = 'CRUD';
	var $acoes_extras = array(); //array("url" => "methodo do controller", "title" => "texto que aparece", "class" => "classe do link")
	var $acoes_controller = array(); //array("url" => "methodo do controller", "title" => "texto que aparece", "class" => "classe do link")
	var $titulo = 'Usuários';
	var $tabela = 'name,username,email,status';
	var $campos_busca = 'email';
	var $joins = array('user_types' => 'user_types.user_type_id=user.user_type_id');

  public function __construct()
  {    

    parent::__construct();
  }

  public function index()
  {
    $this->listar();
  }


  public function admins()
  {
    $this->titulo = "Administradores";
    $this->index();
  }

  public function chefs()
  {
    $this->titulo = "Chefes";
    $this->index();

  }

  public function users()
  {
    $this->titulo = "Usuários";
    $this->index();
  }

  public function _filter_pre_form(&$data) 
  {

    if($this->uri->segment(3) == 'editar'){
      $data[0]['values']['password'] = $this->encrypt->decode($data[0]['values']['password']);
    }
  }


  public function _filter_pre_listar(&$where, &$where_ativo)
  {
    if($this->uri->segment(3)=="admins"){
      $where['user.user_type_id'] = 1;
    }elseif ($this->uri->segment(3)=="chefs"){
      $where['user.user_type_id'] = 2;
    }else{
      $where['user.user_type_id'] = 3;
    }
  }

  
  public function _filter_pre_save(&$data) 
  {
    $this->load->library('encrypt');
    if(isset($data['password']))
      $data['password'] = $this->encrypt->encode($data['password']);
  }


  public function _filter_pre_read(&$data)
  {
    foreach ($data as $key) {
      if($key->status=="enable")
        $key->status = "Habilitado";
      else
        $item->status = "Desabilitado";
      }
  }

  public function uniqlogin($username) 
  {
    $where['username'] = $username;
    if($this->uri->segment(3) == 'editar'){
      $where['user_id !='] = $this->uri->segment(4);
    }
    $cadastro = $this->model->get_where($where)->row();

    if($cadastro){
      $this->form_validation->set_message('uniqlogin', 'Esse login já está em uso');
      return false;
    } else {
      return true;
    }
  }


  public function uniqEmail($email) 
  {

    $where['email'] = $email;
    if($this->uri->segment(3) == 'editar'){
      $where['user_id !='] = $this->uri->segment(4);
    }
    $cadastro = $this->model->get_where($where)->row();

    if($cadastro){
      $this->form_validation->set_message('uniqEmail', 'Esse email já está em uso');
      return false;
    } else {
      return true;
    }
  }    

}
