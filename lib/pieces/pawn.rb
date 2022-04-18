# frozen_string_literal: true
require_relative 'piece.rb'

# Class determining Pawn behavior
class Pawn < ChessPiece
  attr_accessor :has_moved

  def initialize(color, position)
    if color 
      @moveset = {
      one_step: [-1, 0],
      double_step: [-2, 0],
      right_diagonal: [-1, +1],
      left_diagonal: [-1, -1]
    }
    else
      @moveset = {
      one_step: [+1, 0],
      double_step: [+2, 0],
      right_diagonal: [+1, +1],
      left_diagonal: [+1, -1]
    }
    end
    @has_moved = false
    @icon = color ? '♟' : '♙'
    @possible_moves = []
    super
  end

  def find_possible_moves(positions)
    @possible_moves = []

    @moveset.each_key do |move_type|
      x = @x_position + @moveset[move_type][0]
      y = @y_position + @moveset[move_type][1]

      next unless (0..7).cover?(x) && (0..7).cover?(y)

      case move_type
      when :one_step
        @possible_moves << [x, y] if positions[x][y].nil?
      when :double_step
        @possible_moves << [x, y] if positions[x][y].nil? && positions[(x + @x_position) / 2][y].nil? && @has_moved == false
      when :right_diagonal, :left_diagonal
       @possible_moves << [x, y] if !positions[x][y].nil? && positions[x][y].color != @color
      end
    end
  end
end
