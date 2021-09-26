require_relative 'board'
require_relative 'player'
require_relative 'miscellaneous'

class Game
  include Miscellaneous

  def initialize
    @board = Board.new
    @player1 = Player.new(yellow_circle)
    @player2 = Player.new(blue_circle)
    @turn = 0
  end

  def play
    #TODO
    loop do
      @board.display_board
      set_player_name
      column = player_input
      row = available_row(column)
      @board.update_board(row, column, symbol)
    end
  end

  def player_input
    loop do
      puts 'Enter column number: '
      column = gets.chomp.to_i
      return column if verify_input(column)

      puts "Invalid input!\n\n"
    end
  end

  def verify_input(input)
    input -= 1
    input.between?(0, 6) && !full_column?(input)
  end

  def full_column?(input)
    @board.grid[0][input] != empty_circle
  end

  def available_row(column)
    row = 0
    loop do
      return row if row == 6 || @board.grid[row + 1][column] != empty_circle
      row += 1
    end
  end

  private

  def ask_player_name(number)
    puts "Enter player#{number} name: "
    gets.chomp
  end

  def set_player_name
    @player1.name = ask_player_name(1)
    @player2.name = ask_player_name(2)
  end
end

game = Game.new
game.player_input
