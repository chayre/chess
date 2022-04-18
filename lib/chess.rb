# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# Class which places pieces on the board, tracks them in a positions array, and draws the board
class Chess
  attr_accessor :positions, :board, :white_player, :black_player, :current_player, :standby_player

  # When you start a new game, initialize the board 
  def initialize
    @board = Board.new
    @player1 = nil
    @player2 = nil
    @current_player = nil
    @standby_player = nil
  end

  # Create two instances of the player class, one for white and black. Set the current player to white (as they'll go first)
  def initialize_player
    @player1 = Player.new(true)
    @player2 = Player.new(false)
    @current_player = @player1
    @standby_player = @player2
  end

  # At the end of the turn, switch the commanding player from the current to standby
  def switch_player
    if @current_player.color == 'white'
      @current_player = @player2
      @standby_player = @player1
    else
      @current_player = @player1
      @standby_player = @player2
    end
  end 

  # Get the move input; normalize it to two position arrays. Check if the move is possible and loop again if it's not
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
    until checkmate? || draw?
      play_turn
      @board.display
    end
  end

  def checkmate?
    update_possible_moves
    @board.positions.flatten.select {|square| square.instance_of?(King) && square.color == @current_player.color }.each do |king|
      return false if !king.in_check?(@board.positions)
      puts "#{@current_player.name}, your #{@current_player.color} king is in check!"
      return false if any_breaks_checks? == true
      return false if !king.possible_moves.empty?
    end
    puts "#{@current_player.name}, the #{@current_player.color} king is in checkmate. #{@standby_player.name}, #{@standby_player.color} wins!"
    return true
  end

  def draw?
    white_count = 0
    black_count = 0
    @board.positions.each do |row|
      row.each do |piece|
        if piece.nil?
          next
        elsif piece.color == 'white'
          white_count += 1
        elsif piece.color == 'black'
          black_count += 1
        end
      end
    end
    if (white_count + black_count) == 2 
      puts "It's a draw!"
      return true
    end
    false
  end

  def breaks_check?(current, desired, piece)
    breaks_check = false
    cache = Marshal.load(Marshal.dump(@board.positions))

    move(current, desired, piece)
    @board.positions.flatten.select { |square| !square.nil? && square.instance_of?(King) && square.color == @current_player.color }.each do |king|
      breaks_check = true if king.in_check?(@board.positions) == false
    end
    @board.positions = cache
    update_possible_moves
    breaks_check
  end

  def any_breaks_checks?
    @board.positions.flatten.select { |square| !square.nil? && square.color == @current_player.color }.each do |piece|
      piece.possible_moves.each do |move|
        if breaks_check?([piece.x_position, piece.y_position], move, piece)
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