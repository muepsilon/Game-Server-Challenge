require 'securerandom'

module ModelHelpers
  def self.generate_uuid
    SecureRandom.uuid
  end

  def self.broadcast_info gameid
    params = {:game_id => gameid }
    new_info = Api::Game.info params
    WebsocketRails[:play].trigger 'push_info', new_info
  end
end