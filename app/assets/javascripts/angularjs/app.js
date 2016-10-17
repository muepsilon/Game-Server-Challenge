(function(){
  'use strict';

  angular
    .module('gserver', [
      'gserver.routes',
      'gserver.config',
      'gserver.layout',
      'ngCookies'
    ]).run(run);

  run.$inject = ['$http', '$rootScope', '$location', '$timeout','$rootElement'];

  /**
  * @name run
  * @desc Update xsrf $http headers to align with Django's defaults
  */

  function run($http, $rootScope, $location, $timeout,$rootElement) {
    $rootElement.off('click');
    $http.defaults.xsrfHeaderName = 'X-CSRFToken';
    $http.defaults.xsrfCookieName = 'csrftoken';

    // Show and hide loader for route change
    $rootScope.config = {};
    $rootScope.config.app_url = $location.url();
    $rootScope.config.app_path = $location.path();
    $rootScope.layout = {};
    $rootScope.layout.loading = false;

    $rootScope.$on('$stateChangeStart', function () {
        //show loading gif
        $timeout(function(){
          $rootScope.layout.loading = true;
        });
    });
    $rootScope.$on('$stateChangeSuccess', function () {
        //hide loading gif
        $timeout(function(){
          $rootScope.layout.loading = false;
        }, 200);
    });
    $rootScope.$on('$stateChangeError', function () {

        //hide loading gif
        alert('Something went wrong. Please try reloading the page');
        $rootScope.layout.loading = false;

    });
  }
  
  angular
    .module('gserver.routes', ['ui.router']);

  angular
    .module('gserver.config', []);

})()