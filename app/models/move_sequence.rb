class MoveSequence < ActiveRecord::Base
  belongs_to :player
  belongs_to :game

  validates :score, numericality: true
  validates :word, allow_nil: true
end
