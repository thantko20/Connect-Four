require_relative '../lib/board'

describe Board do
  subject(:board_update) { Board.new }
  let(:yellow_circle) { board_update.yellow_circle }
  let(:blue_circle) { board_update.blue_circle }

  context 'when updated at 1st row and 1st column with yello circle' do
    before do
      board_update.update_board(1, 1, yellow_circle)
    end

    it 'updates cell on the board' do
      board = board_update.instance_variable_get(:@board)
      updated_cell = board[1][1]
      expect(updated_cell).to eq(yellow_circle)
    end
  end

  context 'when updated at 6th row and 1st column with blue circle' do
    before do
      board_update.update_board(5, 0, blue_circle)
    end

    it 'updated cell on the board' do
      board = board_update.instance_variable_get(:@board)
      updated_cell = board[5][0]
      expect(updated_cell).to eq(blue_circle)
    end
  end
end