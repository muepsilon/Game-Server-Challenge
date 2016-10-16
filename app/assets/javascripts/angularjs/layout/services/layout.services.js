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

    var Layout = {
      new_game: new_game,
      start_game: start_game,
      join_game: join_game,
      game_info: game_info,
      play_game: play_game,
    };

    return Layout;
  }

  function new_game(nick){
    url = $location.origin + '/api/game/new';
    return $http.post(url,{"nick": nick});
  }
  
  function start_game(game_id,player_id){
    url = $location.origin + '/api/game/start';
    return $http.post(url,{"game_id": game_id,"player_id":player_id});
  }
  function join_game(game_id, nick){
    url = $location.origin + '/api/game/join';
    return $http.post(url,{"nick": nick,"game_id": game_id});
  }
  function game_info(game_id,player_id){
    url = $location.origin + '/api/game/info?game_id=' + game_id + "&player_id=" + player_id;
    return $http.get(url);
  }
  function play_game(game_id,player_id,word_indexes){
    url = $location.origin + '/api/game/play';
    return $http.post(url,{"game_id": game_id, "player_id": player_id, "word_indexes": word_indexes});
  }
})();
