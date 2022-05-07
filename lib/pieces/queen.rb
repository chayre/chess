# frozen_string_literal: true

require_relative 'piece'

# Class determining Queen behavior
# Methods: find_possible_moves (determines valid moves based on @moveset and board positions)
# Attributes: @moveset (all direction movement), @icon (black or white queen symbol), @possible_moves (array), @color (black or white), @x_position (0 - 7), @y_position (0 - 7)
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
    super
  end
end
