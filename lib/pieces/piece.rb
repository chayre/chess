# frozen_string_literal: true

# Chess piece class from which all other pieces will inherit
# Methods: find_possible_moves (determines valid moves based on @moveset and board positions)
# Attributes: @color (black or white), @x_position (0 - 7), @y_position (0 - 7)
class ChessPiece
  attr_accessor :color, :moveset, :x_position, :y_position, :possible_moves, :icon

  def initialize(color, position)
    # Color is false for black (absence of color) and true for white
    @color = color ? 'white' : 'black'
    # Position on board will be input as an array with two elements
    @x_position = position[0]
    @y_position = position[1]
  end

  # Based on the moveset, calculate the possible moves and add it to this piece's possible_moves array. There are three conditions:
  # 1. Cannot move off the board
  # 2. Cannot move onto another piece of the same color
  # 3. Cannot put its own King into check -- but we'll check this in another method, in chess.rb. This method covers conditions 1 and 2.
  def find_possible_moves(positions)
    @possible_moves = []
    # For each move in the defined movesets (will be defined individually for each unique piece)
    @moveset.each do |move|
      # Calculate the hypothetical move by adding a move to the current position
      x = @x_position + move[0]
      y = @y_position + move[1]
      loop do
        # (0..7).cover? checks if the value is within the given range to satisfy condition 1
        break unless (0..7).cover?(x) && (0..7).cover?(y)

        # Add the move to the possible_moves array if the desired position is empty or is occupied by a piece of the opposite color
        @possible_moves << [x, y] if positions[x][y].nil? || positions[x][y].color != @color
        # For pieces that can move in a straight line across the board, like the rook, we need to check if its possible move will hit a piece
        # Otherwise, it might be able to move through a line of pawns into the back line of enemy pieces, which is an invalid move
        break if !positions[x][y].nil?

        # As long as we haven't hit any pieces, we'll keep adding moves in this straight line
        x += move[0]
        y += move[1]
      end
    end
  end
end
