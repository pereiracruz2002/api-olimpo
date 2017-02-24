function auth() {
      var config = {
        'client_id': '197198791318-19b9p2jbm0p1trfu0nvk1risqlo6c5iq.apps.googleusercontent.com',
        'scope': 'https://www.google.com/m8/feeds'
      };
      gapi.auth.authorize(config, function() {
        fetch(gapi.auth.getToken());
      });
    }

App.controller('AmigoController', function ($http,$rootScope,$mdDialog, $scope, UsuarioService, $location,URL_API,$sce,$cookies,$httpParamSerializerJQLike){

    $scope.amigos = [];

    $scope.contatos = [];
    $scope.formData = {};
    $scope.mostraLoading = false;
    var token = $cookies.get('chef');
    $scope.token = token;

     UsuarioService.listaAmigos(token).then(function(retorno){
        $scope.amigos = retorno.data;  
    });

     $scope.showDialog = function($event,lista) {

            var htmlitem = "";


            for(item in lista){

                console.log(lista[item].email);

                htmlitem += "<md-list-item><md-checkbox name='emails[]' value='"+lista[item].email+"' value='' style='color:#fff'>"+lista[item].email+"</md-checkbox></md-list-item>";

            }

            var parentEl = angular.element(document.body);
            $mdDialog.show({
              parent: parentEl,
              targetEvent: $event,
              template:
                '<md-dialog aria-label="List dialog">' +
                '<h4>Selecione os contatos que deseja enviar o convite</h4>'+
                '  <md-dialog-content>'+
                '    <md-list>'+htmlitem+'</md-list>'+
                '  </md-dialog-content>' +
                '  <md-dialog-actions>' +
                '    <md-button ng-click="closeDialog()" class="md-primary">' +
                '      Close Dialog' +
                '    </md-button>' +
                '  </md-dialog-actions>' +
                '</md-dialog>',
              locals: {
                items: $scope.items
              },
              controller: DialogController
           });
           function DialogController($scope, $mdDialog, items) {
             $scope.items = items;
             $scope.closeDialog = function() {
               $mdDialog.hide();
             }
           }
         }
       

     $scope.importarGmailText = 'Importar amigos do Google';
     $scope.importarGmail = function($event)
     {
         $scope.importarGmailText = 'Aguarde...';
         UsuarioService.importContactsGmail().then(function(retorno){
             location.href = retorno.data.url;
         });
     }

     $scope.importarOutlookText = 'Importar amigos do Outlook';
     $scope.importarOutlook = function()
     {
         $scope.importarOutlookText = 'Aguarde...';
         UsuarioService.importContactsOutlook().then(function(retorno){
             location.href = retorno.data.url;
         })
     }

   


    $scope.convidar = function(usuario){

        $scope.mostraLoading = true;

        var dados = "convidado="+usuario+"&evento="+evento_id+"&token="+token;

        EventoService.convidarAmigo(dados).then(function(retorno){

            console.log(retorno.data);

            if(retorno.data.status == "success"){
                $scope.listagemNaoConvidados = retorno.data.listaNaoConvidados;
                $scope.listagemConvidados = retorno.data.listaConvidados;
                $scope.mostraLoading = false;
            }else{

                alert(retorno.data.msg);
                $scope.mostraLoading = false;
            }

        });
    }

    $scope.convidarAmigoEmail = function(){
        $scope.mostraLoading = true;
        console.log("entrou no convidar");
        $scope.formData.token = token;
        UsuarioService.convidarAmigos($scope.formData).then(function(retorno){

            if(retorno.data.status == "success"){

                $scope.mostraLoading = false; 
                $mdDialog.show(
                     $mdDialog.alert()
                       .title('Sucesso!!!')
                       .textContent(retorno.data.msg)
                       .ariaLabel('Alert Dialog Demo')
                       .ok('Ok')
                   ); 

                UsuarioService.listaAmigos(token).then(function(retorno){
                    $scope.formData.email = '';
                    $scope.amigos = retorno.data;
                    
                    
                });
            }else{

                $scope.mostraLoading = false;
               
                $mdDialog.show(
                     $mdDialog.alert()
                       .title('Erro!!!')
                       .textContent(retorno.data.msg)
                       .ariaLabel('Alert Dialog Demo')
                       .ok('Ok')
                   );
                
            }

        });
    }


});




