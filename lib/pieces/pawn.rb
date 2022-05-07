# frozen_string_literal: true

require_relative 'piece'

# Class determining Pawn behavior
# Methods: find_possible_moves (determines valid moves based on @moveset and board positions)
# Attributes: @moveset (up/down only; diagonal up/down to capture), @icon (black or white pawn symbol), @possible_moves (array), @color (black or white), @x_position (0 - 7), @y_position (0 - 7)
class Pawn < ChessPiece
  attr_accessor :has_moved

  def initialize(color, position)
    # Color is a true/false input (mapping to white/black); if the color is true (white) we set it so it can move only up the board...
    if color 
      @moveset = {
      one_step: [-1, 0],
      double_step: [-2, 0],
      right_diagonal: [-1, +1],
      left_diagonal: [-1, -1]
      }
    # ... and if the color is false (black) we set it so it can only move down the board
    else
      @moveset = {
      one_step: [+1, 0],
      double_step: [+2, 0],
      right_diagonal: [+1, +1],
      left_diagonal: [+1, -1]
      }
    end
    # Pawns can only double-step if they haven't moved before; track this property in the instance variable @has_moved
    @has_moved = false
    @icon = color ? '♟' : '♙'
    @possible_moves = []
    super
  end

  # We redefine the find_possible_moves method, of which a different version is contained in the piece class, because pawns have some special movement behavior
  # Unlike most other pieces, they cannot move indefinitely in a straight line, they can only move diagonally to capture, and they can only double-step if they haven't moved
  def find_possible_moves(positions)
    @possible_moves = []

    # Check if the pawn has moved and set has_moved variable appropriately. Pawns cannot move back into their starting row, so if it isn't there it must have moved
    case @color
    when 'white'
      @has_moved = true if @x_position != 6
    when 'black'
      @has_moved = true if @x_position != 1
    end

    # Iterate through each move that a pawn can do and check if it's possible; if it is, add to the possible_moves array
    @moveset.each_key do |move_type|
      x = @x_position + @moveset[move_type][0]
      y = @y_position + @moveset[move_type][1]

      # Ensure move is within confines of board
      next unless (0..7).cover?(x) && (0..7).cover?(y)

      case move_type
      # Pawns can't move forward if there's another piece blocking them
      when :one_step
        @possible_moves << [x, y] if positions[x][y].nil?
      # Pawns can only double step if they haven't moved and they aren't being blocked
      when :double_step
        @possible_moves << [x, y] if positions[x][y].nil? && @has_moved == false
        # Pawns can only move diagonally when there's a piece directly diagonal that's of the opposing color
      when :right_diagonal, :left_diagonal
        @possible_moves << [x, y] if !positions[x][y].nil? && positions[x][y].color != @color
      end
    end
  end
end
