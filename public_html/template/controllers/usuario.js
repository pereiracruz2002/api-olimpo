FacilemeApp.controller('UsuarioLoginController', function ($rootScope, $scope, UsuarioService, $location){
    $scope.loading = false;
    $rootScope.pageTitle = 'Entrar';
    $scope.facebookLogin = function()
    {
        $scope.erro_msg = false;    
        $scope.loading = true;
        FB.login(function(response){
            if(response.authResponse){
                UsuarioService.facebookLogin(response.authResponse).then(function(result){
                    if(result.data.erro){
                        $scope.erro_msg = result.data.msg;
                    } else {
                        $rootScope.usuario = result.data.dados;
                        $rootScope.isLogged = true;
                        $location.path('/cliente/');
                    }
                    $scope.loading = false;
                });
            }else{
                $scope.loading = false;
                $rootScope.menu_usuario = false;
            }
        },{scope: 'email,user_birthday'});
    }

    $scope.doLogin = function(obj){
        var dados = $(obj.target).serialize();
        $scope.erro_msg = false;    
        $scope.loading = true;

        UsuarioService.login(dados).then(function(result){
            $scope.loading = false;
            $rootScope.menu_usuario = false;
            if (result.data.status == 'erro') {
                $scope.erro_msg = result.data.msg;
            } else {
                $rootScope.usuario = result.data.dados;
                $rootScope.isLogged = true;
                $location.path('/cliente/');
            }
        });
    }


})
.controller('UsuarioLembreteController', function ($rootScope, $scope, UsuarioService){
    $scope.loading = false;
    $rootScope.pageTitle = 'Esqueci minha senha';
    $scope.lembrarSenha = function(obj){
        var dados = $(obj.target).serialize();
        $scope.erro_lembrete_msg = false;    
        $scope.success_lembrete_msg = false;    
        $scope.loading = true;
        UsuarioService.lembrarSenha(dados).then(function(result){
            $scope.loading = false;
            if(result.data.status == 'erro'){
                $scope.erro_lembrete_msg = result.data.msg;    
                $scope.success_lembrete_msg = false;    
            } else {
                $scope.erro_lembrete_msg = false;    
                $scope.success_lembrete_msg = result.data.msg;    
            }
        });

    }

})

.controller('UsuarioNovaSenhaController', function ($rootScope, $scope, $routeParams, UsuarioService){
    $scope.loading = false;
    $scope.trocarSenha = false;
    $scope.erro_msg = false;
    $scope.senhaAlterada = false;
    $rootScope.pageTitle = 'Nova Senha';

    UsuarioService.validarRecover($routeParams.hash).then(function(result){
        if(result.data.status == 'ok'){
            $scope.trocarSenha = true;
        } else {
            $scope.erro_msg = result.data.msg;
        }
    });

    $scope.novaSenha = function(obj){
        if($scope.senha != $scope.senha2){
            $scope.erro_msg = 'As senhas estão diferentes';
        } else {
            var dados = $(obj.target).serialize();
            $scope.erro_msg= false;
            $scope.loading = true;
            UsuarioService.trocarSenha($routeParams.hash, dados).then(function(result){
                $scope.loading = false;
                if(result.data.status == 'erro'){
                    $scope.erro_msg= result.data.msg;    
                } else {
                    $scope.trocarSenha = false;
                    $scope.senhaAlterada = true;
                }
            });
        }

    }

})
.controller('UsuarioPainelController', function ($rootScope, $scope, UsuarioService){
    $rootScope.pageTitle = 'Painel';
    $scope.pedidos = [];
    $rootScope.menu_usuario = false;

    UsuarioService.getPedidos().then(function(result){
        $scope.pedidos = result.data;
    });
})

.controller('UsuarioPedidoController', function ($rootScope, $scope, $routeParams, UsuarioService, $location){
    $rootScope.pageTitle = 'Detalhes do Pedido #'+$routeParams.id;
    $scope.pedido = {};

    UsuarioService.getPedido($routeParams.id).then(function(result){
        if(result.data.status == 'ok'){
            $scope.pedido = result.data.dados;
        } else {
            $location.path('/cliente/')
        }
    });
})
.controller('UsuarioDadosController', function ($rootScope, $scope, $sce, UsuarioService){
    $scope.loading = false;
    $rootScope.pageTitle = 'Meus Dados';
    $scope.sucesso_msg = false;
    $scope.erro_msg = $sce.trustAsHtml('');

    $scope.alterarDados = function(obj){
        var dados = $(obj.target).serialize();
        $scope.loading = true;
        $scope.sucesso_msg = false;
        $scope.erro_msg = '';
        UsuarioService.editarCadastro(dados).then(function(result){
            if(result.data.status == 'erro'){
                $scope.erro_msg = result.data.msg;
            } else {
                $scope.sucesso_msg = result.data.msg;
            }
            $scope.loading = false;
            $('html, body').animate({
                scrollTop: 0 
            }, 800);
        });
    }
}).controller('UsuarioRegistrarController', ['$rootScope', '$scope', 'UsuarioService', '$location', '$sce', function (rootScope, scope, UsuarioService, $location, sce){
    scope.loading = false;
    rootScope.loading_content = false;
    rootScope.pageTitle = 'Cadastre-se';
    
    scope.erro_msg = sce.trustAsHtml('');
    scope.sucesso_msg = sce.trustAsHtml('');
    scope.cadastrar = function(obj){
        scope.erro_msg = '';
        scope.sucesso_msg = '';
        scope.loading = true;
        var dados = $(obj.target).serialize();
        UsuarioService.cadastrar(dados).then(function(result){
            if(result.data.status == 'erro') {
                scope.erro_msg = result.data.msg;
            } else {
                scope.sucesso_msg = result.data.msg;
                rootScope.usuario = result.data.dados;
                rootScope.isLogged = true;
            }
            scope.loading = false;
            $('html, body').animate({
                scrollTop: 0 
            }, 800);

        });
    }
}])
.filter('formata_data', function(){
    return function(data) {
        if(typeof data != "undefined"){
            var temp = data.split('-');
            return temp[2]+"/"+temp[1]+"/"+temp[0];
        } else {
            return data;
        }

    };
})
.filter('formata_time', function(){
    return function(data) {
        if(typeof data != "undefined"){
            var hora = data.split(' ');
            var temp = hora[0].split('-');
            return temp[2]+"/"+temp[1]+"/"+temp[0]+' '+hora[1];
        } else {
            return data;
        }
    };
});

