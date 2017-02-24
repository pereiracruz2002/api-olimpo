App.controller('EventoDetalhesController', function ($rootScope,$timeout, $scope, $mdDialog, EventoService, $location,URL_API,$routeParams,$cookies){

    var evento_id = $routeParams.id;
    $scope.evento = evento_id;
    var token = $cookies.get('chef');
    $scope.tab=1;
    $scope.Answers = [];
    $scope.loading = true;
    $scope.pictures = {};
    
    $scope.eventoFormData = {
        'event_id': $routeParams.id,
        'start': '',
        'start_hour': '',
        'end_subscription':'',
        'price':'',
        'name':'',
        'description':'',
        'status':'',
        'street':'',
        'number':'',
        'state':'',
        'city':'',
        'neighborhood':'',
        'zipcode':'',
        'picture': [],
        'event_type_id':'',
        'invite_limit':'',
        'num_users':'',
        'private': '1'
    }
    $scope.save_tab = true;

    EventoService.buscaInfoTipoEventos().then(function(retorno){
        $scope.forms = retorno.data.html;
        for(item in $scope.forms ){
            $scope.forms[item].value=' ';
            $scope.Answers.push($scope.forms[item]);
        }
        
    });

    EventoService.buscaTipoEventos().then(function(retorno){
        $scope.typesOptions = retorno.data;
    });


    $scope.mudatab = function(valor){
        $scope.tab = valor;
    }

    $scope.listagemNaoConvidados= [];
    $scope.listagemConvidados = [];

    var dados = "evento="+evento_id+"&token="+token;
    EventoService.listaUsuariosNaoCadastradosNoEvento(dados).then(function(retorno){
        $scope.listagemNaoConvidados = retorno.data.listagem;
    });

    EventoService.listaUsuariosCadastradosNoEvento(dados).then(function(retorno){
        $scope.listagemConvidados = retorno.data.listagem;
    });

    EventoService.getEvento(evento_id, token).then(function(result){
        angular.forEach(result.data, function(value, key){
            if(['start', 'end_subscription'].indexOf(key) != -1){
                $scope.eventoFormData[key] = new Date(value);
                $scope.eventoFormData.start_hour = value.substr(-8, 5);
            } else if(key == 'pictures'){
                $scope.pictures = value;
            } else if(key == 'price'){
                $scope.eventoFormData.price = parseFloat(value.replace('.', '').replace(',','.'));
            } else {
                $scope.eventoFormData[key] = value;
            }
        });

        angular.forEach($scope.Answers, function (value, key){
            $scope.Answers[key].value = result.data.extra[value.event_info_category_id].values[value.name]; 
        });
        $scope.loading = false;
    });

    $scope.$watch('imagem_upload',function(){

        $scope.loading = true;
        if($scope.imagem_upload){
            var dados = {
                'photo': $scope.imagem_upload,
                'event_id': $routeParams.id
            }
            $rootScope.loading_content = true;
            $scope.erro_upload = '';
            EventoService.upload(dados).then(function(result){
                $scope.loading = false;
                if(result.data.error){
                    $mdDialog.show(
                        $mdDialog.alert()
                            .clickOutsideToClose(true)
                            .title('Atenção')
                            .htmlContent(result.data.error)
                            .ariaLabel(result.data.error)
                            .ok('Ok')
                    );
                } else {
                    var novoObj = {};
                    novoObj.href = result.data.upload_data.href; 
                    if(!$scope.pictures){
                        novoObj.principal = "1";
                    }else{
                        novoObj.principal = "0";
                    }
                
                    $scope.pictures[result.data.upload_data.event_gallery_id] = novoObj;
                }
            });
        }
    });

    $scope.tornarPrincipal = function(index){
        for(foto in $scope.pictures){
            $scope.pictures[foto].principal = '0';
        }

        $scope.pictures[index].principal = '1'; 
        var dados = {
            event_id: evento_id,
            picture: $scope.pictures[index].href,
            token: token
        }
        EventoService.setImagemPrincipal(dados);

    }


    $scope.excluirImagem = function(index){
        var dados = {
            event_gallery_id: index,
            token: token
        }
        EventoService.removerImg(dados);

        var fotos = [];
        delete $scope.pictures[index]
    }


    $scope.nextStep = function()
    {
        $scope.loading = true;
        EventoService.update($scope.eventoFormData).then(function(result){
            $scope.loading = false;
        });
    }

    $scope.showPrompt = function(ev) {
        var confirm = $mdDialog.prompt()
                               .title('Preencha o email do convidado')
                               .placeholder('Convidar por email')
                               .targetEvent(ev)
                               .ok('Convidar')
                               .cancel('Cancelar');

        $mdDialog.show(confirm).then(function(resultado) {
            $scope.mostraLoading = true;

            var dados = "email="+resultado+"&event="+evento_id+"&token="+token;
            EventoService.convidarEmail(dados).then(function(retorno){
                if(retorno.data.status == "success"){
                    $scope.mostraLoading = false;
                    $mdDialog.show(
                        $mdDialog.alert()
                           .title('Sucesso!!!')
                           .textContent(retorno.data.msg)
                           .ariaLabel('Alert Dialog Demo')
                           .ok('Ok')
                    );
                
                } else {
                     $scope.mostraLoading = false;
                    $mdDialog.show(
                      $mdDialog.alert()
                        .title('Erro')
                        .textContent(retorno.data.msg)
                        .ariaLabel('Alert Dialog Demo')
                        .ok('Ok')
                    );

               
                }
            });
        });
    };



    $scope.convidar = function(usuario){
        $scope.mostraLoading = true;
        var dados = "convidado="+usuario+"&evento="+evento_id+"&token="+token;
        EventoService.convidarAmigo(dados).then(function(retorno){
            if(retorno.data.status == "success"){
                $scope.mostraLoading = false;
                $scope.listagemNaoConvidados = retorno.data.listaNaoConvidados;
                $scope.listagemConvidados = retorno.data.listaConvidados;
            }else{
                $scope.mostraLoading = false;
                $mdDialog.show(
                  $mdDialog.alert()
                    .title('Erro')
                    .textContent(retorno.data.msg)
                    .ariaLabel('Alert Dialog Demo')
                    .ok('Ok')
                );
            }
        });
    }

    $scope.convidarEmail = function(){
        var email = $("#form-email").serialize();
        var dados = email+"&event="+evento_id+"&token="+token;

        EventoService.convidarEmail(dados).then(function(retorno){
            if(retorno.data.status == "success"){
                   $mdDialog.show(
                     $mdDialog.alert()
                       .title('Sucesso!!!')
                       .textContent(retorno.data.msg)
                       .ariaLabel('Alert Dialog Demo')
                       .ok('Ok')
                   );
            }else{
                $mdDialog.show(
                  $mdDialog.alert()
                    .title('Erro')
                    .textContent("Não foi possivel enviar o e-mail")
                    .ariaLabel('Alert Dialog Demo')
                    .ok('Ok')
                );
            }

        });
    }

    $scope.convidarLista = function(){
         $scope.mostraLoading = true;
        var dados = "token="+token+"&evento="+evento_id;
        EventoService.convidarListaAmigos(dados).then(function(retorno){
            if(retorno.data.status == "success"){
                $scope.mostraLoading = false;
                $mdDialog.show(
                     $mdDialog.alert()
                       .title('Sucesso!!!')
                       .textContent(retorno.data.msg)
                       .ariaLabel('Alert Dialog Demo')
                       .ok('Ok')
                   );

                EventoService.listaUsuariosNaoCadastradosNoEvento(dados).then(function(retorno){
                    $scope.listagemNaoConvidados = retorno.data.listagem;
                });

                EventoService.listaUsuariosCadastradosNoEvento(dados).then(function(retorno){
                    $scope.listagemConvidados = retorno.data.listagem;
                });
            }else{
                 $scope.mostraLoading = false;

                $mdDialog.show(
                     $mdDialog.alert()
                       .title('Atenção')
                       .textContent(retorno.data.msg)
                       .ariaLabel('Alert Dialog Demo')
                       .ok('Ok')
                );
            }
        })
    }
});
