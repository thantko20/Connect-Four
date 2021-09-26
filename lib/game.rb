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
      break if game_over?(curr_player)
    end
    @board.display_board
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

  def game_over?(player)
    symbol = player.symbol
    5.times do |row|
      6.times do |column|
        if check_row(row, column, symbol)
          puts "#{player.name} won!"
          return true
        end
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

  def check_vertical(row, column, symbol)
    return if row > 2

    @board.grid[row + 1][column] == symbol && @board.grid[row + 2][column] == symbol && @board.grid[row + 3][column] == symbol
  end

  def check_horizontal(row, column, symbol)
    return if column > 3

    @board.grid[row][column + 1] == symbol && @board.grid[row][column + 2] == symbol && @board.grid[row][column + 3] == symbol
  end

  def check_diagonals(row, column, symbol)
    return unless column == 3 && row < 2

    check_left_diagonal(row, column, symbol) || check_right_diagonal(row, column, symbol)
  end

  def check_row(row, column, symbol)
    check_horizontal(row, column, symbol) || check_vertical(row, column, symbol) || check_diagonals(row, column, symbol)
  end

  def check_left_diagonal(row, column, symbol)
    @board.grid[row + 1][column + 1] == symbol && @board.grid[row + 2][column + 2] == symbol && @board.grid[row + 3][column + 3] == symbol
  end

  def check_right_diagonal(row, column, symbol)
    @board.grid[row + 1][column - 1] == symbol && @board.grid[row + 2][column - 2] == symbol && @board.grid[row + 3][column - 3] == symbol
  end
end

game = Game.new
game.play