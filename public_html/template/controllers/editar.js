App.controller('EditarController', function ($rootScope,$mdDialog, $scope, UsuarioService,EventoService, $location,URL_API,$sce,$cookies,$httpParamSerializerJQLike){

    $scope.user = '';

    UsuarioService.getInfo().then(function(retorno){

        $scope.user = retorno.data;

        console.log($scope.user);

    });

    $scope.$watch('imagem_upload',function(){

        //console.log($scope.imagem_upload);

        if($scope.imagem_upload){
            var dados ={
                //'id': $routeParams.id,
                'photo': $scope.imagem_upload,
            }
            $rootScope.loading_content = true;
            $scope.erro_upload = '';
            EventoService.upload(dados).then(function(result){
                
                $rootScope.loading_content = false;
                console.log(result.data.upload_data);
                var novoObj = {};
                novoObj.imagem = result.data.upload_data.file_name;
                novoObj.href = result.data.upload_data.file_name; 

                UsuarioService.updatePicture(result.data.upload_data.file_name).then(function(retorno){
                    console.log(retorno.data);

                    $("#foto-atual img").attr('src',retorno.data.imagem);

                    location.reload();
                });

                
            });

        }
    });
    
});




