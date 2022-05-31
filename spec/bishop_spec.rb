require_relative '../lib/main'

# Create a white Bishop to check proper movement
describe Bishop do
  let(:board) { Board.new(true) }
  let(:wbishop) { Bishop.new(true, [6, 1]) }
  before do
    board.positions[6][1] = wbishop
  end

  context 'white bishop movement calculations' do
    # Check that the Bishop moves as expected when no pieces are in the way
    it 'should move horizontally/vertically from its starting coordinate' do
      wbishop.find_possible_moves(board.positions)
      expect(wbishop.possible_moves.sort).to eq([[0, 7], [1, 6], [2, 5], [3, 4],
                                                 [4, 3], [5, 0], [5, 2], [7, 0],
                                                 [7, 2]])
    end

    # Check that the Bishop cannot move through or onto pieces of the same color
    it 'should be unable to move through or onto pieces of the same color' do
      board.positions[7][2] = Pawn.new(true, [7, 2])
      board.positions[3][4] = Pawn.new(true, [3, 4])
      wbishop.find_possible_moves(board.positions)
      expect(wbishop.possible_moves.sort).to eq([[4, 3], [5, 0], [5, 2], [7, 0]])
    end

    # Check that the Bishop cannot move through pieces of the opposing color but can capture them
    it 'should be unable to move through pieces of the opposing color, but can move onto them' do
      board.positions[7][2] = Pawn.new(false, [7, 2])
      board.positions[3][4] = Pawn.new(false, [3, 4])
      wbishop.find_possible_moves(board.positions)
      expect(wbishop.possible_moves.sort).to eq([[3, 4], [4, 3], [5, 0], [5, 2],
                                                 [7, 0], [7, 2]])
    end
  end
end

# Create a black Bishop to check proper movement
describe Bishop do
  let(:nboard) { Board.new(true) }
  let(:bbishop) { Bishop.new(false, [4, 4]) }
  before do
    nboard.positions[4][4] = bbishop
  end

  context 'black bishop movement calculations' do
    # Check that the Bishop cannot move through or onto pieces of the same color
    it 'should not move through or onto pieces of the same color' do
      nboard.positions[5][5] = Pawn.new(false, [5, 5])
      nboard.positions[3][5] = Pawn.new(false, [3, 5])
      bbishop.find_possible_moves(nboard.positions)
      expect(bbishop.possible_moves.sort).to eq([[0, 0], [1, 1], [2, 2], [3, 3],
                                                 [5, 3], [6, 2], [7, 1]])
    end

    # Check that the Bishop cannot move through pieces of the opposing color but can capture them
    it 'should not move through pieces of the opposing color, but can move onto them' do
      nboard.positions[5][5] = Pawn.new(true, [5, 5])
      nboard.positions[3][5] = Pawn.new(true, [3, 5])
      bbishop.find_possible_moves(nboard.positions)
      expect(bbishop.possible_moves.sort).to eq([[0, 0], [1, 1], [2, 2], [3, 3],
                                                 [3, 5], [5, 3], [5, 5], [6, 2],
                                                 [7, 1]])
    end
  end
end
