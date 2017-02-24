<?php 
if (!defined('BASEPATH'))
exit('No direct script access allowed');

class Event_infos_model extends MY_Model
{
	var $id_col = 'event_info_id';
	var $fields = array(

      'event_id' => array(
            'type' => 'text',
            'label' => 'Campo',
            'rules' => 'required',
            'label_class' => 'col-md-4',
            'prepend' => '<div class="col-md-8">',
            'append' => '</div>',
            'extra' => array('required' => 'required')
      ),

      'event_info_type_id' => array(
            'type' => 'text',
            'label' => 'Campo',
            'rules' => 'required',
            'label_class' => 'col-md-4',
            'prepend' => '<div class="col-md-8">',
            'append' => '</div>',
            'extra' => array('required' => 'required')
      ),


      'info_value' => array(
            'type' => 'text',
            'label' => 'Campo',
            'rules' => 'required',
            'label_class' => 'col-md-4',
            'prepend' => '<div class="col-md-8">',
            'append' => '</div>',
            'extra' => array('required' => 'required')
      ),


    );

	
}