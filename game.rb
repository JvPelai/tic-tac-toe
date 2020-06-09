
class Game
    attr_accessor :total_moves
    attr_accessor :board_template
    attr_accessor :rounds
    def initialize
        puts "Welcome to the ultimate tic-tac-toe showdown!"
        @board = {1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9}
        @board_display = [["*", "*", "*"],["*", "*", "*"],["*", "*", "*"]]
        @board_template = [["1","2", "3"], ["4", "5", "6"],["7", "8", "9"]]
        puts "Player one, please enter your desired name. You will be X in this match."
        @player_one = gets.chomp
        @player_one_moves = 0
        puts "Player two, please enter your desired name. You will be O in this match."
        @player_two = gets.chomp
        @player_two_moves = 0
        puts "Enter an odd number of rounds you'd like to play: "
        @rounds = gets.chomp.to_i
        while @rounds.odd? == false do
            puts "Invalid number of rounds, please enter an odd number."
            @rounds = gets.chomp.to_i
        end
        puts "These are the corresponding numbers for each spot: "
        boardTemplateDisplay 
        roundTracking(@rounds)
    end
    def roundTracking(rounds)
        i = 1
        @@player_one_score = 0
        @@player_two_score = 0
        while i <= @rounds do 
            startGame
            i += 1
            if @@player_one_score > @rounds/2 || @@player_two_score > @rounds/2
                i = @rounds + 1
            end
        end
        if @@player_one_score > @@player_two_score
            puts "Congratulations #{@player_one}, You won!"
            puts "Score :  #{@player_one}  #{@@player_one_score} vs #{@@player_two_score} #{@player_two}"
        else
            puts "Congratulations #{@player_two}, You won!"
            puts "Score :  #{@player_one}  #{@@player_one_score} vs #{@@player_two_score} #{@player_two}"
        end
    end


    def boardDisplay
        puts ""
        puts @board_display[0].join("|")
        puts @board_display[1].join("|")
        puts @board_display[2].join("|")
        puts ""
    end
    def boardTemplateDisplay
        puts ""
        puts @board_template[0].to_a.join("|")
        puts @board_template[1].join("|")
        puts @board_template[2].to_a.join("|")
        puts ""
    end

    def startGame
        print boardTemplateDisplay, boardDisplay
        @@total_moves = 0
        while @@total_moves < 9
            if @@total_moves.even?
                playerOneMove 
                checkSpots("X")
            else 
                playerTwoMove
                checkSpots("O") 
            end
        end
    end

    def playerOneMove
        puts "It's #{@player_one}'s turn, type in the number of the spot you want checked "
        puts "on the board."
        input = gets.chomp.to_i
        while (1..9).include?(input) == false do
            puts "Invalid input, please enter another number: "
            input = gets.chomp.to_i
        end
        checkInput(input,@player_one)
        boardTemplateDisplay
        boardDisplay
    end

    def playerTwoMove
        puts "It's your turn now #{@player_two},type in the number of the spot you want checked"
        input = gets.chomp.to_i
        while (1..9).include?(input) == false do
            puts "Invalid input, please enter another number: "
            input = gets.chomp.to_i
        end
        checkInput(input,@player_two) 
        boardTemplateDisplay
        boardDisplay
    end

    private  
    def checkInput(input,player)
        if input <= 3
            @board_template[0].each do |spot|
                if spot == input.to_s
                    if player == @player_one
                        @board_display[0][input -1 ] = "X"
                    else
                        @board_display[0][input - 1] = "O"
                    end
                end
            end
        elsif input > 3 && input < 7
            @board_template[1].each do |spot|
                if spot == input.to_s
                    if player == @player_one
                        @board_display[1][input - 4 ] = "X"
                    else
                        @board_display[1][input - 4] = "O"
                    end
                end
            end
        else
            @board_template[2].each do |spot|
                if spot == input.to_s                   
                    if player == @player_one
                        @board_display[2][input - 7 ] = "X"
                    else
                        @board_display[2][input - 7] = "O"
                    end
                end
            end
        end
        @@total_moves += 1 
    end
    def checkSpots(play)
        #check horizontally
        i = 0
        while i < 3 do
            horizontal = 0
            @board_display[i].each do |column|
                if column == play
                    horizontal += 1 
                   else
                    horizontal += 0
                   end
                if horizontal == 3
                    declareWinner(play)
                end
            end
            i += 1
        end 
        #check vertically
            vertical1 = 0
            vertical2 = 0
            vertical3 = 0
        @board_display.each do | row |
            if row[0] == play
                vertical1 += 1
            elsif row[1] == play
                vertical2 += 1 
            elsif row[2] == play 
                vertical3 += 1
            end
        end
       #check diagonally
        diagonal1 = 0
        diagonal2 = 0
        if @board_display[0][0] == play
            diagonal1 += 1
        end
        if @board_display[1][1] == play
            diagonal1 += 1
            diagonal2 += 1
        end
        if @board_display[2][2] == play
            diagonal1 += 1
        end
        if @board_display[0][2] == play 
            diagonal2 += 1
        end
        if @board_display[2][0] == play 
            diagonal2 += 1
        end
        if @board_display[0][3] == play
            diagonal2 += 1
        end
        
        #declares winner
        if vertical1 ==3 || vertical2 == 3 || vertical3 == 3 || diagonal1 == 3 || diagonal2 == 3
            @@total_moves = 9
            declareWinner(play)
        end
    end

    def declareWinner(play)
        if play == "X"
            @@player_one_score += 1
            puts "Congratulations #{@player_one}!! You win!"
            puts "Current score: #{@player_one}  #{@@player_one_score} vs #{@@player_two_score} #{@player_two}"
        elsif play == "O"
            @@player_two_score += 1
            puts "Congratulations #{@player_two}!! You win!"
            puts "Current score: #{@player_one}  #{@@player_one_score} vs #{@@player_two_score} #{@player_two}"
        end
        @board_display = [["*", "*", "*"],["*", "*", "*"], ["*", "*", "*"]]
    end
end
     
Game.new 

continue_game = true
while continue_game == true do
    puts "Do you wish to play again?"
    puts "Y/N" 
    answer = gets.chomp
    if answer.upcase == "Y"
        Game.new
    elsif answer.upcase == "N"
        continue_game = false
    else
        puts "Invalid answer"
    end
end
