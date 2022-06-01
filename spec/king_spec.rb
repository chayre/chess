require_relative '../lib/main'

# Create white King to test movement
describe King do
  let(:board) { Board.new(true) }
  let(:wking) { King.new(true, [1, 1]) }
  before do
    board.positions[1][1] = wking
  end

  # Testing king movement
  context 'movement calculations' do
    # Check that the king can move unidirectionally one space
    it 'can move one space in any direction when there are no restrictions' do
      board.positions[7][7] = Pawn.new(true, [7, 7])
      wking.find_possible_moves(board.positions)
      expect(wking.possible_moves.sort).to eq([[0, 0], [0, 1], [0, 2], [1, 0],
                                               [1, 2], [2, 0], [2, 1], [2, 2]])
    end

    # Check that the king cannot capture from his own team
    it "can't move onto a same-colored piece" do
      board.positions[1][2] = Pawn.new(true, [1, 2])
      wking.find_possible_moves(board.positions)
      expect(wking.possible_moves.sort).to eq([[0, 0], [0, 1], [0, 2], [1, 0],
                                               [2, 0], [2, 1], [2, 2]])
    end

    # Check that the king cannot move into the enemy pawn's line of attack, but can capture it
    it "can capture an enemy piece; can't move itself into checkmate" do
      board.positions[1][2] = Pawn.new(false, [1, 2])
      wking.find_possible_moves(board.positions)
      expect(wking.possible_moves.sort).to eq([[0, 0], [0, 1], [0, 2], [1, 0],
                                               [1, 2], [2, 0], [2, 2]])
    end

    # Check that the king cannot capture a piece if doing so will put him in checkmate
    it "can't capture a piece to put itself into checkmate" do
      board.positions[1][2] = Pawn.new(false, [1, 2])
      board.positions[1][7] = Rook.new(false, [1, 7])
      board.positions[1][2].find_possible_moves(board.positions)
      board.positions[1][7].find_possible_moves(board.positions)
      wking.find_possible_moves(board.positions)
      expect(wking.possible_moves.sort).to eq([[0, 0], [0, 1], [0, 2], [1, 0],
                                               [2, 0], [2, 2]])
    end
  end

  # Testing if the king registers as in check correctly
  context 'in check' do
    # Kings should not be able to move into line of attack of enemy pawns
    it 'shows in check when a pawn is threatening' do
      board.positions[0][0] = Pawn.new(false, [0, 0])
      board.positions[0][0].find_possible_moves(board.positions)
      expect(wking.in_check?(board.positions)).to be true
    end

    # Kings should not be able to move into line of attack of enemy knights
    it 'shows in check when a knight is threatening' do
      board.positions[3][2] = Knight.new(false, [3, 2])
      board.positions[3][2].find_possible_moves(board.positions)
      expect(wking.in_check?(board.positions)).to be true
    end

    # Kings should not be able to move into line of attack of enemy rooks
    it 'shows in check when a rook is threatening' do
      board.positions[7][1] = Rook.new(false, [7, 1])
      board.positions[7][1].find_possible_moves(board.positions)
      expect(wking.in_check?(board.positions)).to be true
    end

    # Kings should not be able to move into line of attack of enemy bishops
    it 'shows in check when a bishop is threatening' do
      board.positions[7][7] = Bishop.new(false, [7, 7])
      board.positions[7][7].find_possible_moves(board.positions)
      expect(wking.in_check?(board.positions)).to be true
    end

    # Kings should not be able to move into line of attack of enemy queens
    it 'shows in check when a queen is threatening' do
      board.positions[1][7] = Queen.new(false, [1, 7])
      board.positions[1][7].find_possible_moves(board.positions)
      expect(wking.in_check?(board.positions)).to be true
    end
  end
end
