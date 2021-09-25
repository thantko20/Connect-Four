class Board
  attr_accessor :board

  def initialize
    @board = Array.new(6) { Array.new(7) { "\u25cb" } }
  end
end

board = Board.new
p board.board