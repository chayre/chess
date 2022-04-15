# frozen_string_literal: true

# Class determining Knight behavior
Class Knight < ChessPiece
attr_accessor :color, :moveset, :x_position, :y_position, :possible_moves

  def initialize(color, position)
    @icon = color ? '♘' : '♞'
    @all_pieces ||= []
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
    @possible_moves = []
    @all_pieces << self
    super
  end
end