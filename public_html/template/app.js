App.config(['$routeProvider', '$locationProvider', '$mdThemingProvider', '$mdDateLocaleProvider', 
    function($routeProvider, $locationProvider, $mdThemingProvider, $mdDateLocaleProvider) {
        $locationProvider.hashPrefix('!');
        $mdDateLocaleProvider.formatDate = function(date) {
            if(date){
                var month = date.getMonth();
                var day = date.getDate();
                var year = date.getFullYear();
                month = month + 1;
                month = month + "";

                if (month.length == 1){
                    month = "0" + month;
                }
                day = day + "";

                if (day.length == 1){
                    day = "0" + day;
                }
                return day +'/'+month +'/'+ year;
            }
        };
        $mdThemingProvider.theme('default')
                          .primaryPalette('deep-purple', {
                              'default': '500',
                              'hue-1': '50'
                          })
                          .accentPalette('blue');

        $mdThemingProvider.theme('input', 'default')
                          .primaryPalette('grey')
        $routeProvider
            .when('/', {
                templateUrl: '/template/views/login.html',
                controller: 'LoginController'
            })
            .when('/painel', {
                templateUrl: '/template/views/painel.html',
                controller: 'PainelController'
            })
            .when('/evento/novo', {
                templateUrl: '/template/views/evento.html',
                controller: 'EventoController'
            }).when('/eventos/:id', {
                templateUrl: '/template/views/evento_detalhes.html',
                controller: 'EventoDetalhesController'
            }).when('/amigo/convidado/:evento/:convidado', {
                templateUrl: '/template/views/evento_convidado_detalhes.html',
                controller: 'ConvidadoDetalhesController'
            }).when('/amigo/convite/', {
                templateUrl: '/template/views/convite_amigo.html',
                controller: 'AmigoController'
            }).when('/editar', {
                templateUrl: '/template/views/editar.html',
                controller: 'EditarController'
            })
            .otherwise({
                redirectTo:'/'
            });
    }
]).run(['$rootScope','$location','UsuarioService', '$cookies',
    function(rootScope,location,UsuarioService, $cookies) {
        rootScope.$on('$routeChangeStart', function() {
            if(location.path() != '/'){
                if(!UsuarioService.isLogged()){
                    location.path('/');
                }
            }
        });

        if($cookies.get('chef')){
            UsuarioService.getInfo().then(function(result){
               rootScope.user = result.data;
            });
        }

        var forceSSL = function () {
            if (location.protocol() !== 'https') {
                window.location.href = location.absUrl().replace('http', 'https');
            }
        };
        //forceSSL();
    }
]);

App.filter('trustAsHTML', ['$sce', function($sce){
    return function(text) {
        return $sce.trustAsHtml(text);
    };
}]);

function number_format(number, decimals, dec_point, thousands_sep) {
    number = (number + '').replace(',', '').replace(' ', '');
    var n = !isFinite(+number) ? 0 : +number,
            prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
            sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep, dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
            s = '',
            toFixedFix = function(n, prec) {
        var k = Math.pow(10, prec);
        return '' + Math.round(n * k) / k;
    };
    // Fix for IE parseFloat(0.55).toFixed(0) = 0;
    s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
    if (s[0].length > 3) {
        s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
    }
    if ((s[1] || '').length < prec) {
        s[1] = s[1] || '';
        s[1] += new Array(prec - s[1].length + 1).join('0');
    }
    return s.join(dec);
}

App.filter('formatar_preco', function(){
    return function(valor) {
        return number_format(valor, 2, ',','.');
    };
});

App.filter('formatar_datetime', function(){
    return function(datetime) {
        var hora = datetime.split(' ');
        var data = hora[0].split('-');
        return data[2]+'/'+data[1]+'/'+data[0]+' '+hora[1];
    };
});

App.filter('split', function() {
    return function(input) {
        return input.split(',');
    }
});

App.directive('fileModel', ['$parse', function ($parse) {
    return {
        restrict: 'A',
        link: function(scope, element, attrs) {
            var model = $parse(attrs.fileModel);
            var modelSetter = model.assign;

            element.bind('change', function(){
                scope.$apply(function(){
                    modelSetter(scope, element[0].files[0]);
                });
            });
        }
    };
}]);

App.directive('format', ['$filter', function ($filter) {
    return {
        require: '?ngModel',
        link: function (scope, elem, attrs, ctrl) {
            if (!ctrl) return;

            ctrl.$formatters.unshift(function (a) {
                return $filter(attrs.format)(ctrl.$modelValue)
            });

            ctrl.$parsers.unshift(function (viewValue) {
                if (viewValue.length <= 3) {
                    viewValue = '00'+viewValue;
                }
                var value = viewValue;
                value = value.replace(/\D/g,"");
                value = value.replace(/(\d{2})$/,",$1");
                value = value.replace(/(\d+)(\d{3},\d{2})$/g,"$1.$2");
                var qtdLoop = (value.length-3)/3;
                var count = 0;
                while (qtdLoop > count)
                {
                    count++;
                    value = value.replace(/(\d+)(\d{3}.*)/,"$1.$2");
                }
                var plainNumber = value.replace(/^(0)(\d)/g,"$2");

                elem.val(plainNumber);
                return plainNumber;
            });

            elem.bind('blur', function () {
                var valueFilter = elem.val();
                valueFilter = valueFilter.replace(/\D/g,"");
                if (attrs.zeroFilter == 'true') {
                    if (valueFilter == 0) {
                        elem.val('');
                    }
                }
            });
        }
    };
}]);

