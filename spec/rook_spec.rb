require_relative '../lib/main'

# Create a white Rook to check proper movement
describe Rook do
  let(:board) { Board.new(true) }
  let(:wrook) { Rook.new(true, [6, 1]) }
  before do
    board.positions[6][1] = wrook
  end

  context 'white rook movement calculations' do
    # Check that the Rook moves as expected when no pieces are in the way
    it 'should move horizontally/vertically from its starting coordinate' do
      wrook.find_possible_moves(board.positions)
      expect(wrook.possible_moves.sort).to eq([[0, 1], [1, 1], [2, 1], [3, 1],
                                               [4, 1], [5, 1], [6, 0], [6, 2],
                                               [6, 3], [6, 4], [6, 5], [6, 6],
                                               [6, 7], [7, 1]])
    end

    # Check that the Rook cannot move through or onto pieces of the same color
    it 'should be unable to move through or onto pieces of the same color' do
      board.positions[6][4] = Pawn.new(true, [6, 4])
      board.positions[2][1] = Pawn.new(true, [2, 1])
      wrook.find_possible_moves(board.positions)
      expect(wrook.possible_moves.sort).to eq([[3, 1], [4, 1], [5, 1], [6, 0],
                                               [6, 2], [6, 3], [7, 1]])
    end

    # Check that the Rook cannot move through pieces of the opposing color but can capture them
    it 'should be unable to move through pieces of the opposing color, but can move onto them' do
      board.positions[6][4] = Pawn.new(false, [6, 4])
      board.positions[2][1] = Pawn.new(false, [2, 1])
      wrook.find_possible_moves(board.positions)
      expect(wrook.possible_moves.sort).to eq([[2, 1], [3, 1], [4, 1], [5, 1],
                                               [6, 0], [6, 2], [6, 3], [6, 4],
                                               [7, 1]])
    end
  end
end

# Create a black Rook to check proper movement
describe Rook do
  let(:nboard) { Board.new(true) }
  let(:brook) { Rook.new(false, [4, 4]) }
  before do
    nboard.positions[4][4] = brook
  end

  context 'black rook movement calculations' do
    # Check that the Rook cannot move through or onto pieces of the same color
    it 'should not move through or onto pieces of the same color' do
      nboard.positions[1][4] = Pawn.new(false, [1, 4])
      nboard.positions[4][6] = Pawn.new(false, [4, 6])
      brook.find_possible_moves(nboard.positions)
      expect(brook.possible_moves.sort).to eq([[2, 4], [3, 4], [4, 0], [4, 1],
                                               [4, 2], [4, 3], [4, 5], [5, 4],
                                               [6, 4], [7, 4]])
    end

    # Check that the Rook cannot move through pieces of the opposing color but can capture them
    it 'should not move through pieces of the opposing color, but can move onto them' do
      nboard.positions[1][4] = Pawn.new(true, [1, 4])
      nboard.positions[4][6] = Pawn.new(true, [4, 6])
      brook.find_possible_moves(nboard.positions)
      expect(brook.possible_moves.sort).to eq([[1, 4], [2, 4], [3, 4], [4, 0],
                                               [4, 1], [4, 2], [4, 3], [4, 5],
                                               [4, 6], [5, 4], [6, 4], [7, 4]])
    end
  end
end
