require_relative 'board'
require_relative 'player'
require_relative 'miscellaneous'
require 'pry-byebug'

class Game
  include Miscellaneous

  def initialize
    @board = Board.new
    @player1 = Player.new(yellow_circle)
    @player2 = Player.new(blue_circle)
    @turn = 0
  end

  def play
    set_player_name
    loop do
      curr_player = player_turn
      @board.display_board
      column = player_input
      row = available_row(column)
      symbol = curr_player.symbol
      @board.update_board(row, column, symbol)
    end
  end

  def player_input
    loop do
      puts 'Enter column number: '
      column = gets.chomp.to_i - 1
      return column if verify_input(column)

      puts "Invalid input!\n\n"
    end
  end

  def verify_input(input)
    input.between?(0, 6) && !full_column?(input)
  end

  def full_column?(input)
    @board.grid[0][input] != empty_circle
  end

  def available_row(column)
    row = 0
    loop do
      return row if row == 5 || @board.grid[row + 1][column] != empty_circle

      row += 1
    end
  end

  def player_turn
    @turn += 1
    @turn.odd? ? @player1 : @player2
  end

  def game_over?(symbol)
    6.times do |row|
      7.times do |column|
        return true if check_row(row, column, symbol)
      end
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

  def check_horizontal(row, column, symbol)
    @board.grid[row + 1][column] == symbol && @board.grid[row + 2][column] == symbol && @board.grid[row + 3][column] == symbol
  end

  def check_vertical(row, column, symbol)
    @board.grid[row][column + 1] == symbol && @board.grid[row][column + 2] == symbol && @board.grid[row][column + 3] == symbol
  end

  def check_diagonal
    
  end

  def check_row(row, column, symbol)
    check_horizontal(row, column, symbol) || check_vertical(row, column, symbol)
  end
end
