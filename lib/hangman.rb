class Game

    def initialize
        @secret_word = ""
        @lives = 10
        @words_to_display = []
        @wrong_words = []
    end

    def start_game
        #load file
        random_word
        display_word_settings
        #save game
        while @lives > 0
            guess_letter
            guess_word
        end
        #guess word
    end

    def guess_letter
        puts "Current wrong words are: #{@wrong_words.join(" ")}"
        puts "Type a letter you believe the secret word contains"
        player_guess = gets.chomp.downcase 
        puts "\n"
        correct_guess?(player_guess)
    end

    def correct_guess?(player_guess)
        @secret_word.include?(player_guess) ? right_guess(player_guess) : wrong_guess(player_guess)
    end

    def right_guess(word)
        puts "The letter you chose is correct!"
        display_words(word)
        puts "\n"
    end

    def wrong_guess(word)
        puts "The letter you chose is incorrect!"
        if !@wrong_words.include?(word)
            @wrong_words.push(word)
        end
        @lives -= 1
        puts "You now have #{@lives} left"
    end

    def guess_word
        
    end

    def display_words(string)
        @secret_word.chars.each_with_index do |word, index|
            if string == word
                @words_to_display[index] = word
            end
        end
        puts @words_to_display.join(" ")
    end

    def display_word_settings
        @secret_word.chars.each do |word|
            @words_to_display.push("_")
        end
        @words_to_display.pop()
    end

    def create_file
        
    end

    def random_word
        contents = File.readlines('google-10000-english-no-swears.txt')

        while !@secret_word.length.between?(6,13)
            @secret_word = contents.sample
        end

        puts @secret_word
    end

end

x = Game.new.start_game