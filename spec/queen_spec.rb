require_relative '../lib/main'

# Create a white Queen to check proper movement
describe Queen do
  let(:board) { Board.new(true) }
  let(:wqueen) { Queen.new(true, [6, 1]) }
  before do
    board.positions[6][1] = wqueen
  end

  context 'white queen movement calculations' do
    # Check that the Queen moves as expected when no pieces are in the way
    it 'should move diagonally/horizontally/vertically from its starting coordinate' do
      wqueen.find_possible_moves(board.positions)
      expect(wqueen.possible_moves.sort).to eq([[0, 1], [0, 7], [1, 1], [1, 6],
                                               [2, 1], [2, 5], [3, 1], [3, 4],
                                               [4, 1], [4, 3], [5, 0], [5, 1],
                                               [5, 2], [6, 0], [6, 2], [6, 3],
                                               [6, 4], [6, 5], [6, 6], [6, 7],
                                               [7, 0], [7, 1], [7, 2]])
    end

    # Check that the Queen cannot move through or onto pieces of the same color
    it 'should be unable to move through or onto pieces of the same color' do
      board.positions[5][2] = Pawn.new(true, [5, 2])
      board.positions[4][1] = Pawn.new(true, [4, 1])
      wqueen.find_possible_moves(board.positions)
      expect(wqueen.possible_moves.sort).to eq([[5, 0], [5, 1], [6, 0], [6, 2],
                                               [6, 3], [6, 4], [6, 5], [6, 6],
                                               [6, 7], [7, 0], [7, 1], [7, 2]])
    end

    # Check that the queen cannot move through pieces of the opposing color but can capture them
    it 'should be unable to move through pieces of the opposing color, but can move onto them' do
      board.positions[5][2] = Pawn.new(false, [5, 2])
      board.positions[4][1] = Pawn.new(false, [4, 1])
      wqueen.find_possible_moves(board.positions)
      expect(wqueen.possible_moves.sort).to eq([[4, 1], [5, 0], [5, 1], [5, 2],
                                               [6, 0], [6, 2], [6, 3], [6, 4],
                                               [6, 5], [6, 6], [6, 7], [7, 0],
                                               [7, 1], [7, 2]])
    end
  end
end

# Create a black Queen to check proper movement
describe Queen do
  let(:nboard) { Board.new(true) }
  let(:bqueen) { Queen.new(false, [4, 4]) }
  before do
    nboard.positions[4][4] = bqueen
  end

  context 'black queen movement calculations' do
    # Check that the Queen cannot move through or onto pieces of the same color
    it 'should not move through or onto pieces of the same color' do
      nboard.positions[2][4] = Pawn.new(false, [2, 4])
      nboard.positions[4][3] = Pawn.new(false, [4, 3])
      bqueen.find_possible_moves(nboard.positions)
      expect(bqueen.possible_moves.sort).to eq([[0, 0], [1, 1], [1, 7], [2, 2],
                                                [2, 6], [3, 3], [3, 4], [3, 5],
                                                [4, 5], [4, 6], [4, 7], [5, 3],
                                                [5, 4], [5, 5], [6, 2], [6, 4],
                                                [6, 6], [7, 1], [7, 4], [7, 7]])
    end

    # Check that the Queen cannot move through pieces of the opposing color but can capture them
    it 'should not move through pieces of the opposing color, but can move onto them' do
      nboard.positions[2][4] = Pawn.new(true, [2, 4])
      nboard.positions[4][3] = Pawn.new(true, [4, 3])
      bqueen.find_possible_moves(nboard.positions)
      expect(bqueen.possible_moves.sort).to eq([[0, 0], [1, 1], [1, 7], [2, 2],
                                                [2, 4], [2, 6], [3, 3], [3, 4],
                                                [3, 5], [4, 3], [4, 5], [4, 6],
                                                [4, 7], [5, 3], [5, 4], [5, 5],
                                                [6, 2], [6, 4], [6, 6], [7, 1],
                                                [7, 4], [7, 7]])
    end
  end
end
