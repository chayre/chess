# frozen_string_literal: true

require_relative 'piece'

# Class determining Bishop behavior
# Methods: find_possible_moves (determines valid moves based on @moveset and board positions)
# Attributes: @moveset (diagonal movement), @icon (black or white bishop symbol), @possible_moves (array), @color (black or white), @x_position (0 - 7), @y_position (0 - 7)
class Bishop < ChessPiece
  def initialize(color, position)
    @moveset = [
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1]
    ]
    @icon = color ? '♝' : '♗'
    super
  end
end