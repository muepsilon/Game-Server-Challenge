/**
* gameController
* @namespace gserver.layout.controllers
*/
(function () {
  'use strict';

  angular
    .module('gserver.layout.controllers')
    .controller('gameController', gameController);

  gameController.$inject = ['$scope','Layout'];

  /**
  * @namespace gameController
  */
  function gameController($scope, Layout) {

    var vm = this;
    vm.game_info = {};
  };
})();
