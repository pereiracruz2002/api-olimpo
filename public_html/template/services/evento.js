angular.module('App')
.factory('EventoService', function($http, URL_API, $httpParamSerializerJQLike, $cookies){
    var factory = {};

	factory.buscaTipoEventos = function () 
    {
        return $http({
            method: 'GET',
            url: URL_API+'evento/getTypes',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    };


    factory.buscaInfoTipoEventos = function () 
    {
        
        return $http({
            method: 'GET',
            url: URL_API+'evento/getInfoTipoEventos',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    };

    factory.getEvento = function(evento_id, token)
    {
        return $http({
            method: 'POST',
            url: URL_API+'evento/info/'+evento_id,
            data: 'token='+token,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    }

    factory.cadastrarEvento = function (dados) 
    {
    	
        return $http({
            method: 'POST',
            url: URL_API+'evento/novo/',
            data: $httpParamSerializerJQLike(dados),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    };

    factory.setImagemPrincipal = function(dados)
    {
        return $http({
            method: 'POST',
            url: URL_API+'evento/setImagemPrincipal/',
            data: $httpParamSerializerJQLike(dados),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });   
    }

    factory.removerImg = function(dados)
    {
        return $http({
            method: 'POST',
            url: URL_API+'evento/deleteImg/',
            data: $httpParamSerializerJQLike(dados),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });   
    }


    factory.update = function (dados) 
    {
        return $http({
            method: 'POST',
            url: URL_API+'evento/atualizar/',
            data: $httpParamSerializerJQLike(dados),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    };

    factory.buscaCEP = function(cep){

        var urlcomcep = "http://cep.republicavirtual.com.br/web_cep.php?cep="+cep+"&formato=json";

        return $http({
            method: 'GET',
            url: urlcomcep,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
        
    }

    factory.listaEventos = function(dados)
    {
         return $http({
            method: 'POST',
            url: URL_API+'evento/listaEventos',
            data: 'token='+dados,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    }

    factory.listaUsuariosNaoCadastradosNoEvento = function(dados)
    {
         return $http({
            method: 'POST',
            url: URL_API+'usuario/listagemUsuariosNaoConvidados',
            data: dados,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    }


    factory.listaUsuariosCadastradosNoEvento = function(dados)
    {
         return $http({
            method: 'POST',
            url: URL_API+'usuario/listagemUsuariosConvidados',
            data: dados,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    }

    factory.convidarAmigo = function(dados)
    {
         return $http({
            method: 'POST',
            url: URL_API+'usuario/convidar',
            data: dados,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });

    }

    factory.buscarAmigo = function(dados)
    {
         return $http({
            method: 'POST',
            url: URL_API+'usuario/buscaAmigoEvento',
            data: dados,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });

    }

    factory.convidarEmail = function(dados)
    {
         return $http({
            method: 'POST',
            url: URL_API+'usuario/convidarPorEmail',
            data: dados,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });

    }

     factory.convidarListaAmigos = function(dados){
         return $http({
            method: 'POST',
            url: URL_API+'usuario/convidarLista',
            data: dados,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
     }

     factory.upload = function (dados) 
         {
             var postData = new FormData();
             angular.forEach(dados, function(value, key){
                 postData.append(key, value);
             });
             return $http.post(URL_API+'foto/upload', postData, {
                 headers: {'Content-Type': undefined},
                 transformRequest: angular.identity
             });
         };

    return factory;
});
