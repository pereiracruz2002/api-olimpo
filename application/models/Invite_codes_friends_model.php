<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Invite_codes_friends_model extends My_Model
{
    var $id_col = 'invite_friends_id';

    public function __construct() 
    {
        parent::__construct();
        $this->load->library('email');
    }

    public function sendInvite($friend_data, $user_id) 
    {
        $save['email'] = $friend_data['email'];
        $validation = $this->get_where($save)->row();
        if(!$validation){
            $save['code'] = rand(10000000, 99999999);
            $msg = "<h1>Convite de partição Chef Amigo</h1>";
            $msg.= "<p>".$save['nome'].", venha participar da minha rede de amigos do Dinner4Friends <strong>Codigo:</strong>".$save['code']."</p>";

            $this->email->from(EMAIL_FROM, 'Convite de partição Chef Amigo');
            $this->email->to($friend_data['email']);
            $this->email->subject('Convite de partição Dinner4Friends');
            $this->email->message($msg);
            if($this->email->send()){
                $save['status'] = 'pending';
                $save['email'] = $friend_data['email'];
                $save['user_id'] = $user_id;
                $this->save($save);
                return true;
            }
        }
        return false;
    }
}
