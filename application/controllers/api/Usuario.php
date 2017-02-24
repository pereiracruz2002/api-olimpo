<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

use Facebook\FacebookSession;
use Facebook\FacebookRequest;
use Facebook\FacebookRequestException;
use Facebook\GraphUser;



FacebookSession::setDefaultApplication(FB_ID, FB_SECRET);

class Usuario extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->output->set_header('Access-Control-Allow-Origin: *');
    }

    public function checkCode()
    {
        $this->load->model('invite_codes_model','invites_codes');
        $this->load->model('invite_codes_friends_model','invites_codes_friends');
        $where['code'] = $this->input->post('codigo');
        $where['status'] = 'pending';

        $output['invite'] = $this->invites_codes->get_where($where)->row();
        if($output['invite']){
            $output['status'] = 'success';
        } else {
            $where_friends['code'] = $this->input->post('codigo');
            $where_friends['status'] = 'pending';
            $output['invite'] = $this->invites_codes_friends->get_where($where_friends)->row();
            if($output['invite']){
                $output['status'] = 'success';
            }else{
                $output['status'] = 'error';
                $output['msg'] = 'Código não encontrado';
            }
        }
        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));

    }

    public function info()
    {
        $user_id = $this->encrypt->decode(base64_decode($this->input->post('token')));
        $this->load->model('user_model','user');
        $this->load->model('categories_model','categories');
        $this->db->select("user.user_id,
            user.username,
            user.email,
            user.name,
            CONCAT('".SITE_URL."uploads/', user.picture) as picture,
            user.facebook_id,
            user.user_type_id,
            user_info.info_key,
            user_info.info_value
            ")->join('user_info', 'user_info.user_id=user.user_id', 'left');
        $usuario = $this->user->get($user_id)->result_array();

        $output = array();
        foreach ($usuario as $item) {
            if(!$output){
                $output = $item;
            }
            if(!isset($output['extra'])){
                $output['extra'] = array();
            }
            if($item['info_key']){
                if($item['info_key'] == 'category_id'){
                    $this->db->select('name');
                    $category = $this->categories->get($item['info_value'])->row();
                    $output['extra']['especialidades'][] = $category->name;
                } else if($item['info_key'] == 'picture' or $item['info_key'] == 'cover'){
                    $output['extra'][$item['info_key']] = (strstr($item['info_value'], 'http') ? '' : SITE_URL.'uploads/').$item['info_value'];
                }else {
                    $output['extra'][$item['info_key']] = $item['info_value'];
                }
            }

            unset($output['info_key'], $output['info_value']);
        }

        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));
    }

    public function buscaAmigoEvento()
    {
        $convidado = $this->input->post("convidado");

        $evento = $this->input->post("evento");

        $this->db->select("user.*,event_guests.*");
        $this->db->from("user");
        $this->db->join("event_guests","event_guests.user_id = user.user_id");
        $this->db->where("event_guests.event_id",$evento);
        $this->db->where("event_guests.user_id",$convidado);
        $resultado = $this->db->get()->row();

        $output["status"] = "success";
        $output["usuario"] = $resultado;

        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));

    }




    public function lembrarSenha(){
        $email = $this->input->post("email");
        $buscaUser = $this->db->where("email",$email)->get("user");
        if($buscaUser->num_rows() > 0){
            $usuario = $buscaUser->row();
            $senhaCript = $usuario->password;
            $senha = $this->encrypt->decode($usuario->password);
            $de = "erley@wvtodoz.com.br";
            $para = $usuario->email;
            $msg = "<h1>Recuperação de senha Chef Amigo</h1>";
            $msg.="<p><strong>Senha:</strong>".$senha."</p>";

            $this->load->library('email');
            $this->email->from($de, 'Recuperação de senha');
            $this->email->to($para);
            $this->email->subject('Recuperação de senha Chef Amigo');
            $this->email->message($msg);
            if($this->email->send()){
                $output["status"]="success";
                $output["msg"] = "Sua senha foi enviada para o e-mail cadastrado";
            }else{
                //echo $this->email->print_debugger();
                //exit();

                $output["status"]="error";
                $output["msg"] = "Não foi possivel enviar e-mail no momento";
            }

        }else{
            $output["status"] = "error";
            $output["msg"] = "E-mail não encontrado no sistema";
        }

        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));

    }

    public function listagemUsuariosNaoConvidados(){

        $evento = $this->input->post("evento");
        $user_id = $this->encrypt->decode(base64_decode($this->input->post("token")));

        $this->db->select("user.*");
        $this->db->from("user");
        $this->db->join("friends","friends.friend_id = user.user_id");
        $this->db->where("friends.friend_id not in (select user_id from event_guests where event_id = {$evento})",null,false);
        $this->db->where("friends.user_id",$user_id);
        $resultado = $this->db->get();

        $listagem = $resultado->result();
        $output["status"] = "success";
        $output["listagem"] = $listagem;

        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));
    }

    public function listagemUsuariosConvidados(){

        $evento = $this->input->post("evento");
        $user_id = $this->encrypt->decode(base64_decode($this->input->post("token")));

        $this->db->select("user.*");
        $this->db->from("user");
        $this->db->join("friends","friends.friend_id = user.user_id");
        $this->db->where("friends.friend_id in (select user_id from event_guests where event_id = {$evento})",null,false);
        $this->db->where("friends.user_id",$user_id);
        $resultado = $this->db->get();

        $listagem = $resultado->result();
        $output["status"] = "success";
        $output["listagem"] = $listagem;

        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));
    }

    public function convidar()
    {
        $convidado = $this->input->post("convidado");
        $evento = $this->input->post("evento");
        $user_id = $this->encrypt->decode(base64_decode($this->input->post("token")));

        $dados_evento = $this->db->where("event_id",$evento)->get("events")->row();

        $quantidadeConvitePossiveis = $dados_evento->num_users;

        $quantidadeJaConvidadosEvento = $this->db->where("event_id",$evento)->get("event_guests")->num_rows();

        if($quantidadeConvitePossiveis > $quantidadeJaConvidadosEvento){

            $dadosParaInsert = array(
                'event_id' => $evento,
                'user_id' => $convidado,
                'status' => "invited",
                'updated_at' => date("Y-m-d H:i:s")
            );

            $this->db->insert("event_guests",$dadosParaInsert);

            $this->db->select("user.*");
            $this->db->from("user");
            $this->db->join("friends","friends.friend_id = user.user_id");
            $this->db->where("friends.friend_id not in (select user_id from event_guests where event_id = {$evento})",null,false);
            $this->db->where("friends.user_id",$user_id);
            $resultadoNaoConvidados = $this->db->get()->result();

            $this->db->select("user.*");
            $this->db->from("user");
            $this->db->join("friends","friends.friend_id = user.user_id");
            $this->db->where("friends.friend_id in (select user_id from event_guests where event_id = {$evento})",null,false);
            $this->db->where("friends.user_id",$user_id);
            $resultadoConvidados = $this->db->get()->result();

            $output = array();
            $output["status"] = "success";
            $output["listaConvidados"] = $resultadoConvidados;
            $output["listaNaoConvidados"] = $resultadoNaoConvidados;

        }else{
            $output["status"] = "error";
            $output["msg"] = "Evento já alcançou o maximo de convites possiveis";
        }

        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));

    }

    public function convidarLista()
    {
        $user_id = $this->encrypt->decode(base64_decode($this->input->post("token")));
        $evento = $this->input->post("evento");


        $this->db->select("user.*");
        $this->db->from("user");
        $this->db->join("friends","friends.friend_id = user.user_id");
        $this->db->where("friends.friend_id not in (select user_id from event_guests where event_id = {$evento})",null,false);
        $this->db->where("friends.user_id",$user_id);
        $resultadoNaoConvidadosTable = $this->db->get();

        $quantidadeDeAmigosDisponiveis = $resultadoNaoConvidadosTable->num_rows();

        $resultadoNaoConvidados =  $resultadoNaoConvidadosTable->result();

        $dados_evento = $this->db->where("event_id",$evento)->get("events")->row();

        $quantidadeConvitePossiveis = $dados_evento->num_users;


        $contador = 1;

        $quantidadeJaConvidadosEvento = $this->db->where("event_id",$evento)->get("event_guests")->num_rows();


        $quantidadeSobrando = $quantidadeConvitePossiveis - $quantidadeJaConvidadosEvento;

        if($quantidadeDeAmigosDisponiveis > 0){

            if($quantidadeSobrando > 0){


                foreach ($resultadoNaoConvidados as $convidado) {
                    if($contador > $quantidadeConvitePossiveis){
                        break;
                    }else{
                        $dadosParaInsert = array(
                            'event_id' => $evento,
                            'user_id' => $convidado->user_id,
                            'status' => "invited",
                            'updated_at' => date("Y-m-d H:i:s")
                        );

                        $this->db->insert("event_guests",$dadosParaInsert);
                    }

                    $contador++;

                }

                $contador -=1;

                $output["status"] = "success";
                $output["msg"] = "Sucesso foram convidados {$contador} amigos";

            }else{

                $output["status"] = "error";
                $output["msg"] = "No momento todos os convites para esse evento foram preenchidos";


            }

        }else{

            $output["status"] = "error";
            $output["msg"] = "Nenhum amigo para ser convidado no momento";
        }

        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));
    }

    public function convidarPorEmail()
    {
        $user_id = $this->encrypt->decode(base64_decode($this->input->post("token")));
        $email = $this->input->post("email");
        $evento = $this->input->post("event");

        $codigo = rand(11111111,99999999);

        $dados = array(
            'code' => $codigo,
            'email' => $email,
            'event_id' =>  $evento
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

            $output["status"]="success";
            $output["msg"] = "Convite foi enviado com sucesso";

        }else{
            echo $this->email->print_debugger();
            exit();

            //$output["status"]="error";
            //$output["msg"] = "Não foi possivel enviar e-mail no momento";
        }

        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));

    }

    public function genUsername($name, $i=0) 
    {
        $username = url_title($name, '-', true);
        $where = array('username' => $username);
        $user = $this->user->get_where($where)->row();
        if($user){
            $i = rand(0, 999999);
            return $this->genUsername($name, $i);
        } else {
            return $username;
        }
    }

    public function register()
    {
        $this->load->model('user_model','user');
        $this->load->model('user_info_model','user_info');
        $this->load->model('invite_codes_model','invite_codes');
        $this->load->model('invite_codes_friends_model','invite_codes_friends');
        $this->load->model('event_guests_model','event_guests');
        $this->load->model('user_notifications_config_model', 'user_notifications_config');

        $this->db->join('events', 'events.event_id=invite_codes.event_id');
        $code = $this->invite_codes->get_where(array('invite_codes.code' => $this->input->post('code'), 'invite_codes.status' => 'pending'))->row();
        if($code){
            $where_user = array('email' => $this->input->post('email'));
            $user = $this->user->get_where($where_user)->row();
            if(!$user){
                $save_user = array(
                    'name' => $this->input->post('name'),
                    'lastname' => $this->input->post('lastname'),
                    'username' => $this->genUsername($this->input->post('name').' '.$this->input->post('lastname')),
                    'email' => $this->input->post('email'),
                    'password' => $this->encrypt->encode($this->input->post('password')),
                    'user_type_id' => 3 //ID type usuário
                );
                if($this->input->post('picture')){
                    $this->load->helper('file');
                    $picture_name = date('YmdHis').uniqid().'.jpg';
                    if (write_file(FCPATH.'uploads/'.$picture_name, base64_decode(str_replace('data:image/jpeg;base64,','', $this->input->post('picture'))))){
                        $save_user['picture'] = $picture_name;
                    }
                }

                $user_id = $this->user->save($save_user);

                $post_info = $this->input->posts();
                $user_info = array(
                    'nascimento' => date('Y-m-d', strtotime($post_info['birthday'])),
                );
                if(isset($post_info['city']['address_components'][0]['long_name'])){
                    $user_info['cidade'] = $post_info['city']['address_components'][0]['long_name'];
                }
                if(isset($post_info['city']['address_components'][2]['long_name'])){
                    $user_info['estado'] = $post_info['city']['address_components'][2]['short_name'];
                }
                foreach ($user_info as $key => $item) {
                    $save_info = array('info_key' => $key, 'info_value' => $item, 'user_id' => $user_id);
                    $this->user_info->save($save_info);
                }

                $this->user->beFriends($user_id, $code->user_id);

                $this->invite_codes->update(array('status' => 'registered'), array('code' => $this->input->post('code')));

                $save_guest = array('event_id' => $code->event_id, 'user_id' => $user_id, 'status' => 'invited');
                $this->event_guests->save($save_guest);
                $output = array('status' => 'success', 'msg' => 'Cadastro efetuado com sucesso');
            } else {
                $output = array('status' => 'error', 'msg' => 'Esse email já está cadastrado.');
            }
        } else {
            $codeFriends = $this->invite_codes_friends->get_where(array('invite_codes_friends.code' => $this->input->post('code'), 'invite_codes_friends.status' => 'pending'))->row();

            if($codeFriends){
                $where_user_friend = array('email' => $this->input->post('email'));
                $user_friend = $this->user->get_where($where_user_friend)->row();
                if(!$user_friend){
                    $save_user_friend = array(
                        'name' => $this->input->post('name'),
                        'email' => $this->input->post('email'),
                        'password' => $this->encrypt->encode($this->input->post('password')),
                        'user_type_id' => 3 //ID type usuário
                    );
                    $user_id = $this->user->save($save_user_friend);
                    $this->user_notifications_config->save(array('user_id' => $user_id));
                    $this->user->beFriends($user_id, $codeFriends->user_id);

                    $this->invite_codes_friends->update(array('status' => 'registered'), array('code' => $this->input->post('code')));
                    $output = array('status' => 'success', 'msg' => 'Cadastro efetuado com sucesso');

                }else{
                    $output = array('status' => 'error', 'msg' => 'Esse email já está cadastrado.');
                }
            }else{
                $output = array('status' => 'error', 'msg' => 'Código não reconhecido.');
            }


        }

        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));
    }


    public function login()
    {
        $this->load->model('user_model','user');

        $where['email'] = $this->input->post('email');
        $user = $this->user->get_where($where)->row();

        if($user and $this->input->post('password') == $this->encrypt->decode($user->password)){
            unset($user->password);
            $this->session->set_userdata('user', $user);
            $output = array('status' => 'success', 'token' => rtrim(base64_encode($this->encrypt->encode($user->user_id)), '='), 'userdata' => $user);
        } else {
            $output = array('status' => 'error', 'msg' => 'Usuário não encontrado');
        }

        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));
    }

    public function fbLogin()
    {
        $session = new FacebookSession($this->input->post('accessToken'));
        try{
            $me = (new FacebookRequest(
                $session, 'GET', '/me?fields=name,email'
            ))->execute()->getGraphObject(GraphUser::className());

            $this->load->model('user_model','user');
            $where_usuario['email'] = $me->getEmail();
            $user = $this->user->get_where($where_usuario)->row();
            if($user and (!$user->facebook_id or $user->facebook_id == $me->getId())){
                if(!$user->facebook_id){
                    $save['facebook_id'] = $me->getId();
                    $save['user_id'] = $user->user_id;
                    $this->user->save($save);
                }
                $this->session->set_userdata('user', $user);
                $json= array('status' => 'success', 'token' => rtrim(base64_encode($this->encrypt->encode($user->user_id)), '='), 'userdata' => $user);
            } else {
                $json['status'] = 'error';
                $json['msg'] = 'Desculpe, não foi possivel efetuar o login com o Facebook';
            }

        } catch(\Exception $ex){
            $json['status'] = 'error';
            $json['msg'] = 'Desculpe, não foi possivel efetuar o login com o Facebook';
            $json['msg_fb'] = $ex->getMessage();
        }
        $this->output->set_content_type('application/json')
            ->set_output(json_encode($json));

    }

    public function canRequestChef()
    {
        $user_id = $this->encrypt->decode(base64_decode($this->input->post('token')));
        if($user_id){
            $this->load->model('user_model','user');
            $output = $this->user->canRequestChef($user_id);
            $this->output->set_content_type('application/json')
                ->set_output(json_encode($output));
        }
    }

    public function requestChef()
    {
        $user_id = $this->encrypt->decode(base64_decode($this->input->post('token')));
        if($user_id){
            $this->load->model('user_info_model','user_info');
            $dados = $this->input->posts();
            $dados['user_id'] = $user_id;
            $save = array(array('user_id' => $user_id, 'info_key' => 'requestChef', 'info_value' => 'friend'));
            unset($_POST['token']);
            $posts = $this->input->posts();
            if($posts['especialidades']){
                foreach ($posts['especialidades'] as $category_id => $checked) {
                    if($checked == "true"){
                        $save[] = array('user_id' => $user_id,
                            'info_key' => 'category_id',
                            'info_value' => $category_id
                        );
                    }
                }
                unset($posts['especialidades']);
            }

            foreach ($posts as $key => $item) {
                $save[] = array('user_id' => $user_id,
                    'info_key' => $key,
                    'info_value' => $item
                );
            }
            $this->db->insert_batch('user_info', $save);
            $output = array('status' => 'success', 'msg' => 'Aguarde até que possamos analisar seu cadastro de Chef, em breve você terá uma resposta em seu email.');
            $this->output->set_content_type('application/json')
                ->set_output(json_encode($output));
        }
    }

    public function solitacoesChef($token)
    {
        $this->load->model('user_model','user');
        $this->load->model('categories_model','categories');
        $user_id = $this->encrypt->decode(base64_decode($token));
        $this->db->select("user.user_id,
            user.username,
            user.email,
            user.name,
            CONCAT('".SITE_URL."uploads/', user.picture) as picture,
            user.facebook_id,
            user.user_type_id,
            user_info.info_key,
            user_info.info_value
            ")
            ->join('user_info', 'user_info.user_id=user.user_id')
            ->where("user.user_id IN (
                SELECT
                friend_id
                FROM
                friends
                JOIN
                user_info ON user_info.user_id = friends.friend_id
                WHERE
                friends.user_id = '$user_id'
                AND user_info.info_key = 'requestChef'
                AND user_info.info_value = 'friend'
            )", null, false);

        $usuario = $this->user->get_all()->result_array();
        $output = array();

        foreach ($usuario as $item) {
            if(!isset($output[$item['user_id']])){
                $output[$item['user_id']] = $item;
            }
            if(!isset($output[$item['user_id']]['extra'])){
                $output[$item['user_id']]['extra'] = array();
            }
            if($item['info_key']){
                if($item['info_key'] == 'category_id'){
                    $this->db->select('name');
                    $category = $this->categories->get($item['info_value'])->row();
                    $output[$item['user_id']]['extra']['especialidades'][] = $category->name;
                } else if($item['info_key'] == 'picture'){
                    $output[$item['user_id']]['extra'][$item['info_key']] = (strstr($item['info_value'], 'http') ? '' : SITE_URL.'uploads/').$item['info_value'];
                } else {
                    $output[$item['user_id']]['extra'][$item['info_key']] = $item['info_value'];
                }
            }

            unset($output[$item['user_id']]['info_key'], $output[$item['user_id']]['info_value']);
        }
        $this->output->set_content_type('application/json')
            ->set_output(json_encode(array_values($output)));
    }



    //função amigo
    public function getListFriends(){

        $user_id = $this->encrypt->decode(base64_decode($this->input->post('token')));

        $this->db->select("user.*,CONCAT('".SITE_URL."uploads/', user.picture) as picture");
        $this->db->from("friends");
        $this->db->join("user","friends.friend_id = user.user_id");
        $this->db->where("friends.user_id",$user_id);
        //$this->db->group_by("friends.user_id");
        $resultado = $this->db->get();

        $this->output->set_content_type('application/json')
            ->set_output(json_encode($resultado->result()));

    }


    public function aprovarChef() 
    {
        $user_id = $this->encrypt->decode(base64_decode($this->input->post('token')));
        $this->load->model('user_info_model','user_info');
        $this->load->model('user_model','user');

        $this->db->select('user_info.user_info_id');
        $this->user_info->join('friends', 'friends.friend_id=user_info.user_id');
        $where['user_info.user_id'] = $this->input->post('friend_id');
        $where['user_info.info_key'] = 'requestChef';
        $where['user_info.info_value'] = 'friend';
        $where['friends.user_id'] = $user_id;
        $user = $this->user_info->get_where($where)->row();
        if($user){
            $this->user_info->update(array('info_value' => 'admin'), $user->user_info_id);
            $output = array('status' => 1, 'Enviado para o administrador aprovar essa requisição');
        } else {
            $output = array('status' => 0, 'Requisição não encontrada');
        }
        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));

    }



    public function geraCodigo()
    {
        $codigo = rand(11111111,99999999);
        if($this->input->post('evento')){
            $evento = $this->input->post("evento");
            $dados = array(
                'code' => $codigo,
                'email' => null,
                'event_id' =>  $evento
            );

            $this->db->insert("invite_codes",$dados);
        } else {
            $user_id = $this->encrypt->decode(base64_decode($this->input->post("token")));
            $dados = array('code' => $codigo,
                           'user_id' => $user_id
                       );
            $this->db->insert('invite_codes_friends', $dados);
        }

        $output["status"] = "sucesso";
        $output["codigo"] = $codigo;

        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));

    }


    public function convidaAmigos()
    {
        $user_id = $this->encrypt->decode(base64_decode($this->input->post("token")));
        $email = $this->input->post("email");

        $codigo = rand(11111111,99999999);


        $dados = array(
            'code' => $codigo,
            'email' => $email,
            'user_id' => $user_id
        );

        $this->db->insert("invite_codes_friends",$dados);

        $para = $email;

        $msg = "<h1>Convite de partição Chef Amigo</h1>";
        $msg.="<p><strong>Codigo:</strong>".$codigo."</p>";

        $this->load->library('email');
        $this->email->from(EMAIL_FROM, 'Convite de partição Chef Amigo');
        $this->email->to($para);
        $this->email->subject('Convite de partição Chef Amigo');

        $this->email->message($msg);

        if($this->email->send()){

            $output["status"]="success";
            $output["msg"] = "Convite foi enviado com sucesso";

        }else{
            $output["msg"] = "Falha ao enviar o convite!";

        }

        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));

    }

    public function getPerfil()
    {
        $user_id = $this->input->post("user_id");
        $this->load->model('user_model','user');
        $this->load->model('events_model','events');

        $this->db->select("user.name,
                           user.lastname,
                           user.user_id as userId,
                           CONCAT('".SITE_URL."uploads/', user.picture) as picture, 
                           user_types.label as user_type")
                  ->select("(SELECT info_value FROM user_info WHERE user_id = userId AND info_key = 'curriculo') as curriculo")
                  ->join('user_types', 'user_types.user_type_id=user.user_type_id');
        $output = $this->user->get($user_id)->row();

        $buscaAmigos = $this->db->select("user.user_id,
                                          user.name,
                                          user.lastname,
                                          CONCAT('".SITE_URL."uploads/', user.picture) as picture")
                                ->from("user")
                                ->join("friends","friends.friend_id = user.user_id")
                                ->where("friends.user_id",$user_id);

        $output->friends = $buscaAmigos->get()->result();

        $this->db->select("events.event_id as eventId,
                           events.name,
                           events.description,
                           DATE_FORMAT(events.start,'%m/%d/%Y %h:%i') as data,
                           (SELECT COUNT(*) FROM event_guests WHERE event_id = eventId) as total_guests,
                           (SELECT COUNT(*) FROM event_guests WHERE event_id = eventId AND status = 'confirmed') as total_confirmed,
                           CONCAT('".SITE_URL."uploads/', events.picture) as picture
                          ")
                 ->join("event_guests","event_guests.event_id=events.event_id");
        $output->events = $this->events->get_where(array("event_guests.user_id" => $user_id))->result();

        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));

    }

    public function verificacaoSolicitacaoChef(){

        $user_id = $this->encrypt->decode(base64_decode($this->input->post("token")));

        $this->db->where("user_id",$user_id);
        $resultado = $this->db->get("friends");


        if($resultado->num_rows() >= 20){
            $output["pode"] = true;
        }else{
            $output["pode"] = false;
        }

        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));

    }

    public function confirmaChefe(){

        $resposta = $this->input->post("resposta");
        $user = $this->input->post("user");

        if($resposta == "aceitar"){

            $data = array(
                'user_type_id' => 2
            );

            $this->db->where('user_id', $user);
            $this->db->update('user', $data); 

            $data = array('info_value' => 'chefe' );

            $this->db->where("user_id",$user);
            $this->db->where("info_key","requestChef");
            $this->db->where("info_value","admin");
            $this->db->update('user_info', $data); 


        }else{

            $data = array('info_value' => 'cancelado' );

            $this->db->where("user_id",$user);
            $this->db->where("info_key","requestChef");
            $this->db->where("info_value","admin");
            $this->db->update('user_info', $data); 

        }


        $this->load->model("User_info_model","info");

        $resultado = $this->info->getRequestsChefs()->result();

        $output["listagem"] = $resultado;


        $dadosUsuario = $this->db->where("user_id",$user)->get("user")->row();

        $para = $dadosAmigos->email;  

        $msg = "<h1>Solicitação à chefe</h1>";

        if($resposta == "aceitar"){

            $msg.="<p>Sua solicitação para chefe foi aceita <a href=''>clique aqui</a> para acessar o painel para cadastrar seus eventos</p>";

        }else{

            $msg.="<p>Sua solicitação à chefe não foi aceita, entre em contato no e-mail duvidas@d4f.com.br caso queira saber o motivo</p>";

        }

        $this->load->library('email');                   
        $this->email->from(EMAIL_FROM, 'Resposta solicitação à chefe');                
        $this->email->to($para);                        
        $this->email->subject('Resposta solicitação à chefe');  
        $this->email->message($msg); 
        $this->email->send();                    


        $this->output->set_content_type('application/json')
                     ->set_output(json_encode($output));
    }



    public function getNotificationUser(){

        $user_id = $this->encrypt->decode(base64_decode($this->input->post("token")));


        $this->db->select("*,DATE_FORMAT(data,'%d/%c/%Y %H:%i:%S') as data_formatada");
        $this->db->where("user_id",$user_id);
        $this->db->order_by("notification_id","desc");
        $output = $this->db->get("notification")->result();

        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));


    }

    public function updatePicture(){

        $user_id = $this->encrypt->decode(base64_decode($this->input->post("token")));

        $imagem = $this->input->post("imagem");


        $this->db->update("user",array('picture' => $imagem ),array('user_id' => $user_id ));

        $output["status"] = "sucesso";
        $output["imagem"] = SITE_URL."uploads/".$imagem;

        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));

    }

    public function updatePushNotification()
    {
        $user_id = $this->encrypt->decode(base64_decode($this->input->post("token")));

        $data = array(
            'player_id' => $this->input->post("player_id"),
            'device_token' => $this->input->post("device_token")
        );

        $this->db->where('user_id', $user_id);
        $this->db->update('user', $data); 

        $output["status"] = "sucesso";


        $this->output->set_content_type('application/json')
            ->set_output(json_encode($output));


    }

    public function importContactsGmail()
    {
        $this->load->library('Lib_google');
        $this->load->model('invite_codes_friends_model','invite_codes_friends');
        if(isset($_GET['code'])) {
            $friends = $this->lib_google->getFriends();

            $i=0;
            foreach ($friends as $item) {
                if($this->invite_codes_friends->sendInvite($item, $this->session->userdata('user')->user_id)){
                    $i++;
                }
            }
            $output = array('status' => 'success', 'msg' => $i.' convite'.($i != 1 ? 's' : '').' enviados');
        } else {
            $user_id = $this->encrypt->decode(base64_decode($this->input->post("token")));
            $googleImportUrl = $this->lib_google->getAuthUrl();
            $output = array("url" => $googleImportUrl);
        }
        $this->output->set_content_type('application/json')
                     ->set_output(json_encode($output));
    }
    
    public function importContactsOutlook()
    {
        $this->load->library('Lib_outlook');
        $this->load->model('invite_codes_friends_model','invite_codes_friends');
        
        if(isset($_GET['code'])){
            $friends = $this->lib_outlook->getFriends();
            $i=0;
            foreach ($friends as $item) {
                if($this->invite_codes_friends->sendInvite($item, $this->session->userdata('user')->user_id)){
                    $i++;
                }
            }
            $output = array('status' => 'success', 'msg' => $i.' convite'.($i != 1 ? 's' : '').' enviados');
        } else {
            $url = $this->lib_outlook->getLoginUrl($redirectUri);
            $output = array('url' => $url);
        }
        $this->output->set_content_type('application/json')
                     ->set_output(json_encode($output));
    }

    public function notificacoesConfig() 
    {
        $this->load->model('user_notifications_config_model','user_notifications_config');
        $user_id = $this->encrypt->decode(base64_decode($this->input->post("token")));
        if($this->input->post('key')){
            $set = array($this->input->post('key') => $this->input->post('value'));
            $this->user_notifications_config->update($set, array('user_id' => $user_id));
        }
        $result = $this->user_notifications_config->get_where(array('user_id' => $user_id))->row();
        $output = array();
        foreach ($result as $key => $item) {
            $output[$key] = $item;
        }
        unset($output['user_notifications_config_id'], $output['user_id']);

        $this->output->set_content_type('application/json')
                     ->set_output(json_encode($output));
    }
}
