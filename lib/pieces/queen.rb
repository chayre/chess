# frozen_string_literal: true

require_relative 'piece'

# Class determining Queen behavior
class Queen < ChessPiece
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
    @icon = color ? '♛' : '♕'
    @possible_moves = []
    super
  end
end
