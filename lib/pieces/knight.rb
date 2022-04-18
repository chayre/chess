# frozen_string_literal: true
require_relative 'piece.rb'

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

  def find_possible_moves(positions)
    @possible_moves = []

    @moveset.each do |move|
      x = @x_position + move[0]
      y = @y_position + move[1]

      if (0..7).cover?(x) && (0..7).cover?(y)
        @possible_moves << [x, y] if positions[x][y].nil? || positions[x][y].color != @color
      end
    end
  end
end
