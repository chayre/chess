# frozen_string_literal: true
require_relative 'piece.rb'

# Class determining Pawn behavior
class Pawn < ChessPiece
  def initialize(color, position)
    @moveset = [
      [+1, +0],
      [+1, +1],
      [1, -1]
    ]
    @icon = color ? '♟' : '♙'
    @possible_moves = []
    super
  end
end
