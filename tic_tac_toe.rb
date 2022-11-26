module Board
@@board = "-------------
| 1 | 2 | 3 |
-------------
| 4 | 5 | 6 |
-------------
| 7 | 8 | 9 |
-------------"

    def self.display
        puts @@board
    end

    def self.update(position_num, mark)
        @@board.gsub!(position_num, mark)
    end

    def self.board
        @@board
    end

    def self.board_array
        board_array = self.board.tr("|", "").tr("-", "").gsub(/\s+/, "").split("")
    end

    def self.game_won(mark)

        winning_combinations = [[1, 5, 9], [3, 5, 7], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 2, 3], [4, 5, 6], [7, 8, 9]]

        winning_combinations_indexes = winning_combinations.map { |array| array.map { |num| num - 1
        } }
        #wci should return [[0, 4, 8], [2, 4, 6], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 1, 2], [3, 4, 5], [6, 7, 8]]

        #if the player's mark is at the 3 indexes of an array in wci, return true

        winning_combinations_indexes.map { |array| 
            if Board.board_array[array[0]] == mark && Board.board_array[array[1]] == mark && Board.board_array[array[2]] == mark
                    return true
    
            end}
    end

    def self.tie
        !((Board.board_array & ["1", "2", "3", "4", "5", "6", "7", "8", "9"]).any?)
    end

end

class Player
    attr_reader :num

    def initialize(num)
        @num = num
    end

    def get_player_mark()
        puts "player 1: x or o?"
        @mark = gets.chomp.downcase

        until (["x", "o"].include?(@mark))
            puts "you must choose either x or o"
            @mark = gets.chomp.downcase
        end

    end

    def assign_mark(opposite_mark)
        if opposite_mark == "x"
            @mark = "o"
        elsif opposite_mark == "o"
            @mark = "x"
        end
    end

    def mark
        @mark
    end

    def get_position()
        puts "player #{@num}, choose an a position (1-9) to place your #{@mark}"
        @position_num = gets.chomp

        until Board.board_array.include?(@position_num)
            puts "please choose an available position"
            @position_num = gets.chomp
        end

        @position_num
    end

end

#not using this class yet
class Position
    attr_reader :num
    def initialize(num)
        @num = num
    end
end

#not using this class yet
class Round
    attr_reader :num
    def initialize(num)
        @num = num
    end
end

player1 = Player.new(1)
player2 = Player.new(2)

player1.get_player_mark()
player2.assign_mark(player1.mark)
puts "player 2, your mark is #{player2.mark}"

Board.display

until Board.game_won(player1.mark) == true || Board.game_won(player2.mark) == true || Board.tie
    Board.display
    Board.update(player1.get_position(), player1.mark)

    if !(Board.game_won(player1.mark) == true || Board.game_won(player2.mark) == true || Board.tie)
        Board.display
    end

    # make this more concise2

    if !(Board.game_won(player1.mark) == true || Board.game_won(player2.mark) == true || Board.tie)
        Board.update(player2.get_position(), player2.mark)
        Board.display
    end

end

if Board.game_won(player1.mark) == true
    puts "game won by player 1!"
elsif Board.game_won(player2.mark) == true
    puts "game won by player 2!"
elsif Board.tie
    puts "it's a draw!"
end
