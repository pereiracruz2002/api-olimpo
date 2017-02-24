angular.module('navbar', [])
	.directive('navbar', function(){
	    return{
	        restrict:'E',
            replace: true,
            controller: function($scope, $rootScope, $location,$cookies){

                $scope.goTo = function(url)
                {
                    $location.path(url);
                }

                $scope.toggleSidenav = function(menuId) {
                    $mdSidenav(menuId).toggle();
                };
                $scope.menu = [
                    {
                      link : '/painel',
                      title: 'Início',
                      icon: 'dashboard'
                    },
                    {
                      link : '/amigo/convite/',
                      title: 'Amigos',
                      icon: 'group'
                    },
                    {
                      link : '/editar/',
                      title: 'Editar Dados',
                      icon: 'edit'
                    },
                    {
                      link : '',
                      title: 'Mensagens',
                      icon: 'message'
                    },
                ];

                $scope.admin = [
                    {
                      link : '/evento/novo',
                      title: 'Cadastrar Evento',
                      icon: 'local_play'
                    },
                    {
                      link : '',
                      title: 'Configurações',
                      icon: 'settings'
                    }
                ];
            	$scope.logout = function(){
            		$cookies.remove('chef');
                    $rootScope.user = {};
            		$location.path('/');
            	};
            },
	        templateUrl:'template/views/nav.html'
	        };
   	},'');
