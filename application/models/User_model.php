<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class User_model extends MY_Model
{
	var $id_col = 'user_id';
    var $fields = array(

        'name' => array(
            'type' => 'text',
            'label' => 'Nome',
            'rules' => 'required|min_length[8]',
            'extra' => array('required' => 'required')
        ),

        'username' => array(
            'type' => 'text',
            'label' => 'Usuário',
            'rules' => 'required|min_length[4]|callback_uniqlogin',
            'extra' => array('required' => 'required')
        ),

        'email' => array(
            'type' => 'text',
            'label' => 'Email',
            'rules' => 'required|valid_email|callback_uniqEmail',
            'extra' => array('required' => 'required')
        ),

        'password' => array(
            'type' => 'password',
            'label' => 'Senha',
            'rules' => 'required|min_length[4]',
            'extra' => array('required' => 'required')
        ),

        'status' => array(
            'type' => 'select',
            'label' => 'Status',
            'rules' => 'required',
            'values' => array("enable"=>"Ativo","desable"=>"Inativo"),
            'empty' => '--Selecine um status--',
        ),

        'user_type_id' => array(
            'type' => 'select',
            'label' => 'Perfil',
            'rules' => 'required',
            'values' => array(),
            'empty' => '--Selecine um perfil--',
            'from' => array('model' => 'user_types', 'value' => 'label')
        ),
    );
	
    public function beFriends($user_id, $friend_id) 
    {
        $this->db->insert('friends', array('user_id' => $user_id, 'friend_id' => $friend_id));
        $this->db->insert('friends', array('friend_id' => $user_id, 'user_id' => $friend_id));
    }

    public function canRequestChef($user_id) 
    {
        $where_usuario = array('user_id' => $user_id, 'user_type_id' => 2);
        $user = $this->get_where($where_usuario)->row();
        if(!$user){

            $this->db->where("user_id",$user_id);
            $resultadoVerificacao = $this->db->get("friends");


            if($resultadoVerificacao->num_rows() >= 20){
               
                $info = $this->db->where(array('user_id' => $user_id, 'info_key' => 'requestChef', 'info_value' => 'admin'))->get('user_info')->row();
                if(!$info){
                    $output = array('status' => 'yes');
                } else {
                    $output = array('status' => 'no', 'msg' => 'Você já fez sua solicitação, aguarde nossa análise.');
                }

            }else{
                $output = array('status' => 'no', 'msg' => 'Você precisa ter 20 amigos convidados para virar um chefe');
            }
        } else {
            $output = array('status' => 'no', 'msg' => 'Você já é um Chef, acesse o site para criar seus eventos.');
        }
        return $output;
    }

}


