<!doctype html>
<html ng-app="App">
<head prefix="og: https://ogp.me/ns# fb: http://ogp.me/ns/fb# facileme: https://ogp.me/ns/fb/facileme#">
    <meta name="fragment" content="!" />
    <meta charset="utf-8">
    <title ng-bind="pageTitle">Dinner 4 Friends</title>
    <meta name='robots' content='index,follow' />

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link href="//fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/angular_material/1.1.0/angular-material.min.css">
    <link rel="stylesheet" href="/assets/css/style.css" />

      <script src="https://apis.google.com/js/client.js"></script>
    
    <!--[if lt IE 9]>
        <script src="//oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="//oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    </head>
    <body layout="row" ng-cloak>

        <navbar></navbar>
        <div ng-view layout="column" layout-fill></div>

    <!--
        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular.min.js"></script>
        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-route.min.js"></script>
        <script src="https://apis.google.com/js/client.js"></script>
    -->
    <script type="text/javascript" src="/assets/js/angular.min.js"></script>
    <script type="text/javascript" src="/assets/js/angular-route.min.js"></script>
    <script type="text/javascript" src="/assets/js/angular-cookies.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-animate.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-aria.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-messages.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-sanitize.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angular_material/1.1.0/angular-material.min.js"></script>
    <script src="/assets/js/angular-material-data-table/dist/md-data-table.min.js"></script>
    <script type="text/javascript" src="/assets/js/angular-ui-mask/dist/mask.js"></script>
    <script type="text/javascript" src="<?php echo base_url() ?>assets/js/ngMask.min.js"></script>
    <script type="text/javascript" src="<?php echo base_url() ?>template/directives/header.js"></script>
    <script type="text/javascript" src="<?php echo base_url() ?>template/directives/rodape.js"></script>
    <script type="text/javascript" src="<?php echo base_url() ?>template/directives/nav.js"></script>
    
    <script>
        window.fbAsyncInit = function() {
            FB.init({
              appId      : '<?php echo FB_ID ?>',
              xfbml      : true,
              version    : 'v2.7'
          });
        };

        (function(d, s, id){
           var js, fjs = d.getElementsByTagName(s)[0];
           if (d.getElementById(id)) {return;}
           js = d.createElement(s); js.id = id;
           js.src = "//connect.facebook.net/pt_BR/sdk.js";
           fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
    </script>



    <script>
      var App = angular.module('App', ['ngRoute', 'ngMaterial','ui.mask', 'rodape', 'header', 'ngMask', 'navbar', 'ngCookies', 'ngSanitize']);
      App.constant('URL_API', '<?php echo site_url('api/') ?>');
    </script>
    <script type="text/javascript" src="<?php echo base_url() ?>template/directives/endRepeat.js"></script>


    <script type="text/javascript" src="<?php echo base_url() ?>template/services/usuario.js"></script>
    <script type="text/javascript" src="<?php echo base_url() ?>template/services/evento.js"></script>
    <script type="text/javascript" src="<?php echo base_url() ?>template/controllers/login.js"></script>
    <script type="text/javascript" src="<?php echo base_url() ?>template/controllers/painel.js"></script>
    <script type="text/javascript" src="<?php echo base_url() ?>template/controllers/evento.js"></script>
    <script type="text/javascript" src="<?php echo base_url() ?>template/controllers/eventoDetalhes.js"></script>
    <script type="text/javascript" src="<?php echo base_url() ?>template/controllers/eventoConvidadoDetalhes.js"></script>
    <script type="text/javascript" src="<?php echo base_url() ?>template/controllers/amigo.js"></script>

    <script type="text/javascript" src="<?php echo base_url() ?>template/controllers/editar.js" ></script>

    <script type="text/javascript" src="<?php echo base_url() ?>template/app.js"></script>
</body>
</html>
