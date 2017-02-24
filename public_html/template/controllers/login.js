App.controller('LoginController', function ($rootScope, $scope, UsuarioService, $location, $timeout, $cookies, $mdDialog){
    $scope.tab=1;
    $scope.loginFormData = {
        'email': '',
        'password': ''
    }
    $scope.lembreteFormData = {
        'email': ''
    }
    if(UsuarioService.isLogged()){
        $location.path('/painel');
    }


    $scope.doLogin = function()
    {
        $scope.loading_login = true;
        UsuarioService.login($scope.loginFormData).then(function(result){
            if(result.data.status == 'success'){
                $cookies.put('chef', result.data.token);
                $location.path('/painel');
            } else {
                $mdDialog.show(
                        $mdDialog.alert()
                        .title('Atenção')
                        .textContent(result.data.msg)
                        .ariaLabel(result.data.msg)
                        .ok('Ok')
                );
                $scope.loading_login = false;
            }
        });
    }

    $scope.erro_lembrete = '';
    $scope.loading_lembrete = false;
    $scope.sucesso_lembrete = false;
    $scope.lembrete= function()
    {
        $scope.loading_lembrete = true;
        $scope.erro_lembrete = '';
        $scope.sucesso_lembrete = false;
        var dados = "email="+$scope.lembreteFormData.email;
        UsuarioService.lembrarSenha(dados).then(function(result){
            $scope.loading_lembrete = false;
            if(result.data.status == 'success'){
                $scope.sucesso_lembrete = true;
            } else {
                $scope.erro_lembrete = result.data.msg;
                $mdDialog.show(
                        $mdDialog.alert()
                        .title('Atenção')
                        .textContent(result.data.msg)
                        .ariaLabel(result.data.msg)
                        .ok('Ok')
                );

            }
        });
    }


    $scope.fbLogin = function(){
        $scope.loading_login = true;
        FB.login(function(response) {
            if (response.authResponse) {
                UsuarioService.fblogin({accessToken: response.authResponse.accessToken}).then(function(response){
                    if(response.data.status == 'success'){
                        $cookies.put('chef', response.data.token);
                        $location.path('/painel');
                    } else {
                        $mdDialog.show(
                                $mdDialog.alert()
                                .title('Atenção')
                                .textContent(response.data.msg)
                                .ariaLabel(response.data.msg)
                                .ok('Ok')
                        );

                        $scope.loading_login = false;
                    }
                });
            } else {
             console.log('User cancelled login or did not fully authorize.');
            }
        },{scope: 'email'});


    }
});
