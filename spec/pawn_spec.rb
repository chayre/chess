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

  context 'movement calculations' do
    context 'white pawn' do
      it 'can move one upward' do
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).to include([5, 5])
      end

      it 'can be blocked by a white piece' do
        board.positions[5][5] = Pawn.new(true, [5, 5])
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).not_to include([5, 5])
      end

      it 'can be blocked by a black piece' do
        board.positions[5][5] = Pawn.new(false, [5, 5])
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).not_to include([5, 5])
      end

      it 'can move two spaces on its first move' do
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).to include([4, 5])
      end

      it 'can have its double-move blocked by a white piece two above it' do
        board.positions[4][5] = Pawn.new(true, [4, 5])
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).not_to include([4, 5])
      end

      it 'can have its double-move blocked by a black piece two above it' do
        board.positions[4][5] = Pawn.new(false, [4, 5])
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).not_to include([4, 5])
      end

      it 'can be blocked by a white piece diagonally upward left' do
        board.positions[5][4] = Pawn.new(true, [5, 4])
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).not_to include([5, 4])
      end

      it 'can capture a black piece diagonally upward left' do
        board.positions[5][4] = Pawn.new(false, [5, 4])
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).to include([5, 4])
      end

      it 'can be blocked by a white piece diagonally upward right' do
        board.positions[5][6] = Pawn.new(true, [5, 6])
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).not_to include([5, 6])
      end

      it 'can capture a black piece diagonally upward right' do
        board.positions[5][6] = Pawn.new(false, [5, 6])
        wpawn.find_possible_moves(board.positions)
        expect(wpawn.possible_moves).to include([5, 6])
      end
    end

    context 'black pawn' do
      it 'can move one downward' do
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).to include([2, 2])
      end

      it 'can be blocked by a black piece' do
        board.positions[2][2] = Pawn.new(false, [2, 2])
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).not_to include([2, 2])
      end

      it 'can be blocked by a white piece' do
        board.positions[2][2] = Pawn.new(true, [2, 2])
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).not_to include([2, 2])
      end

      it 'can move two spaces on its first move' do
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).to include([3, 2])
      end

      it 'can have its double-move blocked by a black piece two below it' do
        board.positions[3][2] = Pawn.new(false, [3, 2])
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).not_to include([3, 2])
      end

      it 'can have its double-move blocked by a white piece two below it' do
        board.positions[3][2] = Pawn.new(true, [3, 2])
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).not_to include([3, 2])
      end

      it 'can be blocked by a black piece diagonally downward left' do
        board.positions[2][1] = Pawn.new(false, [2, 1])
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).not_to include([2, 1])
      end

      it 'can capture a white piece diagonally downward left' do
        board.positions[2][1] = Pawn.new(true, [2, 1])
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).to include([2, 1])
      end

      it 'can be blocked by a black piece diagonally downward right' do
        board.positions[2][3] = Pawn.new(false, [2, 3])
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).not_to include([2, 3])
      end

      it 'can capture a white piece diagonally downward right' do
        board.positions[2][3] = Pawn.new(true, [2, 3])
        bpawn.find_possible_moves(board.positions)
        expect(bpawn.possible_moves).to include([2, 3])
      end
    end
  end
end