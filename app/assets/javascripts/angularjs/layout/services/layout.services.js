(function () {
  'use strict';

  angular
    .module('gserver.layout.services')
    .factory('Layout', Layout);

  Layout.$inject = ['$http','$location'];

  /**
  * @namespace Layout
  * @returns {Factory}
  */
  function Layout($http,$location) {

    var url_base = $location.protocol() + "://" + $location.host() + ":" + $location.port(); 

    var Layout = {
      new_game: new_game,
      start_game: start_game,
      join_game: join_game,
      game_info: game_info,
      play_game: play_game,
    };

    return Layout;

    function new_game(nick){
      return $http.post(url_base + '/api/game/new',{"nick": nick});
    }
    
    function start_game(game_id,player_id){
      return $http.post(url_base + '/api/game/start',{"game_id": game_id,"player_id":player_id});
    }
    function join_game(game_id, nick){
      return $http.post(url_base + '/api/game/join',{"nick": nick,"game_id": game_id});
    }
    function game_info(game_id,player_id){
      var url = url_base + '/api/game/info?game_id=' + game_id + "&player_id=" + player_id;
      return $http.get(url);
    }
    function play_game(game_id,player_id,word){
      return $http.post(url_base + '/api/game/play',{"game_id": game_id, "player_id": player_id, "word": word});
    }
  }
})();
