<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Events_model extends MY_Model
{
	var $id_col = 'event_id';
	var $fields = array(

      'user_id' => array(
            'type' => 'select',
            'label' => 'Usuário',
            'rules' => 'required',
            'values' => array(),
            'empty' => '--Selecine o dono do evento--',
            'from' => array('model' => 'user', 'value' => 'name')
      ),

	'start' => array(
            'type' => 'date',
            'label' => 'Data do Evento',
            'rules' => 'required|min_length[8]',
            'extra' => array('required' => 'required')
	),

    'name' => array(
            'type' => 'text',
            'label' => 'Titulo',
            'rules' => 'required|min_length[4]',
            'extra' => array('required' => 'required')
	),

    'event_type_id' => array(
            'type' => 'select',
            'label' => 'Tipo do Evento',
            'rules' => 'required',
            'values' => array(),
            'empty' => '--Selecine um perfil--',
            'from' => array('model' => 'event_types', 'value' => 'name')
    ),

	'num_users' => array(
            'type' => 'text',
            'label' => 'Número de Convidados',
            'rules' => 'required',
            'extra' => array('required' => 'required')
	),

	'price' => array(
            'type' => 'password',
            'label' => 'Preço',
            'rules' => 'required|min_length[2]',
            'extra' => array('required' => 'required')
	),

	'status' => array(
            'type' => 'select',
            'label' => 'Status',
            'rules' => '',
            'values' => array("enable"=>"Ativo","desable"=>"Inativo"),
            'empty' => '--Selecine um status--',
	),
      'zipcode' => array(
            'type' => 'text',
            'label' => 'CEP',
            'rules' => 'required',
            'extra' => array('required' => 'required')
      ),

      'street' => array(
            'type' => 'text',
            'label' => 'Endereço',
            'rules' => 'required|min_length[4]',
            'extra' => array('required' => 'required')
      ),

      'state' => array(
            'type' => 'text',
            'label' => 'Estado',
            'rules' => 'required|min_length[2]',
            'extra' => array('required' => 'required')
      ),

      'number' => array(
            'type' => 'text',
            'label' => 'Numero',
            'rules' => 'required',
            'extra' => array('required' => 'required')
      ),


      'city' => array(
            'type' => 'text',
            'label' => 'Cidade',
            'rules' => 'required|min_length[4]',
            'extra' => array('required' => 'required')
      ),

    
      'neighborhood' => array(
            'type' => 'text',
            'label' => 'Bairro',
            'rules' => 'required|min_length[4]',
            'extra' => array('required' => 'required')
      ),

      'latitude' => array(
            'type' => 'text',
            'label' => 'Latitude',
            'rules' => '',
            'extra' => array()
      ),

      'longitude' => array(
            'type' => 'text',
            'label' => 'Longitude',
            'rules' => '',
            'extra' => array()
      ),

      'description' => array(
            'type' => 'text',
            'label' => 'Descrição',
            'rules' => 'required|min_length[4]',
            'extra' => array('required' => 'required')
      ),

      'picture' => array(
            'type' => 'file',
            'label' => 'Foto Principal',
            //'rules' => 'callback_uploadImg[picture]',
            //'extra' => array('required' => 'required')
      ),

      'end_subscription' => array(
            'type' => 'date',
            'label' => 'Data Final de Cadastro',
            'rules' => 'required|min_length[8]',
            'extra' => array('required' => 'required')
      ),

      'invite_limit' => array(
            'type' => 'text',
            'label' => 'Foto Principal',
            'rules' => '',
            'extra' => array('required' => 'required')
      ),

      'private' => array(

            'type' => 'select',
            'label' => 'Privado',
            'rules' => '',
            'values' => array("Sim"=>"sim","Não"=>"não"),
            'empty' => '--Evento Privado?--',
      )





    );


	

	
}


