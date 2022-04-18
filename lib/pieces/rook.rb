# frozen_string_literal: true

require_relative 'piece'

# Class determining Rook behavior
class Rook < ChessPiece
  def initialize(color, position)
    @moveset = [
      [0, +1],
      [+1, 0],
      [0, -1],
      [-1, 0]
    ]
    @icon = color ? '♜' : '♖'
    @possible_moves = []
    super
  end
end
