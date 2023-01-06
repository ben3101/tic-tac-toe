# for players
class Player
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end
end

# controls the game
class Game
  def initialize
    @game_turn = 0
    @available_tiles = ['0', '1', '2', '3', '4', '5', '6', '7', '8']
    @p1 = Player.new('O')
    @p2 = Player.new('X')
    @board = Board.new
    @board.display_board
  end

  def current_turn
    if @game_turn.even?
      @current_turn = @p1
    else
      @current_turn = @p2
    end
  end

  # when game turn is even, O's play, when odd X's.
  def play_game
    @game_over = false
    until @game_over
      puts "\n#{current_turn.symbol}'s turn:\n"
      puts "Please enter the number of an available tile. If you would like to see the tile numbers again, enter 'help'."
      answer = gets.chomp
      if answer == 'help'
        display_help()
      elsif answer == 'board'
        @board.display_board
      elsif @available_tiles.include?(answer)
        @available_tiles.delete(answer)
        @board.update_board(current_turn.symbol, answer)
        @game_over = @board.check_win(current_turn.symbol)
        @winner = current_turn.symbol
        @game_turn += 1
        # check board is not full and declare draw if so
        if @available_tiles.empty?
          @game_over = true
          @winner = "Nobody! It's a draw."
        end
      else 
        puts '**That is not an available position on the board.**'
        p "Available: #{@available_tiles}"
      end
    end
    # update turn 1 more time to declare correct winner
    puts "The winner is #{@winner}!"
    play_again
  end

  def display_help
    puts "\n Tile locations:\n"
    puts ' 0 | 1 | 2 '
    puts ' 3 | 4 | 5 '
    puts ' 6 | 7 | 8 '
    puts "\n"
  end

  def play_again
    puts "Enter 'p' to play again, or anything else to exit the game."
    reply = gets.chomp
    return unless reply == p
  end
end

# Board for each game
class Board
  attr_accessor :board

  def initialize
    @board = Array.new(9, ' ')
    puts "When it is your turn, enter a number to place your piece on one of the available tiles. O's go first."
    puts ' 0 | 1 | 2 '
    puts ' 3 | 4 | 5 '
    puts ' 6 | 7 | 8 '
    puts "\n"
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]}"
  end

  def update_board(player, tile)
    puts "#{player} moved on tile: #{tile}"
    @board[tile.to_i] = player
    display_board
  end

  def check_win(player)
    # victory conditions:
    # rows
    row1 = @board[0] == player && @board[1] == player && @board[2] == player
    row2 = @board[3] == player && @board[4] == player && @board[5] == player
    row3 = @board[6] == player && @board[7] == player && @board[8] == player
    # columns
    col1 = @board[0] == player && @board[3] == player && @board[6] == player
    col2 = @board[1] == player && @board[4] == player && @board[7] == player
    col3 = @board[2] == player && @board[5] == player && @board[8] == player
    # diagonals
    diag1 = @board[0] == player && @board[4] == player && @board[8] == player
    diag2 = @board[2] == player && @board[4] == player && @board[6] == player   
    row1 || row2 || row3 || col1 || col2 || col3 || diag1 || diag2
  end
end

g = Game.new
g.play_game
