<?php

class Painel extends My_Controller{
    
    function __construct() {
        parent::__construct();
    }
    
    function index(){
        $this->load->view('administrativo/painel',$this->data);
    }
}
