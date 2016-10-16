/**
* homeController
* @namespace gserver.layout.controllers
*/
(function () {
  'use strict';

  angular
    .module('gserver.layout.controllers')
    .controller('homeController', homeController);

  homeController.$inject = ['$scope','Layout','$state','$timeout','$cookies'];

  /**
  * @namespace homeController
  */
  function homeController($scope, Layout,$state,$timeout,$cookies) {

    var vm = this;
    vm.joinGame = {};
    vm.startGame = {};
    vm.newGame = {};
    vm.infoGame = {};
    vm.showjoinform = false;
    vm.showstartform = false;
    vm.shownewgameform = false;
    vm.showgameinfoform = false;
    vm.start_game = start_game;
    vm.join_game = join_game;
    vm.new_game = new_game;
    vm.go_to_game = go_to_game;
    vm.showErrorMessage = false;
    vm.errorMessage = '';
    vm.showMessage = showMessage;

    function start_game () {
      Layout.start_game(vm.startGame.gameid,vm.startGame.playerid)
      .then(function successCallback (response) {
        if(response.data.success == true){
          $state.go('game',{"game_id":vm.startGame.gameid, "player_id": vm.startGame.playerid}); 
        } else {
          vm.showMessage(response.data.message);
        }
      },function failureCallback (response) {
        // body...
      })
    }
    function join_game () {
      Layout.join_game(vm.joinGame.gameid, vm.joinGame.nick)
      .then(function successCallback (response) {
        var data = response.data;
        if (data.registered) {
          $cookies.put('gameid',vm.joinGame.gameid);
          $cookies.put('playerid',data.player_id);
          $state.go('game',{"game_id":vm.joinGame.gameid, "player_id": data.player_id});          
        } else{
          vm.showjoinform = false;
          vm.showMessage("Unable to join game");
        }
      },function failureCallback (response) {
        vm.showjoinform = false;
        vm.showMessage("Unable to join game");
      });
    }
    function new_game () {
      Layout.new_game(vm.newGame.nick)
      .then(function successCallback (response) {
        $cookies.put('gameid',response.data.game_id);
        $cookies.put('playerid',response.data.player_id);
        $state.go('game',{"game_id":response.data.game_id, "player_id": response.data.player_id});
      },function failureCallback (response) {
        // body...
      });
    }
    function go_to_game () {
      Layout.game_info(vm.infoGame.gameid)
      .then(function successCallback (response) {
        if (response.data.grid.length > 0) {
          $state.go('game',{"game_id": vm.infoGame.gameid, "player_id": response.data.player_id});
        } else {
          vm.showMessage("No such game");
        }
      },function failureCallback (response) {
        console.log(response);
        // body...
      });
    }
    function showMessage (msg) {
      vm.errorMessage = msg;
      vm.showErrorMessage = true;
      $timeout(function() {
        vm.errorMessage = '';
        vm.showErrorMessage = false;
      }, 3000);
    }
  };
})();
