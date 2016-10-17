class Game < ActiveRecord::Base
  
  has_many :player
  has_many :move_sequence
  has_one :grid

  validates :gameid, uniqueness: true
  enum status: [ :waiting, :in_play,:completed ]

  def self.find_or_nil gameid
    self.where(gameid: gameid).first rescue nil
  end
end
