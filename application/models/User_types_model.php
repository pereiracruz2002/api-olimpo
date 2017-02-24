<?php 
if (!defined('BASEPATH'))
exit('No direct script access allowed');

class User_types_model extends MY_Model
{
	var $id_col = 'user_type_id';
	var $fields = array(

      'name' => array(
            'type' => 'text',
            'label' => 'Campo',
            'rules' => 'required|min_length[8]',
            'label_class' => 'col-md-4',
            'prepend' => '<div class="col-md-8">',
            'append' => '</div>',
            'extra' => array('required' => 'required')
      ),

       'label' => array(
            'type' => 'text',
            'label' => 'Valor',
            'rules' => 'required|min_length[8]',
            'label_class' => 'col-md-4',
            'prepend' => '<div class="col-md-8">',
            'append' => '</div>',
            'extra' => array('required' => 'required')
      ),


      'user_type_id' => array(
            'type' => 'select',
            'label' => 'Perfil',
            'label_class' => 'col-md-4',
            'rules' => 'required',
            'prepend' => '<div class="col-md-8">',
            'append' => '</div>',
            'values' => array(),
            'empty' => '--Selecine um perfil--',
            'from' => array('model' => 'user_types', 'value' => 'label')
      ),

    );

	
}