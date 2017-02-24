App.controller('ConvidadoDetalhesController', function ($rootScope, $scope, EventoService, $location,URL_API,$routeParams,$cookies){

    var evento = $routeParams.evento;
    var convidado = $routeParams.convidado;

    var dados = "convidado="+convidado+"&evento="+evento;

    $scope.cliente = '';

    EventoService.buscarAmigo(dados).then(function(retorno){


        $scope.cliente = retorno.data.usuario;

        console.log($scope.cliente);

    });

});
