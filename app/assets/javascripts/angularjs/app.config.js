(function () {
  'use strict';

  angular
    .module('gserver.config')
    .config(config);

  config.$inject = ['$locationProvider', '$sceDelegateProvider'];

  /**
  * @name config
  * @desc Enable HTML5 routing
  */
  function config($locationProvider, $sceDelegateProvider) {

    $sceDelegateProvider.resourceUrlWhitelist(['self']);
    $locationProvider.html5Mode(true);
    $locationProvider.hashPrefix('!');
  }
})();