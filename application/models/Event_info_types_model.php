<?php 
if (!defined('BASEPATH'))
exit('No direct script access allowed');

class Event_info_types_model extends MY_Model
{
      var $id_col = 'event_info_type_id';
      var $fields = array(

      'name' => array(
            'type' => 'text',
            'label' => 'Nome',
            'rules' => 'required|min_length[4]',
            'label_class' => 'col-md-4',
            'prepend' => '<div class="col-md-8">',
            'append' => '</div>',
            'extra' => array('required' => 'required')
      ),

      'field_type' => array(
            'type' => 'select',
            'label' => 'Tipo do Campo',
            'rules' => 'required',
            'values' => array("text"=>"Text","textarea"=>"Textarea","radio"=>"Radio","select"=>"Select","checkbox"=>"Checkbox"),
            'empty' => '--Selecine um status--',
      ),

      'field_values' => array(
            'type' => 'text',
            'label' => 'Valores do Campo',
            'rules' => 'required|min_length[4]',
            'label_class' => 'col-md-4',
            'prepend' => '<div class="col-md-8">',
            'append' => '</div>',
            'extra' => array('required' => 'required')
      ),

    );     
}