# frozen_string_literal: true
require_relative '../board.rb'
require_relative 'piece.rb'

# Class determining Bishop behavior
class Bishop < ChessPiece
  def initialize(position, is_white)
    @moveset = [
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1]
    ]
    @icon = is_white ? '♗' : '♝'
    @possible_moves = []
    super
  end
end