require_relative 'lib/game.rb'
require_relative 'lib/player.rb'
require_relative 'lib/board.rb'
require_relative 'lib/piece.rb'
require_relative 'lib/square.rb'

describe Piece do
  subject(:piece) { described_class.new("white") }
  #let(:game) { instance_double(Game) }
  #let(:board) { instance_double(Board) }
  
  describe '#moves' do
    xit 'returns something' do
      # square = game.board.square("c4")
      board = Board.new()
      square = board.square("c4")
      direction = [1, 1]
      expect(piece.moves(square, direction)).to be nil
    end
  end
end

describe Board do
  subject(:board) { described_class.new }

  describe '#moves' do
    context 'when direction is top-right' do
      xit 'returns valid moves' do
        direction = [1, 1]
        square = board.square("c4")
        square1 = board.square("d5")
        square2 = board.square("e6")
        square3 = board.square("f7")
        valid_moves = [square1, square2, square3]
        expect(board.moves(square, direction)).to eq(valid_moves)
      end
    end

    context 'when direction is down' do
      xit 'returns valid moves' do
        direction = [-1, 0]
        square = board.square("c6")
        square1 = board.square("c5")
        square2 = board.square("c4")
        square3 = board.square("c3")
        valid_moves = [square1, square2, square3]
        expect(board.moves(square, direction)).to eq(valid_moves)
      end
    end

    context 'when direction is left' do
      xit 'returns valid moves' do
        direction = [0, -1]
        square = board.square("d4")
        square1 = board.square("c4")
        square2 = board.square("b4")
        square3 = board.square("a4")
        valid_moves = [square1, square2, square3]
        expect(board.moves(square, direction)).to eq(valid_moves)
      end
    end

    context 'when there are no valid moves' do
      xit 'returns an empty array' do
        direction = [-1, -1]
        square = board.square("a1")
        expect(board.moves(square, direction)).to eq([])
      end
    end
  end
end

describe Game do
  subject(:game) { described_class.new }

  describe '#valid_notation?' do
    context 'when the input is valid' do
      it 'returns true' do
        expect(game.valid_notation?('e2e4')).to be true
      end
    end

    context 'when the input is invalid' do
      it 'returns false' do
        expect(game.valid_notation?('e2 e4')).to be false
      end

      it 'returns false' do
        expect(game.valid_notation?('e2e9')).to be false
      end

      it 'returns false' do
        expect(game.valid_notation?('y2e9e')).to be false
      end

      it 'returns false' do
        expect(game.valid_notation?('a2')).to be false
      end

    end
  end
end