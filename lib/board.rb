class Board
  attr_accessor :board

  def initialize
    @board = Array.new(6) { Array.new(7) { "\u25cb" } }
  end

  def board_skeleton
    @board.each do |row|
      puts row.join(' ')
    end
    puts (1..7).to_a.join(' ')
  end
end

board = Board.new
board.display_board