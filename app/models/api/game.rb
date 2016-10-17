class Api::Game < ::Game
  include ModelHelpers

  def self.new nick, grid_size=15
    # Create Game
    game = Game.create(gameid: ModelHelpers::generate_uuid)
    # Generate Grid
    grid = Api::Grid.new game.id, grid_size
    # Create playerid
    player = Api::Player.new nick, game.id, true
    # Return params
    {:nick => nick, :player_id => player.playerid, :game_id => game.gameid}
  end

  def self.join params
    # Check if game exist
    game = Game.find_or_nil params[:game_id]
    playerid = nil
    registered  = false
    if game and game.status != Game.statuses[:completed]
      player = Api::Player.new params[:nick], game.id
      if player and not player.id.nil?
        playerid = player.playerid
        registered = true
      end
    end
    ModelHelpers::broadcast_info(params[:game_id])
    {:nick => params[:nick], :player_id => playerid, :registered => registered }
  end

  def self.start params
    text = ''
    success = false
    # Check if game exist
    game = Game.find_or_nil params[:game_id]
    if game
      text = game.grid.pluck(:text) rescue ''
      if params[:player_id] and not params[:player_id].empty?
        player = Player.find_or_nil params[:player_id], game.id
        if player and player.admin
          success,msg = update_status game, :in_play, "Game started"
        else
          msg = "Not authorized to start game"
        end
      else
        players = game.player
        if players.count == 1
          success,msg = update_status game, :in_play, "Game started"
        else
          msg = "Provide Player id"
        end
      end
    else
      msg = "Not a valid game id"
    end
    {:grid => text, :message => msg, :success => success}
  end

  def self.info params
    # Check if game exist
    game = Game.find_or_nil params[:game_id]
    if game.nil?
      return {:game_status => '',:gameid => '', :current_player => '',:turn_seq => [], :words_done => [],:scores => [],:grid => '',:grid_size => '',:players => []}  
    end
    # Status
    status = game.status
    # Current Player
    current_player = Api::Player.current_player(game.id)["playerid"] rescue ""
    # Turn sequence
    turn_seq = Api::Player.turn_seq(game.id)
    # Grid
    grid = game.grid
    # Words Done
    words_done = grid.word.pluck(:word)
    # Scores
    scores = Api::Player.get_scores game.id
    # Player id's
    players = convert_players_array_to_hash(game.player.select(:nick,:playerid).to_a)

    {:game_status => status, :gameid => game.gameid,:current_player => current_player,:turn_seq => turn_seq, :words_done => words_done,:scores => scores,:grid => grid.text,:grid_size => grid.size, :players => players}  
  end

  private

  def self.convert_players_array_to_hash players_array
    hash = {}
    players_array.each do |player|
      hash[player[:playerid]] = player[:nick]
    end
    hash
  end
  def self.update_status game, status, msg
    success = false
    game_status = game.status.to_sym
    if game_status != status
      game.status = status
      if game.save
        msg = msg
        success = true
      else
        msg = "Unable to update status to #{msg}"
      end
    elsif game_status == :waiting
      msg = "Waiting to be start"
    elsif game_status == :in_play
      msg = "Game in progress"
    else
      msg = "Game completed"
    end
    return success,msg
  end
end
