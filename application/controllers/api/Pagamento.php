<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Pagamento extends CI_Controller
{
    public function __construct() 
    {
        parent::__construct();
        $this->output->set_header('Access-Control-Allow-Origin: *');
    }

    public function getDirectSession() 
    {
        $this->load->library('lib_apipagseguro');
        $session_id = $this->lib_apipagseguro->getDirectSession();
        $this->output->set_output($session_id);
    } 

    public function cupom() 
    {
        $this->load->model('cupom_model','cupom'); 
        $where = array('code' => $this->input->post('cupom'), 
                       'event_id' => $this->input->post('event_id'), 
                       'valid >=' => date('Y-m-d')
                      );
        $cupom = $this->cupom->get_where($where)->row();
        if(!$cupom){
            $output = array('status' => 'error', 'msg' => 'Cupom não encontrado');
        } else {
            $cupom->value = (float) $cupom->value;
            $output = array('status' => 'success', 'cupom' => $cupom);
        }

        $this->output->set_content_type('application/json')
                     ->set_output(json_encode($output));
    }

    public function pagseguro() 
    {
        header('Access-Control-Allow-Origin: *');
        $this->load->library('lib_apipagseguro');
        $this->load->model('events_model','events');
        $this->load->model('payments_model','payments');
        $this->load->model('user_model','user');
        $this->load->model('event_guests_model','event_guests');
        $this->load->model('payments_guests_model','payments_guests');

        $user_id = $this->encrypt->decode(base64_decode($this->input->post('token')));
        $where = array('event_guests.user_id' => $user_id, 'event_guests.event_id' => $this->input->post('event_id'));
        $this->db->join('event_guests', 'event_guests.event_id=events.event_id');
        $event = $this->events->get_where($where)->row();

        $user = $this->user->get($user_id)->row();
        $dados_cliente = $this->input->posts();
        $dados_cliente['nome'] = $user->name.' '.$user->lastname;
        $dados_cliente['email'] = $user->email;

        $save_payment = array(
            'user_id' => $user_id,
            'price' => ($this->input->post('qty') ? (($this->input->post('qty') +1) * $event->price) : $event->price),
            'status' => 'Aguardando Pagto.',
            'method' => 'PagSeguro',
            'user_data' => json_encode($dados_cliente),
            'qty_friends' => $this->input->post('qty')
        );
        $save_payment['feeAmountSite'] = ($save_payment['price'] * 0.05);

        $payment_id = $this->payments->save($save_payment);
        if($this->input->post('acompanhantes')){
            $acompanhantes = $this->input->post('acompanhantes');
            foreach ($acompanhantes as $key => $item) {
                $where_friend = array('email' => $acompanhantes[$key]['email']);
                $friend = $this->user->get_where($where_friend)->row();
                $save_payment_guests = array('payment_id' => $payment_id);
                if($friend){
                    $where_event_guest = array('event_id' => $event->event_id, 'user_id' => $friend->user_id);
                    $event_guest = $this->event_guests->get_where($where_event_guest)->row();
                    if($event_guest){
                        $save_payment_guests['event_guest_id'] = $event_guest->event_guest_id;
                    } else {
                        $save_payment_guests['event_guest_id'] = $this->event_guests->save($where_event_guest);
                    }
                } else {
                    $where_friend['name'] = $acompanhantes[$key]['name'];
                    $where_friend['lastname'] = $acompanhantes[$key]['lastname'];
                    $where_friend['user_type_id'] = 3;
                    $save_event_guest['user_id'] = $this->user->save($where_friend);
                    $save_event_guest['event_id'] = $event->event_id;
                    $save_payment_guests['event_guest_id'] = $this->event_guests->save($save_event_guest);
                    $this->user->beFriends($user_id, $save_event_guest['user_id']);
                }
                $this->payments_guests->save($save_payment_guests);
            }
            
        }

        $carrinho = array(
           "reference" => $payment_id,
           "shippingType" => 3, 
           "itemId1" => $event->event_id,
           "itemDescription1" => utf8_decode(abreviaString($event->name)),
           "itemAmount1" => $event->price,
           "itemQuantity1" => $this->input->post('qty') + 1,
           'notificationURL' => SITE_URL.'api/pagamento/notificacao'
        );
        $pagseguro = $this->lib_apipagseguro->novaCompra($carrinho, $dados_cliente);
        $this->output->set_content_type('application/json')
                     ->set_output(json_encode($pagseguro));
    }

    public function pagar() 
    {
        header('Access-Control-Allow-Origin: *');
        $this->load->library("lib_apipagseguro");
        $this->load->model('events_model','events');
        $this->load->model('payments_model','payments');
        $this->load->model('user_model','user');
        
        $user_id = $this->encrypt->decode(base64_decode($this->input->post('token')));
        $where = array('event_guests.user_id' => $user_id, 'event_guests.event_id' => $this->input->post('event_id'));
        $this->db->join('event_guests', 'event_guests.event_id=events.event_id');
        $event = $this->events->get_where($where)->row();

        $user = $this->user->get($user_id)->row();
        $dados_cliente = $this->input->posts();
        $dados_cliente['nome'] = $user->name.' '.$user->lastname;
        $dados_cliente['email'] = $user->email;

        $save_payment = array(
            'event_guest_id' => $event->event_guest_id,
            'price' => $event->price,
            'status' => 'Aguardando Pagto.',
            'method' => $this->input->post('pagamento'),
            'user_data' => json_encode($dados_cliente),
            'feeAmountSite' => ($event->price * 0.05)
        );

        $payment_id = $this->payments->save($save_payment);
        $carrinho = array(
           "reference" => $payment_id,
           "shippingType" => 3, 
           "itemId1" => $event->event_id,
           "itemDescription1" => utf8_decode(abreviaString($event->name)),
           "itemAmount1" => $event->price,
           "itemQuantity1" => 1,
           "senderHash" => $this->input->post('pagseguroHash'),
        );

        switch($this->input->post('pagamento')){
            case "boleto":
                $output['erro'] = '';

                $boleto = $this->lib_apipagseguro->directBoleto($carrinho, $dados_cliente);
                $output['erro'] = $this->lib_apipagseguro->erro;
                if(!$output['erro']){
                    $this->payments->save(array('paymentLink' => $boleto->paymentLink, 'payment_id' => $payment_id));
                    $output['payment'] = array('payment_id' => $payment_id, 'boleto_link' => $boleto->paymentLink, 'boleto_download' => $boleto->downloadLink);
                }
            break;
            case "creditCard":
                $output['erro'] = '';
                $carrinho['senderHash'] = $this->input->post('pagseguroHash');

                $creditCard_fields = array('creditCardToken', 'installmentQuantity', 'installmentValue', 'creditCardHolderName', 'creditCardHolderBirthDate', 'creditCardHolderCPF', 'creditCardHolderAreaCode', 'creditCardHolderPhone');
                foreach ($creditCard_fields as $field) {
                    $carrinho[$field] = $this->input->post($field);
                }
                $request = $this->lib_apipagseguro->directCreditCard($carrinho, $dados_cliente);
                $output['erro'] = $this->lib_apipagseguro->erro;
                if(!$output['erro']){
                    $update_payment = array(
                        'payment_id' => $payment_id,
                        'status' => pagseguro_status($request->status),
                        'discountAmount' => $request->discountAmount,
                        'feeAmountPagseguro' => $request->feeAmount ,
                        'netAmount' => $request->netAmount,
                        'extraAmount' => $request->extraAmount
                    );
                    $this->payments->save($update_payment);
                    $output['payment'] = array('payment_id' => $payment_id, 'status' => $update_payment['status']);
                }

            break;
        }
        $this->output->set_content_type('application/json')
                     ->set_output(json_encode($output));
    }
}
