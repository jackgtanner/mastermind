#Assignment

#Build a Mastermind game from the command line where you have 12 turns to guess the secret code, starting with you guessing the computer’s random code.

#Think about how you would set this problem up!
#Build the game assuming the computer randomly selects the secret colors and the human player must guess them. Remember that you need to give the proper feedback on how good the guess was each turn!
#Now refactor your code to allow the human player to choose whether he/she wants to be the creator of the secret code or the guesser.
#Build it out so that the computer will guess if you decide to choose your own secret colors. You may choose to implement a computer strategy that follows the rules of the game or you can modify these rules.
#If you choose to modify the rules, you can provide the computer additional information about each guess. For example, you can start by having the computer guess randomly, but keep the ones that match exactly. You can add a little bit more intelligence to the computer player so that, if the computer has guessed the right color but the wrong position, its next guess will need to include that color somewhere.
#If you want to follow the rules of the game, you’ll need to research strategies for solving Mastermind, such as this post.




# Classic mastermind has 6 colors, 4 holes and 12 turns to guess the code / combination

#6 colors: Blue = B, Yellow = Y, Green = G, White = W, Red = R, Purple = P


class Player
    attr_reader :name
    def initialize(name)
        @name = name
    end

end

class Board
    attr_writer :secret_code
    def initialize
        @code = [(rand(6)), (rand(6)), (rand(6)), (rand(6))]
        @secret_code = @code
        @secret_code.map.with_index {|number, index|

            if number < 1
                @secret_code[index] = "B"
            elsif number < 2
                @secret_code[index] = "Y"
            elsif number < 3
                @secret_code[index] = "G"
            elsif number < 4
                @secret_code[index] = "W"
            elsif number < 5
                @secret_code[index] = "R"
            elsif 
                @secret_code[index] = "P"
            end
        }      
    end

    def is_choice_valid(guess)
        @guess = guess
        until (@guess.length === 4) && (@guess.any? { |i| ["B", "b", "Y", "y", "G", "g", "W", "w", "R", "r", "P", "p"].include? i })
            unless @guess.length === 4
                puts "Sorry, the code is made up of 4 colors, try again with that amount"
                @player_guess = gets.chomp
                @guess = @player_guess.split("")
            end
            unless @guess.any? { |i| ["B", "b", "Y", "y", "G", "g", "W", "w", "R", "r", "P", "p"].include? i }
                puts "Colors not recognized, try again from any number of the 6 colors"
                @player_guess = gets.chomp
                @guess = @player_guess.split("")
            end
        end
        @guess = @guess.map!(&:upcase)
        return true
    end

    def get_hints
        @hint = []
        guess_copy = Array.new()
        code_copy = Array.new()
        @guess
        @secret_code

        for i in 0..3 # check for correct colors in correct positions
            if @guess[i] == @secret_code[i]
                @hint.push("W")
            end
            unless @guess[i] == @secret_code[i]
                guess_copy.push(@guess[i])
                code_copy.push(@secret_code[i])
            end
        end

        for i in 0..(guess_copy.length-1)
            if (code_copy).include?(guess_copy[i])
                @hint.push("B")
            else
                @hint.push("_")
            end
        end
    end

    def show_board()
        puts "---------"
        puts "-#{@guess[0]}-#{@guess[1]}-#{@guess[2]}-#{@guess[3]}-|| Hints: -#{@hint[0]}.#{@hint[1]}.#{@hint[2]}.#{@hint[3]}-"
        puts "---------\n\n"
    end

    def show_code
        puts "---------"
        puts "-#{@secret_code[0]}-#{@secret_code[1]}-#{@secret_code[2]}-#{@secret_code[3]}-"
        puts "---------"
    end

    def game_won?
        if @guess === @secret_code
            return true
        else
            return false
        end        
    end
end


class Game
    def initialize
        puts "\n\nWelcome to Masterind!!"
        puts "\nBefore explainging the rules, what's your name?\n\n"
        @player = Player.new(gets.chomp) 
        puts "\nWelcome #{@player.name}!\n\n"
        sleep (1)
        puts "In the game Mastermind, you will have 12 Turns to work out a color code which is set by the computer.\n\n"
        sleep (3)
        puts "The code is made up of 4 colors, you have to guess the colors, and the correct position of them. The colors can be repeated\n\n"
        sleep (3)
        puts "After each turn, the computer will give you a hint as to how close you are to getting the secret code correct.\n\n"
        sleep (3)
        puts "For each correct color, the computer will give you a Blue letter, for each color that is also in the correct position, the letter will be White\n\n"
        sleep (3)
        puts "If there are no correct guesses, the computer will not give you a letter and it will remain blank.\n\n"
        sleep (3)
    end

    def play
        puts "Lets get started!\n\n"
        puts "(W in hints means you have a color which is correct & in the correct position"
        puts "and B means there is a correct color but not in the correct position"
        puts "'_' means that there is a color which is wrong)\n\n"
        
        @moves = 0
        @colors = ["B", "b", "Y", "y", "G", "g", "W", "w", "R", "r", "P", "p"]
        @board = Board.new
        @game_over = false

        until @game_over
            puts "Type in 4 of the colors to make your guess:"
            puts "Blue = B, Yellow = Y, Green = G, White = W, Red = R, Purple = P\n\n"
            #Get input and check it's valid
            valid_choice = false
            until valid_choice
                @player_guess = gets.chomp
                @guess = @player_guess.split("")
                valid_choice = true if @board.is_choice_valid(@guess)               
            end

            #get hints
            @board.get_hints

            #display new board
            @board.show_board()
            # @board.show_code()

            #Loop until game is won or moves === 12
            @moves += 1
            puts "You have #{12 - @moves} moves left\n\n"
            if @board.game_won?
                puts "WooHoo!!!"
                puts "\n\nCongrats #{@player.name}! You've guessed the code & won!!\n\n"
                @game_over = true
            elsif @moves === 12
                @game_over = true
                puts "\n\nGame Over..... the secret code was:"
                @board.show_code
                puts "Unlucky #{@player.name}, you didn't manage to guess the code within 12 Moves :(\n\n\n"
            end
        end
    end
end


    mastermind = Game.new()
    play_again = ""
until play_again === "No"
    mastermind.play
    puts 'Play again? Type Yes or No'
    play_again = gets.chomp
  until ['Yes', 'No'].include?(play_again)
    puts 'Invalid input. Type Yes or No'
    play_again = gets.chomp
  end
end
puts "See you next time\n\n"