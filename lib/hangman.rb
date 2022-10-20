require 'yaml'
require_relative 'Yaml_module'

class Game
include BasicSerializable

    def initialize
        @secret_word = ""
        @lives = 10
        @words_to_display = []
        @wrong_letters = []
        @guessed_letters = []
        @delete_game = false
    end

    #TO DO
    #Check the order of the methods
    #Make a function that deletes the save filed if the game has ended
    def start_game
        load_game
        random_word
        display_word_settings
        while @lives > 0
            guess_letter
            save_game
            break if guess_word
        end
        delete_saved_file
    end
    
    def guess_word
        puts "Type Y if you would like to guess the secret word, anything else for no"
        input = gets.chomp.downcase
        if (input == "y")
            input2 = gets.chomp.downcase
            return correct_word_guess?(input2)
        end
    end

    def correct_word_guess?(guess_input = nil)
        return true if @secret_word == guess_input
        @lives -= 3
        puts "Wrong word, you now have #{@lives} lives left."
    end
    
    def guess_letter
        puts "Current wrong letters are: #{@wrong_letters.join(" ")}"
        puts "Type a letter you believe the secret word contains"
        player_guess = gets.chomp.downcase 
        return letter_already_guessed if @guessed_letters.include?(player_guess)
        puts "\n"
        correct_guess?(player_guess)
    end

    def correct_guess?(player_guess)
        @secret_word.include?(player_guess) ? right_guess(player_guess) : wrong_guess(player_guess)
    end

    def right_guess(word)
        puts "The letter you chose is correct!"
        display_words(word)
        @guessed_letters.push(word)
        puts "\n"
    end

    def wrong_guess(letter)
        puts "The letter you chose is incorrect!"
        return letter_already_guessed if @wrong_letters.include?(letter)
        if !@wrong_letters.include?(letter)
            @wrong_letters.push(letter)
        end
        @lives -= 1
        puts "You now have #{@lives} lifes left"
    end

    def letter_already_guessed
        puts "You have guessed this letter before"
        puts "\n"
        guess_letter
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

    def save_game
        puts "Do you want to save the game? Type Y for yes, type anything else for no."
        input = gets.chomp.downcase
        return if input != "y"
        serialize
        @delete_game = false
    end

    def load_game
        return if !File.exists?("hangman.yaml")
        puts "Type Y if you wish to load a saved game"
        input = gets.chomp
        return if input.downcase != "y"
        unserialize
        @delete_game = true
    end

    def delete_saved_file
        File.delete("hangman.yaml") if @delete_game == true
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


