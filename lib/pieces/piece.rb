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

  # Based on the moveset, calculate the legal moves. There are three conditions:
  # 1. Cannot move off the board
  # 2. Cannot move onto another piece of the same color
  # 3. Cannot put its own King into check
  def find_possible_moves(positions)
    @possible_moves = []
    @moveset.each do |move|
      x = @x_position + move[0]*-1
      y = @y_position + move[1]*-1
      loop do
        break unless (0..7).cover?(x) && (0..7).cover?(y)
        @possible_moves << [x, y] if positions[x][y].nil? || positions[x][y].color != @color
        p [x, y]
        p positions[x][y] 
        #p positions[x][y].color
        break if !positions[x][y].nil?
        x += move[0]
        y += move[1]
      end
      p 'POSSIBLE MOVES::::'
      p @possible_moves
    end
  end
end