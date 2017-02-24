App.controller('EventoController', function ($rootScope, $scope, EventoService, $location, $mdDialog, URL_API, $sce, $cookies){

    $scope.tab=1;
    $scope.pictures = [];
    $scope.myModal = {};

    $scope.Answers = [];

    $scope.data = {
        selectedIndex: 0
    };

    $scope.eventoFormData = {
        'start': '',
        'end': '',
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

    function isEmpty(obj) {
        for(var prop in obj) {
            if(obj.hasOwnProperty(prop))
                return false;
        }

        return true;
    }

    $scope.loading = false;
    $rootScope.pageTitle = 'Evento';


    $scope.status = [{"value":"enable","text":"Ativo"},{"value":"disabled","text":"Inativo"}];



    EventoService.buscaInfoTipoEventos().then(function(retorno){
        //$scope.forms = $sce.trustAsHtml(retorno.data.html);
        $scope.forms = retorno.data.html;
        for(item in $scope.forms ){
            $scope.forms[item].value=' ';
            $scope.Answers.push($scope.forms[item]);
        }
    });
    

    EventoService.buscaTipoEventos().then(function(retorno){
        $scope.typesOptions = retorno.data;
    });

    $scope.nextStep = function()
    {
        $scope.tab++;
    }

    $scope.prevStep = function()
    {
        $scope.tab--;
    }

    $scope.loading_lembrete = true;
    $scope.erro_lembrete = '';
    $scope.sucesso_lembrete = false;

    $scope.sendFormEvent = function(){

        var errosLocal = 0;
        for(item in $scope.Answers ){
            console.log($scope.forms[item].value);
            if($scope.Answers[item].value == " "){
                $scope.errorLocal = 1;
                errosLocal += 1;
            }
        }
        var token = $cookies.get('chef');
        var dados = $scope.eventoFormData;
        var info = new Array();
        var obj = {};
        var objFields = {};

        dados.pictures = $scope.pictures;
        dados.user_id = $cookies.get('chef');

        for(item in $scope.Answers ){
            objFields[$scope.Answers[item].namefields] = $scope.Answers[item].value;
        }

        dados.fields = objFields;

        EventoService.cadastrarEvento(dados).then(function(result){
            if(result.data.status == 'ok'){
                $mdDialog.show(
                    $mdDialog.alert()
                        .clickOutsideToClose(true)
                        .title('Parabéns')
                        .textContent('Seu evento foi cadastrado com sucesso')
                        .ariaLabel('Seu evento foi cadastrado com sucesso')
                        .ok('Ok')
                ).finally(function() {
                    location.href="#!/painel";
                });
            } else {
                $mdDialog.show(
                    $mdDialog.alert()
                        .clickOutsideToClose(true)
                        .title('Atenção')
                        .htmlContent(result.data.msg)
                        .ariaLabel(result.data.msg)
                        .ok('Ok')
                );
            }
        });
    }

    $scope.resgataEndereco = function(){
        var cep = $scope.eventoFormData.zipcode;
        EventoService.buscaCEP(cep).then(function(retorno){
            var endereco = retorno.data;
            var logradouro = endereco.tipo_logradouro+" "+endereco.logradouro;
            var bairro = endereco.bairro;
            var cidade = endereco.cidade;
            var estado = endereco.uf;
            var zipcode = cep;

            $scope.eventoFormData.zipcode = zipcode;
            $scope.eventoFormData.street = logradouro;
            $scope.eventoFormData.neighborhood = bairro; 
            $scope.eventoFormData.city = cidade;
            $scope.eventoFormData.state = estado; 
        });
    }

    $scope.tornarPrincipal = function(index){
        for(foto in $scope.pictures){
            $scope.pictures[foto].principal = '0';
        }

        $scope.pictures[index].principal = '1'; 
    }


    $scope.excluirImagem = function(index){
        $scope.pictures.splice(index, 1);

        if($scope.pictures.length > 0){
            var contador = 1;
            for(foto in $scope.pictures){
                if(contador == 1){
                    $scope.pictures[foto].principal = '1';
                }else{
                    $scope.pictures[foto].principal = '0';
                }
                contador++;
            }
        }
    }

    $scope.$watch('imagem_upload',function(){

        if($scope.imagem_upload){
            var dados = {
                'photo': $scope.imagem_upload,
            }
            $rootScope.loading_content = true;
            $scope.erro_upload = '';
            EventoService.upload(dados).then(function(result){
                $rootScope.loading_content = false;
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
                    novoObj.imagem = result.data.upload_data.href;
                    novoObj.href = result.data.upload_data.href; 
                    if(isEmpty($scope.pictures) == true){
                        novoObj.principal = "1";
                    }else{
                        novoObj.principal = "0";
                    }
                
                    $scope.pictures.push(novoObj);
                }
            });
        }
    });
});
