class Api::Word < ::Word

  def self.identified_words game_id
    Word.joins(:grid).where("grids.game_id = ?", game_id).pluck(:word)
  end
  
  def self.assign_points word
    isValid = DictWord.is_valid? word
    if isValid
      if Word.where(word: word).count == 0
        word.length*word.length
      else
        0
      end
    else
      0
    end        
  end  
end
