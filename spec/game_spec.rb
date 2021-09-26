require_relative '../lib/game'

describe Game do
  describe '#verify_input' do
    subject(:input_verification) { described_class.new }

    context 'when player types valid input which is 2' do
      valid_input = 2
      it 'returns true' do
        result = input_verification.verify_input(valid_input)
        expect(result).to be true
      end
    end

    context 'when player types invalid value that is already occupied' do
      let(:game_board) { input_verification.instance_variable_get(:@board) }

      before do
        game_board.grid[0][2] = 'X'
      end

      it 'returns false' do
        invalid_input = 2
        result = input_verification.verify_input(invalid_input)
        expect(result).to be false
      end
    end

    context 'when player types invalid value greater than 7' do
      it 'returns false' do
        invalid_input = 8
        result = input_verification.verify_input(invalid_input)
        expect(result).to be false
      end
    end

    context 'when player types invalid value less than 1' do
      it 'returns false' do
        invalid_input = -2
        result = input_verification.verify_input(invalid_input)
        expect(result).to be false
      end
    end
  end

  describe '#player_turn' do
    subject(:turn_verification) { described_class.new }
    let(:player1) { turn_verification.instance_variable_get(:@player1) }
    let(:player2) { turn_verification.instance_variable_get(:@player2) }

    before do
      player1.name = 'Marco'
      player2.name = 'Micah'
    end

    context "when it is player1's turn" do

      it 'returns player1' do
        return_player = turn_verification.player_turn
        expect(return_player.name).to eq(player1.name)
      end
    end

    context "when it is player2's turn" do

      before do
        turn_verification.instance_variable_set(:@turn, 1)
      end

      it 'returns player2' do
        return_player = turn_verification.player_turn
        expect(return_player.name).to eq(player2.name)
      end
    end
  end

  describe '#game_over?' do
    context 'when a player wins' do
      subject(:end_game) { described_class.new }
      let(:board) { end_game.instance_variable_get(:@board) }
      let(:player) { instance_double(Player, name: 'Marco', symbol: 'X') }

      before do
        allow(board).to receive(:check_row).and_return(true)
      end

      it "announces player's name" do
        expect(end_game).to receive(:puts).with('Marco won!')
        end_game.game_over?(player)
      end
    end
  end

  describe '#draw?' do
    subject(:game_draw) { described_class.new }

    context 'when draws' do
      before do
        game_draw.instance_variable_set(:@turn, 42)
      end
      it 'prints Draw!' do
        expect(game_draw).to receive(:puts).with('Draw!')
        game_draw.draw?
      end
    end
  end
end