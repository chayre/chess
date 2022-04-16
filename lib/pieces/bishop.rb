# frozen_string_literal: true
require_relative 'piece.rb'

# Class determining Bishop behavior
class Bishop < ChessPiece
  def initialize(color, position)
    @moveset = [
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1]
    ]
    @icon = color ? '♝' : '♗'
    @possible_moves = []
    super
  end
end