class Game

    def initialize
        @secret_word = ""
        @lives = 10
        @words_to_display = []
        @wrong_letters = []
        @game_over = false
    end

    def start_game
        #load file
        random_word
        display_word_settings
        #save game
        # -- Check later if there is a sexier way to write this
        while @lives > 0
            guess_letter
            break if @game_over == true || @lives == 0
            guess_word 
        end
        # --
    end


    def guess_word
        puts "Type Y if you would like to guess the secret word, N if you do not want to guess the word"
        input = gets.chomp.downcase
        if (input == "y")
            input2 = gets.chomp.downcase
            correct_word_guess?(input2)
        end
    end

    def correct_word_guess?(guess_input = nil)
        @secret_word == guess_input ? @game_over = true : wrong_word_guess
    end

    def wrong_word_guess
        @lives -= 3
        puts "Wrong word, you now have #{@lives} lives left."
    end

    def guess_letter
        puts "Current wrong letters are: #{@wrong_letters.join(" ")}"
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

    def wrong_guess(letter)
        puts "The letter you chose is incorrect!"
        if !@wrong_letters.include?(letter)
            @wrong_letters.push(letter)
        end
        @lives -= 1
        puts "You now have #{@lives} lifes left"
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
    end

    def create_file
        
    end

    def random_word
        contents = File.readlines('google-10000-english-no-swears.txt')

        while !@secret_word.length.between?(5,12)
            @secret_word = contents.sample.chomp
        end

        puts @secret_word
    end

end

x = Game.new.start_game