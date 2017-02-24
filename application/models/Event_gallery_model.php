<?php 
if (!defined('BASEPATH'))
exit('No direct script access allowed');

class Event_gallery_model extends MY_Model
{
	var $id_col = 'event_gallery_id';
	var $fields = array(

      'event_id' => array(
            'type' => 'text',
            'label' => 'Evento',
            'rules' => '',
            'label_class' => 'col-md-4',
            'prepend' => '<div class="col-md-8">',
            'append' => '</div>',
            'extra' => array('required' => 'required')
      ),

       'picture' => array(
            'type' => 'text',
            'label' => 'Imagem',
            'rules' => '',
            'label_class' => 'col-md-4',
            'prepend' => '<div class="col-md-8">',
            'append' => '</div>',
            'extra' => array('required' => 'required')
      ),

    );

	
}