require_relative '../lib/main'

# Create a white pawn to test movement
describe Pawn do
  let(:board) { Board.new(true) }
  let(:wpawn) { Pawn.new(true, [6, 5]) }
  let(:bpawn) { Pawn.new(false, [1, 2]) }
  before do
    board.positions[6][5] = wpawn
    board.positions[1][2] = bpawn
  end
  
  # Check pawns for correct movement behavior
  context 'movement calculations' do
    context 'white pawn' do
      # White pawns can move upward once (only upward, not bidirectional)
      it 'can move one upward' do
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).to include([5, 5])
      end

      # White pawns can blocked by other white pieces that are above them
      it 'can be blocked by a white piece' do
        board.positions[5][5] = Pawn.new(true, [5, 5])
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).not_to include([5, 5])
      end

      # White pawns can blocked by other black pieces that are above them
      it 'can be blocked by a black piece' do
        board.positions[5][5] = Pawn.new(false, [5, 5])
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).not_to include([5, 5])
      end

      # White pawns can move two spaces if they have not moved yet
      it 'can move two spaces on its first move' do
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).to include([4, 5])
      end

      # White pawns can have their double-move blocked by other white pieces that are above them
      it 'can have its double-move blocked by a white piece two above it' do
        board.positions[4][5] = Pawn.new(true, [4, 5])
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).not_to include([4, 5])
      end

      # White pawns can have their double-move blocked by black pieces that are above them
      it 'can have its double-move blocked by a black piece two above it' do
        board.positions[4][5] = Pawn.new(false, [4, 5])
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).not_to include([4, 5])
      end

      # White pawns cannot capture white pieces diagnoally upward left
      it 'can be blocked by a white piece diagonally upward left' do
        board.positions[5][4] = Pawn.new(true, [5, 4])
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).not_to include([5, 4])
      end

      # White pawns can capture black pieces diagonally upward left
      it 'can capture a black piece diagonally upward left' do
        board.positions[5][4] = Pawn.new(false, [5, 4])
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).to include([5, 4])
      end

      # White pawns cannot capture white pieces diagonally upward right
      it 'can be blocked by a white piece diagonally upward right' do
        board.positions[5][6] = Pawn.new(true, [5, 6])
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).not_to include([5, 6])
      end

      # White pawns can capture black pieces diagonally upward right
      it 'can capture a black piece diagonally upward right' do
        board.positions[5][6] = Pawn.new(false, [5, 6])
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).to include([5, 6])
      end
    end

    context 'black pawn' do
      # Black pawns can move downward once (only downward, not bidirectional)
      it 'can move one downward' do
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).to include([2, 2])
      end

      # Black pawns can blocked by other black pieces that are below them
      it 'can be blocked by a black piece' do
        board.positions[2][2] = Pawn.new(false, [2, 2])
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).not_to include([2, 2])
      end

      # Black pawns can blocked by other white pieces that are below them
      it 'can be blocked by a white piece' do
        board.positions[2][2] = Pawn.new(true, [2, 2])
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).not_to include([2, 2])
      end

      # Black pawns can move two spaces if they have not moved yet
      it 'can move two spaces on its first move' do
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).to include([3, 2])
      end

      # Black pawns can have their double-move blocked by other black pieces that are below them
      it 'can have its double-move blocked by a black piece two below it' do
        board.positions[3][2] = Pawn.new(false, [3, 2])
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).not_to include([3, 2])
      end

      # Black pawns can have their double-move blocked by other white pieces that are below them
      it 'can have its double-move blocked by a white piece two below it' do
        board.positions[3][2] = Pawn.new(true, [3, 2])
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).not_to include([3, 2])
      end

      # Black pawns cannot capture black pieces diagonally downward left
      it 'can be blocked by a black piece diagonally downward left' do
        board.positions[2][1] = Pawn.new(false, [2, 1])
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).not_to include([2, 1])
      end

      # Black pawns can capture white pieces diagonally downward left
      it 'can capture a white piece diagonally downward left' do
        board.positions[2][1] = Pawn.new(true, [2, 1])
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).to include([2, 1])
      end

      # Black pawns cannot capture black pieces diagonally downward right
      it 'can be blocked by a black piece diagonally downward right' do
        board.positions[2][3] = Pawn.new(false, [2, 3])
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).not_to include([2, 3])
      end

      # Black pawns can capture white pieces diagonally downward right
      it 'can capture a white piece diagonally downward right' do
        board.positions[2][3] = Pawn.new(true, [2, 3])
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).to include([2, 3])
      end
    end
  end
end