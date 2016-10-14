class Game < ActiveRecord::Base
  has_many :player
  has_many :move_sequence
  has_one :grid

  validates :gameid, uniqueness: true

end
