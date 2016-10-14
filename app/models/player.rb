class Player < ActiveRecord::Base
  belongs_to :game
  has_many :move_sequence

  validates :playerid, uniqueness: true
  validates :points, numericality: true
  validates :type, presence: true

end
