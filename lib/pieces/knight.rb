# frozen_string_literal: true

require_relative 'piece'

# Class determining Knight behavior
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
    @possible_moves = []
    super
  end

  # Unlike queen/rook/bishop, knight cannot travel along its moveset in a single turn. Therefore, we use this extra method.
  def find_possible_moves(positions)
    @possible_moves = []

    @moveset.each do |move|
      x = @x_position + move[0]
      y = @y_position + move[1]
      # If the move is contained in the board and the desired position is empty or contains a piece of the opposite color...
      if (0..7).cover?(x) && (0..7).cover?(y)
        @possible_moves << [x, y] if positions[x][y].nil? || positions[x][y].color != @color
      end
    end
  end
end
