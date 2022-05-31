require_relative '../lib/main'

# Create a white Knight to check proper movement
describe Knight do
  let(:board) { Board.new(true) }
  let(:wknight) { Knight.new(true, [4, 3]) }
  before do
    board.positions[4][3] = wknight
  end

  context 'white knight movement calculations' do
    # Check that the Knight moves as expected when no pieces are in the way
    it 'should move over two, up one from its starting coordinate' do
      wknight.find_possible_moves(board.positions)
      expect(wknight.possible_moves.sort).to eq([[2, 2], [2, 4], [3, 1], [3, 5],
                                                 [5, 1], [5, 5], [6, 2], [6, 4]])
    end

    # Check that the Knight cannot move through or onto pieces of the same color
    it 'should be unable to move through or onto pieces of the same color' do
      board.positions[2][2] = Pawn.new(true, [2, 2])
      board.positions[3][5] = Pawn.new(true, [3, 5])
      wknight.find_possible_moves(board.positions)
      expect(wknight.possible_moves.sort).to eq([[2, 4], [3, 1], [5, 1], [5, 5],
                                                 [6, 2], [6, 4]])
    end

    # Check that the Knight cannot move through pieces of the opposing color but can capture them
    it 'should be unable to move through pieces of the opposing color, but can move onto them' do
      board.positions[2][2] = Pawn.new(false, [2, 2])
      board.positions[3][5] = Pawn.new(false, [3, 5])
      wknight.find_possible_moves(board.positions)
      expect(wknight.possible_moves.sort).to eq([[2, 2], [2, 4], [3, 1], [3, 5],
                                                 [5, 1], [5, 5], [6, 2], [6, 4]])
    end
  end
end

# Create a black Knight to check proper movement
describe Knight do
  let(:nboard) { Board.new(true) }
  let(:bknight) { Knight.new(false, [6, 2]) }
  before do
    nboard.positions[6][2] = bknight
  end

  context 'black knight movement calculations' do
    # Check that the Knight cannot move through or onto pieces of the same color
    it 'should not move through or onto pieces of the same color' do
      nboard.positions[4][1] = Pawn.new(false, [4, 1])
      nboard.positions[7][0] = Pawn.new(false, [7, 0])
      bknight.find_possible_moves(nboard.positions)
      expect(bknight.possible_moves.sort).to eq([[4, 3], [5, 0], [5, 4], [7, 4]])
    end

    # Check that the Knight cannot move through pieces of the opposing color but can capture them
    it 'should not move through pieces of the opposing color, but can move onto them' do
      nboard.positions[4][1] = Pawn.new(true, [4, 1])
      nboard.positions[7][0] = Pawn.new(true, [7, 0])
      bknight.find_possible_moves(nboard.positions)
      expect(bknight.possible_moves.sort).to eq([[4, 1], [4, 3], [5, 0], [5, 4],
                                                 [7, 0], [7, 4]])
    end
  end
end
