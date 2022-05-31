# frozen_string_literal: true

require_relative '../lib/chess'

# Ensure that filling the board using the fill_board method creates the objects we expect at the correct positions
RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#initial_placement' do
    before do
      board.fill_board
    end
    
    # Row 0 should be full of black pieces
    it 'has top row of black pieces' do
      expect(board.positions[0].all? {|piece| piece.color == 'black'}).to be true
    end
    # Row 1 should be full of black pieces
    it 'has second to top row of black pieces' do
        expect(board.positions[1].all? {|piece| piece.color == 'black'}).to be true
      end

    # Row 6 should be full of white pieces
    it 'has bottom row of white pieces' do
      expect(board.positions[6].all? {|piece| piece.color == 'white'}).to be true
    end

    # Row 7 should be full of white pieces
    it 'has second to bottom row of white pieces' do
      expect(board.positions[7].all? {|piece| piece.color == 'white'}).to be true
    end

    # Rows 2 through 5 should be full of nil 
    it 'has four rows of nil in the middle' do
      expect(board.positions[2].all? {|piece| piece.nil?}).to be true
      expect(board.positions[3].all? {|piece| piece.nil?}).to be true
      expect(board.positions[4].all? {|piece| piece.nil?}).to be true
      expect(board.positions[5].all? {|piece| piece.nil?}).to be true
    end

    # Row 1 should be all pawns
    it 'has a second to top row of pawns' do
        expect(board.positions[1].all? { |piece| piece.instance_of?(Pawn) }).to be true
      end

    # Row 6 should be all pawns
    it 'has a second to bottom row of pawns' do
      expect(board.positions[6].all? { |piece| piece.instance_of?(Pawn) }).to be true
    end

    # Rooks should begin at [0, 0]/[0, 7] and [7, 0]/[7, 7]
    it 'has rooks in the correct position' do
      expect(board.positions[0][0].instance_of?(Rook) && board.positions[0][7].instance_of?(Rook)).to be true
      expect(board.positions[7][0].instance_of?(Rook) && board.positions[7][7].instance_of?(Rook)).to be true
    end

    # Knights should begin at [0, 1]/[0, 6] and [7, 1]/[7, 6]
    it 'has knights in the correct position' do
      expect(board.positions[0][1].instance_of?(Knight) && board.positions[0][6].instance_of?(Knight)).to be true
      expect(board.positions[7][1].instance_of?(Knight) && board.positions[7][6].instance_of?(Knight)).to be true
    end

    # Bishops should begin at [0, 2]/[0, 5] and [7, 2]/[7, 5]
    it 'has bishops in the correct position' do
      expect(board.positions[0][2].instance_of?(Bishop) && board.positions[0][5].instance_of?(Bishop)).to be true
      expect(board.positions[7][2].instance_of?(Bishop) && board.positions[7][5].instance_of?(Bishop)).to be true
    end

    # Kings should begin at [0, 4] and [7, 4]
    it 'has kings in the correct position' do
      expect(board.positions[0][4].instance_of?(King) && board.positions[7][4].instance_of?(King)).to be true
    end

    # Queens should begin at [0, 3] and [7, 3]
    it 'has queens in the correct position' do
      expect(board.positions[0][3].instance_of?(Queen) && board.positions[7][3].instance_of?(Queen)).to be true
    end
  end
end