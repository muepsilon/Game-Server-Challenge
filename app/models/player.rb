class Player < ActiveRecord::Base
  

  belongs_to :game
  has_many :move_sequence

  validates :playerid, presence: true
  validates :points, numericality: true

  def self.find_or_nil playerid, gameid
    self.where(playerid: playerid).where(game_id: gameid).first rescue nil
  end
end
