# frozen_string_literal: true

# Chess piece class from which all other pieces will inherit
class ChessPiece
  attr_accessor :color, :moveset, :x_position, :y_position, :possible_moves, :icon
  def initialize(color, position)
    # Color is false for black (absence of color) and true for white
    @color = color ? 'white' : 'black'
    # Position on board will be input as an array with two elements
    @x_position = position[0]
    @y_position = position[1]
    @possible_moves = []
  end

  # Based on the moveset, calculate the possible moves and add it to this piece's possible_moves array. There are three conditions:
  # 1. Cannot move off the board
  # 2. Cannot move onto another piece of the same color
  # 3. Cannot put its own King into check -- but we'll check this in another method. This method covers conditions 1 and 2.
  def find_possible_moves(positions)
    @possible_moves = []
    # For each move in the defined movesets (will be defined individually for each unique piece)
    @moveset.each do |move|
      x = @x_position + move[0]
      y = @y_position + move[1]
      loop do
        # (0..7).cover? checks if the value is within the given range to satisfy condition 1
        break unless (0..7).cover?(x) && (0..7).cover?(y)
        # This line adds the move to the possible_moves array if the desired position is empty or is occupied by a piece of the opposite color
        @possible_moves << [x, y] if positions[x][y].nil? || positions[x][y].color != @color
        # The line below specifies this move is invalid if the desired 
        break if !positions[x][y].nil?
        x += move[0]
        y += move[1]
      end
    end
  end
end