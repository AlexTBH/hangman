class Game

    def random_word
        new_word = ""
        contents = File.readlines('google-10000-english-no-swears.txt')
    

        while !new_word.length.between?(6,13)
            new_word = contents.sample
        end

        new_word
    end
end

x = Game.new.random_word