<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Evento extends CI_Controller
{
    var $latitude;
    var $longitude;

    public function __construct() 
    {
        parent::__construct();
        $this->output->set_header('Access-Control-Allow-Origin: *');
    }

    public function index() 
    {
        $this->load->model('user_model','users');
        $where = array('email' => $this->input->post('email'), 'status' => 'enable','user_type_id' => 2);
        $user = $this->users->get_where($where)->row();
        if($user and $this->encrypt->decode($user->password) == $this->input->post('senha')){
            unset($user->password);
            $this->session->set_userdata('user', $user);
            $output = array('status' => 'ok', 'token' => base64_encode($this->encrypt->encode($user->user_id)));
        } else {
            $output = array('status' => 'erro', 'msg' => 'Usuário não encontrado');
        }

        $this->output->set_content_type('application/json')
                     ->set_output(json_encode($output));
    }

    public function getTypes()
    {
        $this->load->model('event_types_model','types');
        $this->db->where('private','0');
        $types = $this->types->get_all()->result();
        $this->output->set_content_type('application/json')
                     ->set_output(json_encode($types));
    }


    public function getEventsPublic($event_type_id)
    {
        $this->load->model('events_model','events');
        $this->db->select('events.event_id,events.name, events.city,DATE_FORMAT(events.start,"%h:%i") as start,DATE_FORMAT(events.end,"%h:%i") as end,events.neighborhood,CONCAT("'.SITE_URL.'uploads/", events.picture) as picture,event_types.name as category');
        $this->db->join("event_types","event_types.event_type_id = events.event_type_id");
        $where = array("events.event_type_id"=>$event_type_id,"status"=>"enable","event_types.private"=>0);
        $this->db->where($where);
        $events = $this->events->get_all()->result();

        $this->output->set_content_type('application/json')
                     ->set_output(json_encode($events));  
    }

    public function getTypesPublic()
    {
        $where = array('event_types.private'=>0);
        if(!empty($this->input->posts())){

            $estado = $this->input->post('estado');
            $cidade = $this->input->post('cidade');
            if($estado != "undefined" && $cidade != "undefined"){
                $where['events.state'] = $estado;
                $where['events.city'] = $cidade;
            }
            
        }
        $this->load->model('event_types_model','types');
        $this->db->select('event_types.event_type_id,event_types.name,event_types.image_type,COUNT(event_types.event_type_id) as qtd');
        $this->db->join("events","events.event_type_id = event_types.event_type_id");
        $this->db->where($where);
        $types = $this->types->get_all()->result();

        $this->output->set_content_type('application/json')
                     ->set_output(json_encode($types));
    }



    public function getInfoTipoEventos()
    {
        $this->load->model('event_info_types_model','typesInfo');
        $this->data['fieldsOptions'] = $this->typesInfo->get_all()->result();
        //$output['html'] = $this->typesInfo->get_all()->result();
        //$output['html'] = html_compress($this->load->view('fields/layout_fields', $this->data, true));
        
        $this->db->select("event_info_types.*,
                           CONCAT('event_info_type_id_',event_info_types.event_info_type_id) as namefields");

        $output['html'] = $this->typesInfo->get_all()->result();
        $this->output->set_content_type('application/json')
                     ->set_output(json_encode($output));
    }

    public function listaEventos()
    {
        $this->load->model('events_model','events');
        $user_id = $this->encrypt->decode(base64_decode($this->input->post('token')));

        $this->db->select("*");
        $this->db->from("events");
        $this->db->order_by('event_id', 'DESC');
        $output = $this->events->where('user_id',$user_id)
                               ->or_where('private', 0)
                               ->get()
                               ->result();

        $this->output->set_content_type('application/json')
                     ->set_output(json_encode($output));
    }

    public function novo()
    {
        $this->load->model('event_infos_model','event_info');
        $this->load->model('events_model','event');
        $this->load->model('event_gallery_model','gallery');
        $post = $this->input->posts();
        $gallery = array();
        $event_info = array();
        if (!empty($post)) {

            foreach($post['fields'] as $chave => $valor){
                $event_info_type_id = explode('_',$chave);
                $indice = end($event_info_type_id);
                $event_info[$indice] = $valor;
                unset($post['fields']);
            }
   
            if(isset($post['pictures'])){
                foreach($post['pictures'] as $fotos){
                    if($fotos['principal']=="sim"){
                        $post['picture'] = $fotos['href'];
                    }else{
                        $gallery[] = $fotos['href'];
                    }
                }
            }


            $post['user_id'] = $this->encrypt->decode(base64_decode($this->input->post('user_id')));
            unset($post['pictures']);
            unset($post['zipcode']);

            if ($this->event->validar()) {

                $dadosEndereco = $post['street'].' ,'.$post['neighborhood'].','.$post['city'].','.$post['state'];
                $this->getCoordenada($dadosEndereco);

                $post['latitude'] = $this->latitude;
                $post['longitude']= $this->longitude;
                $post['start'] = date('Y-m-d', strtotime($this->input->post('start'))).' '.$this->input->post('start_hour').':00';
                unset($post['start_hour']);

                $id_event = $this->event->save($post);


                if($gallery){
                    foreach($gallery as $outrasFotos){
                        $salvaGaleria = array();
                        $salvaGaleria['event_id'] = $id_event;
                        $salvaGaleria['picture'] = $outrasFotos;
                        $this->gallery->save($salvaGaleria);
                    }
                }
                
                foreach($event_info as $event_info_type_id => $info_value){
                     $salvarInEventinfos = array();
                     $salvarInEventinfos['event_id']           = $id_event;
                     $salvarInEventinfos['event_info_type_id'] = $event_info_type_id;
                     $salvarInEventinfos['info_value']         = $info_value;
                     $event_info_id = $this->event_info->save($salvarInEventinfos);
                }
               
                $output = array('status' => 'ok', 'msg' => 'Cadastro Realizado com Sucesso');
            }else{
 
                 $errorMsg = validation_errors();

                 $output = array('status' => 'erro', 'msg' => $errorMsg);
            }
            
        } else {
            $output = array('status' => 'erro', 'msg' => 'Falha ao Cadastrar o Evento');
        }

        $this->output->set_content_type('application/json')
                     ->set_output(json_encode($output));
    }

    public function setImagemPrincipal() 
    {
        $user_id = $this->encrypt->decode(base64_decode($this->input->post('token')));
        $this->load->model('events_model','events');
        $where['event.event_id'] = $this->input->post('event_id');
        $where['event.user_id'] = $user_id;
        $set = array('picture' => str_replace(SITE_URL.'uploads/', '', $this->input->post('picture')));
        $event = $this->events->update($set, $where);
        $this->output->set_content_type('application/json')
            ->set_output(json_encode(array('status' => 'ok')));
    }

    public function deleteImg() 
    {
        $user_id = $this->encrypt->decode(base64_decode($this->input->post('token')));
        $this->load->model('events_model','events');
        $this->load->model('event_gallery_model','event_gallery');
        $where['event_gallery.event_gallery_id'] = $this->input->post('event_gallery_id');
        $where['events.user_id'] = $user_id;

        $this->db->select('event_gallery.picture')
                 ->join('event_gallery', 'event_gallery.event_id=events.event_id');
        $event = $this->events->get_where($where);
        if($event){
            preg_match('/uploads\/.+/', $event->picture, $matches);
            $path = FCPATH.$matches[0];
            if(is_file($path)){
                unlink($path);
            }
            $this->event_gallery->delete($this->input->post('event_gallery_id'));
        }
        $this->output->set_content_type('application/json')
            ->set_output(json_encode(array('status' => 'ok')));

    }


    public function getCoordenada($address)
    {
        $address = str_replace(" ", "+", $address);

        $url = "https://maps.google.com/maps/api/geocode/json?sensor=false&address=$address";

        $response = file_get_contents($url);

        $json = json_decode($response,TRUE); //generate array object from the response from the web
        $this->latitude = $json['results'][0]['geometry']['location']['lat'];
        $this->longitude =$json['results'][0]['geometry']['location']['lng'];

        //return ($json['results'][0]['geometry']['location']['lat'].",".$json['results'][0]['geometry']['location']['lng']);
    }

    public function listaEventosParticipantes(){

        $id = $this->encrypt->decode(base64_decode($this->input->post('token')));

        $this->db->select("user.*,event_guests.*,events.private");
        $this->db->from("event_guests");
        $this->db->join("user","event_guests.user_id = user.user_id");
        $this->db->join("events","events.event_id = event_guests.event_id");
        $this->db->where("event_guests.user_id",$id);
        $this->db->or_where("events.private",0);
        $resultado = $this->db->get();

        $output['status'] = "sucesso";
        $output["eventos"] = $resultado->result();

        $this->output->set_content_type('application/json')
                     ->set_output(json_encode($output));
    }

    public function usuario($token,$event_type_id)
    {
        $this->load->model('event_guests_model','event_guests');

        $user_id = $this->encrypt->decode(base64_decode($token));
        $this->db->select("events.*,
                           date_format(events.start,'%d-%m-%Y  %H:%i') as start,
                           date_format(events.end,'%d-%m-%Y  %H:%i') as end,
                           events.event_id as eventId,
                           (SELECT COUNT(*) FROM event_guests WHERE event_id = eventId) as total_guests,
                           (SELECT COUNT(*) FROM event_guests WHERE event_id = eventId AND status = 'confirmed') as total_confirmed,
                           DATE_FORMAT(events.start, '%d/%m/%Y %H:%i') as data,
                           CONCAT('".SITE_URL."uploads/', events.picture) as picture,
                           event_types.name as event_type
                           ")
                ->from("event_guests")
                 ->join("events","events.event_id =event_guests.event_id", 'right')
                 ->join("event_types","event_types.event_type_id=events.event_type_id")
                 ->order_by('events.start', 'asc');

        $where = array("event_types.event_type_id"=>$event_type_id);

        //$this->db->where("event_guests.user_id",$user_id);

        $this->db->where($where);

        $this->db->where("(event_guests.user_id = $user_id OR events.private = 0)",null,false);

        $output = $this->db->get()->result();


        $this->output->set_content_type('application/json')
             ->set_output(json_encode($output));
    }


    public function categoriasEventosUsuario($token)
    {
        $this->load->model('event_guests_model','event_guests');

        $user_id = $this->encrypt->decode(base64_decode($token));
        $this->db->select("event_types.event_type_id,
                           event_types.name, 
                           CONCAT('".SITE_URL."uploads/', event_types.img) as img,
                           COUNT(event_types.event_type_id) as total,
                           event_types.plural
                           ")
                 ->from("event_guests")
                 ->join("events","events.event_id =event_guests.event_id", 'right')
                 ->join("event_types","event_types.event_type_id=events.event_type_id")
                 ->group_by("event_types.event_type_id")
                 ->order_by('event_types.event_type_id', 'asc');

        $this->db->where("event_guests.user_id",$user_id);

        $this->db->or_where("events.private",0);

        $result = $this->db->get()->result();
        $output = array();
        foreach ($result as $item) {
            $item->descricao = 'Você foi convidado para '.$item->total.' '.($item->total > 1 ? $item->plural : $item->name);
            $output[] = $item;
        }

        $this->output->set_content_type('application/json')
             ->set_output(json_encode($output));
    }


    public function convidado($token)
    {
        $this->load->model('event_guests_model','event_guests');

        $user_id = $this->encrypt->decode(base64_decode($token));
        $this->db->select("events.event_id,
                           DATE_FORMAT(events.start, '%d/%m/%Y %H:%i') as data,
                           events.user_id as owner_id,
                           event_types.name as event_type
                           ")
                 ->select("(SELECT COUNT(*) FROM events JOIN event_guests ON event_guests.event_id=events.event_id WHERE events.user_id = owner_id AND event_guests.user_id = {$user_id} AND events.status = 'enable') as total_events", false)
                 ->select("(SELECT CONCAT('".SITE_URL."uploads/', user.picture) FROM user WHERE user.user_id = owner_id) as owner_picture", false)
                 ->select("(SELECT user.name FROM user WHERE user.user_id = owner_id) as owner_name", false)
                 ->join("user","event_guests.user_id = user.user_id")
                 ->join("events","events.event_id =event_guests.event_id")
                 ->join("event_types","event_types.event_type_id=events.event_type_id")
                 ->where('events.status', 'enable')
                 ->where_in('event_guests.status', array('invited', 'confirmed'))
                 ->group_by('events.user_id');
        $where = array("event_guests.user_id" => $user_id);

        $resultado = $this->event_guests->get_where($where)->result_array();

        $this->output->set_content_type('application/json')
             ->set_output(json_encode($resultado));
    }

    public function byUser() 
    {
        $owner_id = $this->input->post('owner_id');
        $user_id = $this->encrypt->decode(base64_decode($this->input->post('token')));
        $this->load->model('event_guests_model','event_guests');
        $this->db->select("events.*,
                           events.event_id as ID,
                           CONCAT('".SITE_URL."uploads/', events.picture) as picture,
                           DATE_FORMAT(events.start, '%d/%m/%Y %H:%i') as data,
                           events.user_id as owner_id,
                           ")
                 ->select("(SELECT CONCAT('".SITE_URL."uploads/', user.picture) FROM user WHERE user.user_id = owner_id) as owner_picture", false)
                 ->select("(SELECT CONCAT(user.name,' ',user.lastname) FROM user WHERE user.user_id = owner_id) as owner_name", false)
                 ->select("(SELECT COUNT(*) FROM event_guests WHERE event_guests.event_id = ID AND status = 'confirmed') as users_confirmed", false)
                 ->join("events","events.event_id =event_guests.event_id")
                 ->join("event_types","event_types.event_type_id=events.event_type_id")
                 ->where_in('event_guests.status', array('invited', 'confirmed'))
                 ->order_by('events.event_id', 'desc');
        $where = array("event_guests.user_id" => $user_id,  'events.user_id' => $owner_id);

        $resultado = $this->event_guests->get_where($where)->result_array();

        $this->output->set_content_type('application/json')
             ->set_output(json_encode($resultado));

    }


    public function curriculum($chef_id)
    {
        $this->load->model('user_info_model','info');
        
        $this->db->select("user_info.info_key,
                           user_info.info_value,
                           user.email,user.name, 
                           CONCAT('".SITE_URL."uploads/', user.picture) as picture,
                           user.lastname");
        $this->db->join("user","user.user_id=user_info.user_id");
        $where = array('user_info.user_id' => $chef_id);
        $resultado = $this->info->get_where($where);
        $output = $resultado->result();

        $this->output->set_content_type('application/json')
             ->set_output(json_encode($output));
    }

    
    public function info($event_id) 
    {
        $this->load->model('events_model','events');
        $where = array('events.event_id' => $event_id);


        $this->db->select("events.*,
                           DATE_FORMAT(events.start, '%d/%m/%Y') as data_inicio,
                           DATE_FORMAT(events.start, '%H:%i') as hora_inicio,
                           event_types.name as tipo,
                           CONCAT('".SITE_URL."uploads/', events.picture) as picture,
                           user_event.name as owner_name,
                           user_event.user_id as owner_id,
                           CONCAT('".SITE_URL."uploads/', user_event.picture) as owner_picture,
                           event_infos.event_info_id,
                           event_infos.info_value,
                           event_info_types.name as info_key,
                           event_info_categories.event_info_category_id as info_category_id,
                           event_info_categories.title as info_category_title,
                           event_guests.event_guest_id, 
                           event_guests.user_id as guest_id, 
                           event_guests.status as guest_status, 
                           guests.name as guest_name,
                           CONCAT('".SITE_URL."uploads/', guests.picture) as guest_picture,
                           event_gallery.event_gallery_id,
                           CONCAT('".SITE_URL."uploads/', event_gallery.picture) as gallery_picture,
                           event_comments.event_comment_id,
                           event_comments.comment,
                           DATE_FORMAT(event_comments.datetime, '%d/%m/%Y %H:%i') as comment_datetime,
                           user_comment.user_id as user_comment_id,
                           user_comment.name as user_comment_name,
                           CONCAT('".SITE_URL."uploads/', user_comment.picture) as comment_picture,
                          ")
                 ->join('event_types','event_types.event_type_id=events.event_type_id')
                 ->join('user as user_event', 'user_event.user_id=events.user_id')
                 ->join('event_infos', 'event_infos.event_id=events.event_id', 'left')
                 ->join('event_info_types', 'event_info_types.event_info_type_id=event_infos.event_info_type_id', 'left')
                 ->join('event_info_categories', 'event_info_types.event_info_category_id=event_info_categories.event_info_category_id', 'left')
                 ->join('event_guests', 'event_guests.event_id=events.event_id', 'left')
                 ->join('user as guests', 'guests.user_id=event_guests.user_id', 'left')
                 ->join('event_gallery', 'event_gallery.event_id=events.event_id', 'left')
                 ->join('event_comments', 'event_comments.event_id=events.event_id', 'left')
                 ->join('user as user_comment', 'user_comment.user_id=event_comments.user_id', 'left')
                 ->order_by('event_info_categories.event_info_category_id', 'asc');
                
        $event_data = $this->events->get_where($where)->result_array();


        $output = array();
        $confirmed=0;
        foreach ($event_data as $item) {
            if(!$output){
                $output = $item;
                $output['extra'] = array();
                $output['guests'] = array();
                $output['pictures'] = array();
                $output['comments'] = array();
            }

            if($item['info_key']){
                $output['extra'][$item['info_category_id']]['title'] = $item['info_category_title'];
                $output['extra'][$item['info_category_id']]['values'][$item['info_key']] = $item['info_value'];
            }

            if($item['guest_name']){
                if($item['guest_status'] == 'confirmed'){
                    $confirmed++;
                }
                $output['guests'][$item['guest_id']] = array('user_id' => $item['guest_id'], 
                                                             'name' => $item['guest_name'], 
                                                             'status' => $item['guest_status'],
                                                             'picture' => $item['guest_picture']
                                                         );
            }

            if($item['event_gallery_id'])
                $output['pictures'][$item['event_gallery_id']] = array('href' => $item['gallery_picture'], 'principal' => ($item['gallery_picture'] == $output['picture'] ? 1 : '0'));

            if($item['comment'])
                $output['comments'][$item['event_comment_id']] = array('user_id' => $item['user_comment_id'], 'name' => $item['user_comment_name'], 'date' => $item['comment_datetime'], 'comment' => $item['comment'], 'picture' => $item['comment_picture']);
        }

        $output['total_invites'] = $item['num_users'] - $confirmed;
        $output['invite_limit'] = (int) ($item['invite_limit'] ? $item['invite_limit'] : $output['total_invites']);

        rsort($output['comments']);
        unset($output['info_key'], $output['info_value'],
              $output['guest_name'], $output['guest_id'], $item['guest_status'], $item['guest_picture'], 
              $output['event_gallery_id'], $output['gallery_picture'],
              $output['user_comment_name'], $output['user_comment_id'], $output['comment_datetime'], $output['comment'], $output['comment_picture']
             );

        $this->output->set_content_type('application/json')
                     ->set_output(json_encode($output));

    }
    public function listaEventosDetalhes($evento){
        $this->load->model('event_infos_model','event_info');
        $this->load->model('events_model','event');

        $this->db->select("event_info_types.name,event_infos.info_value");
        $this->db->join("events","events.event_id=event_infos.event_id");
        $this->db->join("event_info_types","event_info_types.event_info_type_id=event_infos.event_info_type_id");
        $where = array("event_infos.event_id" => $evento);
        $resultado = $this->event_info->get_where($where);
        $output = $resultado->result();
        $this->output->set_content_type('application/json')
             ->set_output(json_encode($output));
    }


    public function getEventDetailPublic($evento){
        $this->load->model('events_model','events');
        $this->db->select('events.event_id,events.name,events.city,DATE_FORMAT(events.start,"%h:%i") as start,DATE_FORMAT(events.end,"%h:%i") as end,events.neighborhood,CONCAT("'.SITE_URL.'uploads/", events.picture) as picture');
        $this->db->join("event_types","event_types.event_type_id = events.event_type_id");
        $where = array("events.event_id"=>$evento,"status"=>"enable");
        $this->db->where($where);
        $events = $this->events->get_all()->row();

        $this->output->set_content_type('application/json')
                     ->set_output(json_encode($events));  
    }

    public function isConfirmed() 
    {
        $this->load->model('event_guests_model','event_guests');

        $user_id = $this->encrypt->decode(base64_decode($this->input->post('token')));
        $where['user_id'] = $user_id;
        $where['event_id'] = $this->input->post('event_id');
        $where['status'] = 'confirmed';
        $guest = $this->event_guests->get_where($where)->row();
        if($guest){
            $output = array('status' => true);
        } else {
            $output = array('status' => false);
        }
        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));
    }

    public function checkInviteFriendsForEvent(){

        $evento_id = $this->input->post("event_id");
       
        $user_id = $this->encrypt->decode(base64_decode($this->input->post("token")));

        $evento = $this->db->where("event_id",$evento_id)->get("events")->row();

        $quantidadeDeConvidadosPossiveisPorPessoa = $evento->invite_limit; 

        $limiteMaximoDePessoasNoEvento = $evento->num_users;

        $quantidadeJaConvidada = $this->db->where("event_id",$evento_id)->get("event_guests")->num_rows();


    if($limiteMaximoDePessoasNoEvento > $quantidadeJaConvidada){

        $this->db->select("user.*");
        $this->db->from("user");
        $this->db->join("friends","friends.friend_id = user.user_id");       
        $this->db->where("friends.friend_id not in (select user_id from event_guests where event_id = '".$evento_id."')",null,false);
        $this->db->where("friends.user_id",$user_id);
        $resultadoNaoConvidados = $this->db->get();

        $this->db->select("user.*");
        $this->db->from("user");
        $this->db->join("friends","friends.friend_id = user.user_id");       
        $this->db->where("friends.friend_id in (select user_id from event_guests where event_id = '".$evento_id."')",null,false);
        $this->db->where("friends.user_id",$user_id);
        $resultadoConvidados = $this->db->get()->num_rows();

        if($quantidadeDeConvidadosPossiveisPorPessoa > $resultadoConvidados){

            $quantidadeDisponiveisNoMomento = $quantidadeDeConvidadosPossiveisPorPessoa - $resultadoConvidados;

            $output = array(
                'status' => "success",
                'ConvitesDisponiveis' => $quantidadeDisponiveisNoMomento, 
                'ListagemDeAmigosNaoConvidados'=> $resultadoNaoConvidados->result()
                );

        }else{

            $output = array(
                'status' => "error",
                'msg' => "É permitido somente {$quantidadeDeConvidadosPossiveisPorPessoa} por participante" 
                );

        }


    }else{

        $output = array(
            'status' => "error",
            'msg' => "Este evento já alcançou o máximo de participantes" 
            );

    }


    $this->output->set_content_type('application/json')
        ->set_output(json_encode($output));

    }

    public function insertInvitedInEvent(){
        $amigos = $this->input->post("amigos");


        $evento = $this->db->where("event_id",$this->input->post("evento"))->get("events")->row();


        $limiteMaximoDePessoasNoEvento = $evento->num_users;

        $errors = 0;

        foreach ($amigos as $amigo) {


            $quantidadeJaConvidada = $this->db->where("event_id",$this->input->post("evento"))->get("event_guests")->num_rows();

            if($limiteMaximoDePessoasNoEvento > $quantidadeJaConvidada){
            
            $usuario = $this->db->where("user_id",$amigo)->get("user")->row();

            $this->db->insert("event_guests",array('event_id' => $this->input->post("evento")  ,'user_id' => $amigo));

                $output['inscrito'][] = $usuario; 


            }else{

                $usuario = $this->db->where("user_id",$amigo)->get("user")->row();

                $output["errors"][] = $usuario;
                $errors = $errors+1;

            }

        }

        if($errors == 0){ 

            $output["status"] = "sucesso";

        }else{
            $output["status"] = "erro";
            $output["msg"] = "evento Esgotado";
        }

         $this->output->set_content_type('application/json')
        ->set_output(json_encode($output));
    }

    public function invitedEmail(){

        $email = $this->input->post("email");

        $event_id = $this->input->post("event_id");

        $separaEmail = explode(",",$email);

        $user_id = $this->encrypt->decode(base64_decode($this->input->post("token")));

        $evento = $this->db->where("event_id",$event_id)->get("events")->row();

        //print_r($evento);

        $quantidadeDeConvidadosPossiveisPorPessoa = $evento->invite_limit; 

        $limiteMaximoDePessoasNoEvento = $evento->num_users;

        $erro = 0;

        foreach ($separaEmail as $item) {
            
            $quantidadeJaConvidada = $this->db->where("event_id",$event_id)->get("event_guests")->num_rows();


            if($quantidadeDeConvidadosPossiveisPorPessoa > $quantidadeJaConvidada){

                $codigo = rand(11111111,99999999);

                $dados = array(
                    'code' => $codigo,
                    'email' => $item,
                    'event_id' => $event_id
                );

                $this->db->insert("invite_codes",$dados);

                $de = "erley@wvtodoz.com.br";        
                $para = $email;    

                $msg = "<h1>Convite de partição Chef Amigo</h1>";
                $msg.="<p><strong>Codigo:</strong>".$codigo."</p>";

                $this->load->library('email');                   
                $this->email->from($de, 'Convite de partição Chef Amigo');                
                $this->email->to($para);                        
                $this->email->subject('Convite de partição Chef Amigo');  

                $this->email->message($msg);                     

                if($this->email->send()){

                    $output["enviado"][] = $item; 

                }else{
                    echo $this->email->print_debugger(); 
                    exit();

                    //$output["status"]="error";
                    //$output["msg"] = "Não foi possivel enviar e-mail no momento";
                }   

                
            }else{

                $erro = $erro + 1;

                $output["naoenvidados"][] = $item; 
               
            }


        }

        if($erro == 0){

            $output["status"] = "success";
            $output["msg"] = "convites enviados com successo";

        }else{

            $output["status"] = "error";
            $output["msg"] = "Não foi possivel enviar todos os convites, quantidade de convites não dispoível no momento";
        }

         $this->output->set_content_type('application/json')
        ->set_output(json_encode($output));
       
        

    }

    public function insertCommentForEvent(){

        $user_id = $this->encrypt->decode(base64_decode($this->input->post("token")));

        $event_id = $this->input->post("event_id");

        $comment = $this->input->post("comment");

        $datetime = date("Y-m-d H:i:s");

        $dadosInsert = array(
            'user_id' => $user_id,
            'event_id' => $event_id,
            'datetime' => $datetime,
            'comment' =>  $comment,
            'status' => "enable"
            );

        $this->db->insert("event_comments",$dadosInsert);

        $listagem = $this->db->select("user.*,event_comments.*")
        ->from("event_comments")
        ->join("user","event_comments.user_id=user.user_id")
        ->where("event_id",$event_id)
        ->get()->result();


        $output["status"] = "success";

        $output["comentarios"] = $listagem;

         $this->output->set_content_type('application/json')
        ->set_output(json_encode($output));


    }

    public function addEventGuest() 
    {
        $this->load->model('user_model','user');
        $this->load->model('invite_codes_model','invite_codes');
        $this->load->model('event_guests_model','event_guests');

        $this->db->join('events', 'events.event_id=invite_codes.event_id');
        $code = $this->invite_codes->get_where(array('invite_codes.code' => $this->input->post('code'), 'invite_codes.status' => 'pending'))->row();
        if($code){
            $user_id = $this->encrypt->decode(base64_decode($this->input->post('token')));
            $save_guest = array('event_id' => $code->event_id, 'user_id' => $user_id);
            if($this->event_guests->get_where($save_guest)->row()){
                $output = array('status' => 'error', 'title' => 'Atenção', 'msg' => 'Você já está na lista de convidados desse evento.');
            } else {
                $this->user->beFriends($user_id, $code->user_id);
                $this->invite_codes->update(array('status' => 'registered'), array('code' => $this->input->post('code')));
                $save_guest['status'] = 'invited';
                $this->event_guests->save($save_guest);
                $output = array('status' => 'success', 'title' => 'Parabéns', 'msg' => 'Você entrou na lista de convidados');
            }
        } else {
            $output = array('status' => 'error', 'title' => 'Atenção', 'msg' => 'Código não reconhecido.');
        }
        $this->output->set_content_type('application/json')
                     ->set_output(json_encode($output));
    }
}
