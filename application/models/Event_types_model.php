<?php 
if (!defined('BASEPATH'))
exit('No direct script access allowed');

class Event_types_model extends MY_Model
{
      var $id_col = 'event_type_id';
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

    );     
}