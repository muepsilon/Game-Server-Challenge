(function () {
  'use strict';

  angular
    .module('gserver.routes')
    .config(config);

  config.$inject = ['$stateProvider', '$urlRouterProvider'];

  /**
  * @name config
  * @desc Define valid application routes
  */
  function config($stateProvider, $urlRouterProvider) {

    $stateProvider
    .state('home', {
      url:'/',
      controller:"homeController",
      controllerAs:"vm",
      templateUrl:"templates/partials/home.html"
    })
    .state('game', {
      url:'/game?:game_id&:player_id',
      params: {
        game_id: null,
        player_id: null
      },
      controller:"gameController",
      controllerAs:"vm",
      templateUrl:"templates/partials/game.html"
    });
  }
})();
