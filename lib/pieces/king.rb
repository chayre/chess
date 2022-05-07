# frozen_string_literal: true

require_relative 'piece'

# Class determining King behavior
class King < ChessPiece
  def initialize(color, position)
    @moveset = [
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1],
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0]
    ]
    @icon = color ? '♚' : '♔'
    @possible_moves = []
    super
  end

  # King class needs a special find_possible_moves method because it cannot move itself into checkmate (and it can't travel infinitely like bishop/queen/rook)
  def find_possible_moves(positions)
    @possible_moves = []

    # Add each of the king's moves to the current position
    @moveset.each do |move|
      x = @x_position + move[0]
      y = @y_position + move[1]

      # Execute if the hypothetical move stays within the confines of the board
      if (0..7).cover?(x) && (0..7).cover?(y)
        # Skip this process if the move is not onto a blank space or a piece of the opposite color
        # Need to use unless here, otherwise we'll get a bug when we try to find the .color attribute of a nil object
        next unless positions[x][y].nil? || positions[x][y].color != @color

        # Clone the current board positions
        hypothetical_positions = Board.clone(positions)
        # Pretend that we've moved the king from his current position ...
        hypothetical_positions[@x_position][@y_position] = nil
        # ... and moved him to the hypothetical move position
        # Case/when to differentiate between white/black King
        case @color
        when 'white'
          hypothetical_king = King.new(true, [x, y])
        when 'black'
          hypothetical_king = King.new(false, [x, y])
        end
        hypothetical_positions[x][y] = hypothetical_king

        # We need to check if, after our cloned King's hypothetical move, he has moved himself into a position where pieces of the enemy color can capture him in their next move
        hypothetical_positions.flatten.select { |item| item !=  nil && item.color != @color }.each do |piece|
          # For the enemy king, we need only check if their move is valid. It's impossible for kings to put each other in checkmate
          if piece.instance_of?(King)
            piece.moveset.each do |test_move|
              a = piece.x_position + test_move[0]
              b = piece.y_position + test_move[1]

              if (0..7).cover?(x) && (0..7).cover?(y)
                piece.possible_moves << [a, b]
              end
            end
          # If it's a piece other than an enemy king, find all of their possible moves given the hypothetical positions
          else
            piece.find_possible_moves(hypothetical_positions)
          end
        end
        # For each hypothetical king move, we'll go through every pieces' hypothetical move and make sure it can't counter our king's move with checkmate (because you can't move yourself into checkmate)
        @possible_moves << [x, y] unless hypothetical_king.in_check?(hypothetical_positions)
      end
    end
  end

  # Use this method to check if the king is in check (useful for finding king's moves, as we can make a hypothetical move then check if it puts the king in check)
  def in_check?(positions)
    in_check = false
    positions.flatten.select { |item| item !=  nil && item.color != @color }.each do |piece|
      # Pawns are checked differently because they can only capture sideways (so if a king is directly in front of them, they cannot capture)
      if piece.instance_of?(Pawn)
        piece.possible_moves.each do |move|
          # Our king has been placed in check if the pawn has moved sideways and captured our hypothetical king's position
          in_check = true if move[1] != piece.y_position && move == [@x_position, @y_position]
        end
      # Our king will also be in check if any enemy piece includes his position in their possible moveset
      else
        in_check = true if piece.possible_moves.include?([@x_position, @y_position])
      end
    end
    in_check
  end
end
