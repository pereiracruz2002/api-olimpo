angular.module('rodape', [])
	.directive('rodape', function(){
	    return{
	        restrict:'E',
            controller: function($scope, $rootScope)
            {
            },
	        templateUrl:'template/views/footer.html'
	        };
   	},'');
