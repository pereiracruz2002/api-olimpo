angular.module('App')
.factory('UsuarioService', function($http, URL_API, $httpParamSerializerJQLike, $cookies){
    var factory = {};

	factory.getInfo = function () 
    {
        return $http({
            method: 'POST',
            data: 'token='+$cookies.get('chef'), 
            url: URL_API+'usuario/info',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    };

    
    factory.listaAmigos = function () 
    {
        return $http({
            method: 'POST',
            data: 'token='+$cookies.get('chef'), 
            url: URL_API+'usuario/getListFriends',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    };

    factory.convidarAmigos = function (dados) 
    {
        return $http({
            method: 'POST',
            data: $httpParamSerializerJQLike(dados), 
            url: URL_API+'usuario/convidaAmigos',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    };

    factory.aprovarChef = function(friend_id)
    {
        var dados = {
            'token' : $cookies.get('chef'),
            'friend_id': friend_id
        }
        return $http({
            method: 'POST',
            data: $httpParamSerializerJQLike(dados),
            url: URL_API+'usuario/aprovarChef',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    }

	factory.getSolicitacoes = function () 
    {
        return $http({
            method: 'GET',
            url: URL_API+'usuario/solitacoesChef/'+$cookies.get('chef')
        });
    };

	
	factory.logout = function () 
    {
        return $http({
            method: 'GET',
            url: URL_API+'usuario/logout',
        });
    };

    factory.isLogged = function()
    {
        return $cookies.get('chef');
    };

    factory.validarRecover = function(hash)
    {
        return $http({
            method: 'GET',
            url: URL_API+'usuarios/novasenha/'+hash,
        });
    };
    factory.trocarSenha = function(hash, dados)
    {
         return $http({
            method: 'POST',
            url: URL_API+'usuarios/novasenha/'+hash,
            data: dados,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    };
    factory.salvar = function(dados)
    {
         return $http({
            method: 'POST',
            url: URL_API+'usuarios/atualizar/',
            data: dados,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    };


    factory.login = function(dados)
    {
         return $http({
            method: 'POST',
            url: URL_API+'usuario/login',
            data: $httpParamSerializerJQLike(dados),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    };

    factory.fblogin = function(dados)
    {
         return $http({
            method: 'POST',
            url: URL_API+'usuario/fblogin',
            data: $httpParamSerializerJQLike(dados),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    };

    factory.cadastrar = function(dados)
    {
         return $http({
            method: 'POST',
            url: URL_API+'usuario/cadastro',
            data: dados,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    }

    factory.lembrarSenha = function(dados)
    {
         return $http({
            method: 'POST',
            url: URL_API+'usuario/lembrarSenha',
            data: dados,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    }


    factory.isConfigured = function()
    {
         return $http({
            method: 'GET',
            url: URL_API+'usuario/isConfigured'
        });
    }

    factory.getUrlIntegracao = function()
    {
         return $http({
            method: 'GET',
            url: URL_API+'usuario/getUrlIntegracao'
        });
    }


    factory.updatePicture = function(imagem)
    {
        var dados = {
            'token' : $cookies.get('chef'),
            'imagem': imagem
        }
        return $http({
            method: 'POST',
            data: $httpParamSerializerJQLike(dados),
            url: URL_API+'usuario/updatePicture',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    }

    factory.importContactsGmail = function(){

        var dados = {
            'token' : $cookies.get('chef')
        }

        return $http({
            method: 'POST',
            data: $httpParamSerializerJQLike(dados),
            url: URL_API+'usuario/importContactsGmail',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        });
    }

    return factory;
});
