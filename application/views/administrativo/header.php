<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Administrativo</title>
    <script src="http://code.jquery.com/jquery-1.12.4.min.js"   integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="   crossorigin="anonymous"></script>
    <script src="<?php echo base_url() ?>assets/js/jquery.maskMoney.min.js"></script>
    <link href="<?php echo base_url() ?>administrativo-assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="<?php echo base_url() ?>administrativo-assets/css/dashboard.css" rel="stylesheet">
    <link href="<?php echo base_url() ?>administrativo-assets/fancybox/jquery.fancybox.css" rel="stylesheet">
    <link href="<?php echo base_url() ?>administrativo-assets/css/style.css" rel="stylesheet">

    <script>var base_url = '<?php echo site_url('administrativo') ?>/';</script>
    <input type="hidden" id="site" value="<?php echo SITE_URL; ?>">
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="<?php echo site_url('administrativo') ?>">Amigo Chef</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="<?php echo site_url('administrativo/login/sair') ?>">Sair</a></li>
          </ul>
          <form class="navbar-form navbar-right" action="<?php echo site_url('administrativo/parceiros/') ?>" method="post">
            <input type="text" class="form-control" name="id_parceiro" placeholder="Procurar..." value="<?php echo $this->input->post('id_parceiro') ?>">
          </form>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li><a href="<?php echo site_url('administrativo/usuarios/admins') ?>">Administradores</a></li>
            <li><a href="<?php echo site_url('administrativo/usuarios/chefs') ?>">Chefs</a></li>
            <li><a href="<?php echo site_url('administrativo/usuarios/users') ?>">Convidados</a></li>
            <li><a href="<?php echo site_url('administrativo/usuarios/users') ?>">Acompanhantes</a></li>
            <li><a href="<?php echo site_url('administrativo/eventos') ?>">Eventos</a></li>
            <li><a href="<?php echo site_url('administrativo/relatorios') ?>">Relatórios</a></li>
            <li><a href="<?php echo site_url('administrativo/solicitacoes') ?>">Solicitações</a></li>
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

