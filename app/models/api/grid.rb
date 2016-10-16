class Api::Grid < ::Grid

  def self.new gameid, size = 15
    text = generate_grid_text(size)
    Grid.create(game_id: gameid, text: text, size: size)
  end

  def self.get_grid_text_or_nil game_id
    Grid.where(game_id: game_id).pluck(:text).first rescue ''
  end

  def self.verify_word params
    score = 0
    game = Game.find_or_nil params[:game_id]
    # Check if player is according to turn sequence
    if params[:player_id] == Api::Player.current_player(game.id)["playerid"]
      # Get Grid Text
      grid = Grid.where(game_id: game.id).first rescue nil
      
      if grid and grid.text 
        # Identify word
        word = get_word_from_index params[:word_indexes], grid.text, grid.size
        # Check if its a valid word
        if word
          # Assign points
          score = Api::Word.assign_points word
          # Add move to move sequence
          player = Player.find_or_nil params[:player_id], game.id
          MoveSequence.create(score: score, word: word, player_id: player.id, game_id: game.id)
          if score > 0
            Word.create(word: word, grid_id: grid.id)
            player.points+=score
            player.save!
          end
        end
      end
    end
    {:score => score, :success => score > 0}  
  end

  private

  def self.get_word_from_index word_indexes, text, n_columns
    begin
      index_pair = JSON.parse(word_indexes)
      indexes = index_pair.map{ |arr| arr[0]*n_columns + arr[1]}
      word_array = []
      indexes.each do |index|
        word_array.push(text[index])
      end
      word_array.join()
    rescue
      nil
    end
  end

  def self.generate_grid_text size
    # Get words
    words = DictWord.where("length < ?",size).where("length > ?",4).order("RAND()").limit(2*size).pluck(:word)
    # Build Grid
    grid_array,inserted_words = put_words_in_grid words, size
    # Convert to text
    text = ''
    grid_array.each do |row|
      text+=row.join()
    end
    # Replace * with a random char
    text.each_char.with_index(1) do |char,index|
      if char == '*'
        text[index-1] = (65+rand(25)).chr
      end
    end
    text.upcase
  end

  def self.put_words_in_grid words, size
    # Initialize grid
    grid_array = Array.new(size){ Array.new(size, '*')}
    inserted_words = []
    max_count = size*2
    # Place each word in grid
    words.each do |word|
      inserted = false
      count = 0
      while (not inserted and count < max_count)
        inserted, grid_array = try_placing_word_in_grid grid_array, word, size
        if inserted
          inserted_words.push(word)
        end
        count+=1
      end
    end
    return grid_array,inserted_words
  end

  def self.try_placing_word_in_grid grid,word,size
    wlength = word.length
    x,y = rand(size), rand(size)
    grid_letters = ''
    can_be_placed = true
    # Possible directions
    directions = [[0,1],[0,-1],[1,0],[-1,0]]
    final_direction = []
    # Check in every directions
    directions.each do |d|
      can_be_placed = true
      x_f,y_f = x + d[0]*(wlength-1), y + d[1]*(wlength-1)
      if x_f < size and y_f < size and x_f > 0 and y_f > 0
        if d[0] == 0 and d[1] > 0
          grid_letters = grid[x,1].map{|row| row[y,wlength].join()}.join()
        elsif d[0] == 0 and d[1] < 0
          grid_letters = grid[x,1].map{|row| row[y_f,wlength].reverse.join()}.join()
        elsif d[0] > 0 and d[1] == 0
          grid_letters = grid[x,wlength].map{|row| row[y,1].join()}.join()
        elsif d[0] < 0 and d[1] == 0
          grid_letters = grid[x_f,wlength].map{|row| row[y,1].join()}.reverse.join()
        end
        (1..wlength).each do |i|
          if grid_letters[i-1] != '*'
            if grid_letters[i-1] != word[i-1] 
              can_be_placed = false   
            end
          end
        end
        if can_be_placed
          (0..wlength-1).each do |i| 
            grid[x+i*d[0]][y+i*d[1]] = word[i]
          end
          break
        end
      end
    end
    return can_be_placed,grid
  end

end
