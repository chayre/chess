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

    it 'has a second to top row of pawns' do
        expect(board.positions[1].all? { |piece| piece.instance_of?(Pawn) }).to be true
      end

    it 'has a second to bottom row of pawns' do
      expect(board.positions[6].all? { |piece| piece.instance_of?(Pawn) }).to be true
    end

    it 'has a has rooks in the correct position' do
        expect(board.positions[0][0].instance_of?(Rook) && board.positions[0][7].instance_of?(Rook) && board.positions[7][0].instance_of?(Rook) && board.positions[7][7].instance_of?(Rook)).to be true
      end


  end
end