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
    @current_player = nil
  end

  def initialize_player
    @player1 = Player.new(true)
    @player2 = Player.new(false)
    @current_player = @player1
  end

  def switch_player
    @current_player.color == 'white' ? @current_player = @player2 : @current_player = @player1
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
      p piece
      update_possible_moves
      p piece
      break if !piece.nil? && piece.possible_moves.include?(desired_position) && piece.color == @current_player.color
      print "\nInvalid move. Try again.\n> "
    end

    move(current_position, desired_position, piece)
    switch_player
  end

  def game_setup
    @board.fill_board
    @board.logo
    @board.display
    initialize_player
  end

  def play_game
    game_setup
    until checkmate?
      play_turn
      @board.display
    end
  end

  def checkmate?
    @board.positions.flatten.select {|square| square.instance_of?(King) && square.color == @current_player.color }.each do |king|
      p 'nothing'
      return false if !king.in_check?(@board.positions)
      p 'IN CHECK'
      return false if any_breaks_checks? == true
      p 
      return false if !king.possible_moves.empty?
    end
    true
  end

  def breaks_check?(current, desired)
    breaks_check = false
    cache = Marshal.load(Marshal.dump(@board.positions))

    move(current, desired)
    @board.positions.flatten.select { |square| !square.nil? && square.instance_of?(King) && square.color == current_color }.each do |king|
      breaks_check = true if king.in_check?(@board.positions) == false
    end
    @board.positions = cache
    update_possible_moves
    breaks_check
  end
  
  def any_breaks_checks?
    @board.positions.flatten.select { |square| !square.nil? && square.color == @current_player.color }.each do |piece|
      piece.possible_moves.each do |move|
        if breaks_check?([piece.x, piece.y], move)
          return true
        end
      end
    end
    false
  end

  def update_possible_moves
    @board.positions.flatten.each do |piece|
      piece&.find_possible_moves(@board.positions)
    end
  end

  def move(current, desired, piece)
    @board.positions[current[0]][current[1]] = nil
    @board.positions[desired[0]][desired[1]] = piece
    piece.x_position = desired[0]
    piece.y_position = desired[1]
  end

  def display
    @board.display
  end

  def normalize(array)
    array[1] = array[1].ord - 97
    array[0] = 7 - (array[0].to_i - 1)
    array
  end
end

game = Chess.new
#game.game_setup
game.play_game

