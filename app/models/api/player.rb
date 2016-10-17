class Api::Player < ::Player

  include ModelHelpers
  
  def self.new nick, game_id, admin = false
    Player.create(playerid: ModelHelpers::generate_uuid, admin: admin, game_id: game_id, nick: nick) rescue nil
  end

  def self.get_scores game_id
    players = Player.where(game_id: game_id).select(:id,:playerid,:nick,:points).as_json
    scores = {}
    players.each do |player|
      if player["nick"].nil? or player["nick"].empty?
        scores[player["playerid"]] = player["points"]
      else
        scores[player["nick"]] = player["points"]
      end
    end
    scores
  end

  def self.join_sequence game_id
    players = Player.where(game_id: game_id).select(:id,:playerid,:nick).order(:created_at).as_json
    join_seqn = {}
    players.each_with_index do |player,index|
      join_seqn[player['id']] = index
    end
    return join_seqn, players
  end

  def self.last_player game_id
    MoveSequence.where(game_id: game_id).order("id DESC").limit(1).pluck(:player_id).first rescue 0
  end

  def self.current_player game_id
    last_player_id = last_player game_id
    join_seqn, players = join_sequence game_id
    current_index = (join_seqn[last_player_id]+1)%players.length rescue 0
    players[current_index]
  end

  def self.turn_seq game_id
    last_player_id = last_player game_id
    join_seqn, players = join_sequence game_id
    current_index = (join_seqn[last_player_id]+1)%players.length rescue 0
    seq = []
    (0..players.length-1).each do |i|
      seq.push(players[(current_index+i)%players.length]["nick"])
    end
    seq
  end
end
