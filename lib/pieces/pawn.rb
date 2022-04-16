# frozen_string_literal: true
require_relative '../board.rb'
require_relative 'piece.rb'

# Class determining Pawn behavior
class Pawn < ChessPiece
  attr_accessor :color, :moveset, :x_position, :y_position, :possible_moves

  def initialize(color, position)
    @moveset = [
      [+0, +1]
    ]
    @icon = color ? '♙' : '♟'
    @possible_moves = []
    super
  end
end
