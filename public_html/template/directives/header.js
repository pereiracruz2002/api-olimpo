angular.module('header', [])
	.directive('headernav', function(){
	    return{
	        restrict:'E',
            controller: function($scope, $location, UsuarioService, $mdSidenav)
            {
                $scope.meu_menu = false;
                $scope.toggleSidenav = function(menuId) {
                    $mdSidenav(menuId).toggle();
                };
            },
	        templateUrl:'template/views/header.html'
	    };
   	},'');
