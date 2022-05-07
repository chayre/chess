# frozen_string_literal: true

require_relative '../lib/chess'

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#initial_placement' do
    before do
      board.fill_board
    end

    it 'has top row of black pieces' do
      expect(board.positions[0].all? {|piece| piece.color == 'black'}).to be true
    end

    it 'has second to top row of black pieces' do
        expect(board.positions[0].all? {|piece| piece.color == 'black'}).to be true
      end

    it 'has bottom row of white pieces' do
      expect(board.positions[6].all? {|piece| piece.color == 'white'}).to be true
    end

    it 'has second to bottom row of white pieces' do
      expect(board.positions[7].all? {|piece| piece.color == 'white'}).to be true
    end

    it 'has four rows of nil in the middle' do
      expect(board.positions[2].all? {|piece| piece.nil?}).to be true
      expect(board.positions[3].all? {|piece| piece.nil?}).to be true
      expect(board.positions[4].all? {|piece| piece.nil?}).to be true
      expect(board.positions[5].all? {|piece| piece.nil?}).to be true
    end

    it 'has a second to top row of pawns' do
        expect(board.positions[1].all? { |piece| piece.instance_of?(Pawn) }).to be true
      end

    it 'has a second to bottom row of pawns' do
      expect(board.positions[6].all? { |piece| piece.instance_of?(Pawn) }).to be true
    end

    it 'has rooks in the correct position' do
      expect(board.positions[0][0].instance_of?(Rook) && board.positions[0][7].instance_of?(Rook)).to be true
      expect(board.positions[7][0].instance_of?(Rook) && board.positions[7][7].instance_of?(Rook)).to be true
    end

    it 'has knights in the correct position' do
      expect(board.positions[0][1].instance_of?(Knight) && board.positions[0][6].instance_of?(Knight)).to be true
      expect(board.positions[7][1].instance_of?(Knight) && board.positions[7][6].instance_of?(Knight)).to be true
    end

    it 'has bishops in the correct position' do
      expect(board.positions[0][2].instance_of?(Bishop) && board.positions[0][5].instance_of?(Bishop)).to be true
      expect(board.positions[7][2].instance_of?(Bishop) && board.positions[7][5].instance_of?(Bishop)).to be true
    end

    it 'has kings in the correct position' do
      expect(board.positions[0][4].instance_of?(King) && board.positions[7][4].instance_of?(King)).to be true
    end

    it 'has queens in the correct position' do
      expect(board.positions[0][3].instance_of?(Queen) && board.positions[7][3].instance_of?(Queen)).to be true
    end
  end
end