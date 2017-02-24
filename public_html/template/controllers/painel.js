App.controller('PainelController', function ($rootScope, $scope, UsuarioService,EventoService,$cookies, $mdSidenav){
    $rootScope.loading_content = true;
    $rootScope.pageTitle = 'Painel';

    $scope.eventos = [];
    $scope.solitacoes = [];

    var token = $cookies.get('chef');

    if(!$rootScope.user){
        UsuarioService.getInfo().then(function(result){
            $rootScope.user = result.data;
        });
    }

    EventoService.listaEventos(token).then(function(retorno){
        $scope.eventos = retorno.data;
        
    });


    UsuarioService.getSolicitacoes().then(function(result){
        $scope.solitacoes = result.data;
    });

    $scope.aprovarChef = function(key, friend)
    {
        $scope.solitacoes.splice(key, 1);
        UsuarioService.aprovarChef(friend.user_id).then(function(result){
        
        });
    }
});

