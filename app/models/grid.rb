class Grid < ActiveRecord::Base
  belongs_to :game
  has_many :word

end
