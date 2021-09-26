require_relative '../lib/board'

describe Board do
  let(:yellow_circle) { described_class.new.yellow_circle }
  let(:blue_circle) { described_class.new.blue_circle }

  describe '#update_board' do
    subject(:board_update) { Board.new }

    context 'when updated at 1st row and 1st column with yello circle' do
      before do
        board_update.update_board(1, 1, yellow_circle)
      end

      it 'updates cell on the board' do
        board = board_update.instance_variable_get(:@grid)
        updated_cell = board[1][1]
        expect(updated_cell).to eq(yellow_circle)
      end
    end

    context 'when updated at 6th row and 1st column with blue circle' do
      before do
        board_update.update_board(5, 0, blue_circle)
      end

      it 'updated cell on the board' do
        board = board_update.instance_variable_get(:@grid)
        updated_cell = board[5][0]
        expect(updated_cell).to eq(blue_circle)
      end
    end
  end

  describe '#check_horizontal' do
    subject(:horizontal_check) { described_class.new }
    let(:grid) { horizontal_check.instance_variable_get(:@grid)}

    before do
      grid[0][1] = 'X'
      grid[0][2] = 'X'
      grid[0][3] = 'X'
      grid[0][4] = 'X'
    end
    context 'when it matches' do
      it 'returns true' do
        result = horizontal_check.check_horizontal(0, 1, 'X')
        expect(result).to be true
      end
    end
  end

  describe '#check_vertical' do
    subject(:vertical_check) { described_class.new }
    let(:grid) { vertical_check.instance_variable_get(:@grid)}

    before do
      grid[0][1] = 'X'
      grid[1][1] = 'X'
      grid[2][1] = 'X'
      grid[3][1] = 'X'
    end
    context 'when it matches' do
      it 'returns true' do
        result = vertical_check.check_vertical(0, 1, 'X')
        expect(result).to be true
      end
    end
  end

  describe '#check_right_diagonal' do
    subject(:rt_diagonal_check) { described_class.new }
    let(:grid) { rt_diagonal_check.instance_variable_get(:@grid )}

    before do
      grid[2][6] = 'X'
      grid[3][5] = 'X'
      grid[4][4] = 'X'
      grid[5][3] = 'X'
    end
    context 'when it matches' do
      it 'returns true' do
        result = rt_diagonal_check.check_right_diagonal(2, 6, 'X')
        expect(result).to be true
      end
    end
  end

  describe '#check_left_diagonal' do
    subject(:lt_diagonal_check) { described_class.new }
    let(:grid) { lt_diagonal_check.instance_variable_get(:@grid )}

    before do
      grid[0][2] = 'X'
      grid[1][3] = 'X'
      grid[2][4] = 'X'
      grid[3][5] = 'X'
    end
    context 'when it matches' do
      it 'returns true' do
        result = lt_diagonal_check.check_left_diagonal(0, 2, 'X')
        expect(result).to be true
      end
    end
  end
end