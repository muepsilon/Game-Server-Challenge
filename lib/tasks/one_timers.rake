namespace :one_timers do
  desc "Copy words from UNIX dictionary to Database table"
  task build_dict_words: :environment do
    min_len = Figaro.env.DICT_WORDS_MIN_LENGTH.to_i
    max_len = Figaro.env.DICT_WORDS_MAX_LENGTH.to_i
    log_file = Logger.new("#{Rails.root}/log/add_words_to_db.log")
    File.foreach(Figaro.env.DICT_FILE_PATH) do |line|
      word = /^\w+$/.match(line)
      if word
        length = line.strip.length
        if length >= min_len and length <= max_len
          dict_word = DictWord.find_or_initialize_by(word: line.strip, length: length)
          if !dict_word.save
            log_file.debug("#{line}")
          end
        end
      end
    end
  end

end
