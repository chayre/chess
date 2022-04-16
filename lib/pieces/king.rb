# frozen_string_literal: true
require_relative '../board.rb'
require_relative 'piece.rb'

# Class determining King behavior
class King < ChessPiece
  def initialize(position, is_white)
    @moveset = [
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1],
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0]
    ]
    @icon = is_white ? '♔' : '♚'
    @possible_moves = []
    super
  end
end
