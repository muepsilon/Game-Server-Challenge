class DictWord < ActiveRecord::Base
  validates :word, uniqueness: true

  def self.is_valid? word
    words = self.where(word: word.downcase)
    if words.count > 0
      true
    else
      false
    end 
  end
end
