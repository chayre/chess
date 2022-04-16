# frozen_string_literal: true
require_relative 'piece.rb'

# Class determining King behavior
class King < ChessPiece
  def initialize(color, position)
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
    @icon = color ? '♚' : '♔'
    @possible_moves = []
    super
  end
end
