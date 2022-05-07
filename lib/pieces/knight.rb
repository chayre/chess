# frozen_string_literal: true

require_relative 'piece'

# Class determining Knight behavior
# Methods: find_possible_moves (determines valid moves based on @moveset and board positions)
# Attributes: @moveset (over two, up one moves), @icon (black or white knight symbol), @possible_moves (array), @color (black or white), @x_position (0 - 7), @y_position (0 - 7)
class Knight < ChessPiece
  def initialize(color, position)
    @moveset = [
      [-1, -2],
      [-2, -1],
      [-2, +1],
      [-1, +2],
      [+1, -2],
      [+2, -1],
      [+2, +1],
      [+1, +2]
    ]
    @icon = color ? '♞' : '♘'
    super
  end

  # Unlike queen/rook/bishop, knight cannot travel along its moveset in a single turn. Therefore, we use this extra method
  def find_possible_moves(positions)
    @possible_moves = []

    @moveset.each do |move|
      x = @x_position + move[0]
      y = @y_position + move[1]
      # If the move is contained in the board and the desired position is empty or contains a piece of the opposite color, add it to the possible moves array
      if (0..7).cover?(x) && (0..7).cover?(y)
        @possible_moves << [x, y] if positions[x][y].nil? || positions[x][y].color != @color
      end
    end
  end
end
