# frozen_string_literal: true
require_relative '../board.rb'
require_relative 'piece.rb'

# Class determining Knight behavior
class Knight < ChessPiece
  attr_accessor :color, :moveset, :x_position, :y_position, :possible_moves

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
    @icon = color ? '♘' : '♞'
    @possible_moves = []
    super
  end
end
