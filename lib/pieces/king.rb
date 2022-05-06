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


  def find_possible_moves(positions)
    @possible_moves = []

    @moveset.each do |move|
      x = @x_position + move[0]
      y = @y_position + move[1]

      if (0..7).cover?(x) && (0..7).cover?(y)

        test_positions = Marshal.load(Marshal.dump(positions))

        test_positions[@x_position][@y_position] = nil
        test_king = King.new(true, [x, y])
        test_positions[x][y] = test_king

        test_positions.flatten.select { |square| square !=  nil && square.color != @color }.each do |piece| 
          if piece.instance_of?(King)
            piece.moveset.each do |test_move|
              a = piece.x_position + test_move[0]
              b = piece.y_position + test_move[1]

              if (0..7).cover?(x) && (0..7).cover?(y)
                piece.possible_moves << [a, b]
              end
            end
          else
            piece.find_possible_moves(test_positions)
          end
        end
        @possible_moves << [x, y] if !test_king.in_check?(test_positions) && (positions[x][y].nil? || positions[x][y].color != @color)
      end
    end
  end

  def in_check?(positions)
    in_check = false
    positions.flatten.select { |piece| !piece.nil? && piece.color != @color }.each do |piece|
      if piece.instance_of? Pawn
        piece.possible_moves.each do |move|
          in_check = true if move[1] != piece.y_position && move == [@x_position, @y_position]
        end
      else
        in_check = true if piece.possible_moves.include?([@x_position, @y_position])
      end
    end
    in_check
  end
end
