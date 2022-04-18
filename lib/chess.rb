# frozen_string_literal: true
require_relative 'pieces/knight.rb'
require_relative 'pieces/queen.rb'
require_relative 'pieces/rook.rb'
require_relative 'pieces/bishop.rb'
require_relative 'pieces/king.rb'
require_relative 'pieces/pawn.rb'
require_relative 'board.rb'
require_relative 'player.rb'

# Class which places pieces on the board, tracks them in a positions array, and draws the board
class Chess
  attr_accessor :positions, :board, :white_player, :black_player, :current_player

  def initialize
    @board = Board.new
    @player1 = nil
    @player2 = nil
    initialize_player
    @current_player = @player1
  end

  def initialize_player
    @player1 = Player.new(true)
    @player2 = Player.new(false)
  end

  def play_game
    play_turn
    switch_player

  end

  def switch_player
    if @current_player.color
      @current_player = @player2
    else
      @current_player = @player1
    end
  end 


  def play_turn
    print "It's your turn, #{@current_player.name}. Write your move as (for example): C5 to D3\n\n"
    move = nil
    current_position = nil
    desired_position = nil
    piece = nil

    loop do
      move = @current_player.input_get
      current_position = normalize([move[2], move[1]])
      desired_position = normalize([move[4], move[3]])
      piece = @board.positions[current_position[0]][current_position[1]]
      update_possible_moves
      break if !piece.nil? && piece.possible_moves.include?(desired_position) && piece.color == @current_player.color
      print "\nInvalid move. Try again.\n> "
    end

    move(current_position, desired_position, piece)
  end

  def update_possible_moves
    @board.positions.flatten.each do |piece|
      piece&.find_possible_moves(@board.positions)
    end
  end

  def move(current, desired, piece)
    @board.positions[current[0]][current[1]] = nil
    @board.positions[desired[0]][desired[1]] = piece
    @board.display
  end

  def display
    @board.display
  end

  def normalize(array)
    array[1] = array[1].ord - 97
    array[0] = 7 - (array[0].to_i - 1)
    p array
    array
  end

end

game = Chess.new
game.play_turn


