# frozen_string_literal: true

require_relative 'piece'

# Class determining Rook behavior
# Methods: find_possible_moves (determines valid moves based on @moveset and board positions)
# Attributes: @moveset (vertical/horizontal movement), @icon (black or white rook symbol), @possible_moves (array), @color (black or white), @x_position (0 - 7), @y_position (0 - 7)
class Rook < ChessPiece
  def initialize(color, position)
    @moveset = [
      [0, +1],
      [+1, 0],
      [0, -1],
      [-1, 0]
    ]
    @icon = color ? '♜' : '♖'
    super
  end
end
