
require_relative '../lib/main'

# Create a white Queen
describe Queen do
  let(:board) { Board.new(true) }
  let(:queen) { Queen.new(true, [6, 1]) }
  before do
    board.positions[6][1] = queen
  end

  # Check that the Queen moves as expected
  context 'movement calculations' do
    it 'should move diagonally/horizontally/vertically from its starting coordinate' do
      queen.find_possible_moves(board.positions)
      expect(queen.possible_moves.sort).to eq([[0, 1], [0, 7], [1, 1], [1, 6],
                                               [2, 1], [2, 5], [3, 1], [3, 4],
                                               [4, 1], [4, 3], [5, 0], [5, 1],
                                               [5, 2], [6, 0], [6, 2], [6, 3],
                                               [6, 4], [6, 5], [6, 6], [6, 7],
                                               [7, 0], [7, 1], [7, 2]])
    end
  end
end