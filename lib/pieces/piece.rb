# frozen_string_literal: true

# Chess piece class from which all other pieces will inherit
class ChessPiece
  attr_accessor :color, :moveset, :x_position, :y_position, :possible_moves, :icon
  def initialize(color, position)
    # Color is false for black (absence of color) and true for white
    @color = color ? 'white' : 'black'
    # Position on board will be input as an array with two elements
    @y_position = position[0]
    @x_position = position[1]
    @possible_moves = []
  end

  # Based on the moveset, calculate the legal moves. There are three conditions:
  # 1. Cannot move off the board
  # 2. Cannot move onto another piece of the same color
  # 3. Cannot put its own King into check
  def find_possible_moves()
    @possible_moves = [board]
    @moveset.each do |move|
      if (0..7).include?(move[0] + @y_position) && (0..7).include?(move[1] + @x_position)
        board.each do |piece|
          if piece.color == @color && piece.y_position == (move[0] + @y_position) && piece.y_position == (move[1] + @x_position) 
            next
          else
            @possible_moves << [move[0] + @y_position, move[1] + @x_position]
          end
        end
      end
    end
    @possible_moves
  end

end