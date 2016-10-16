/**
* homeController
* @namespace gserver.layout.controllers
*/
(function () {
  'use strict';

  angular
    .module('gserver.layout.controllers')
    .controller('homeController', homeController);

  homeController.$inject = ['$scope','Layout'];

  /**
  * @namespace homeController
  */
  function homeController($scope, Layout) {

    var vm = this;
  };
})();
