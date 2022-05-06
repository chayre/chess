# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require 'pry'

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
      # Take the player input (which is in the form of "A4 to B3") and convert it to coordinates (like [1, 2] and [3, 5]) utilizing the normalize method
      current_position = normalize([move[2], move[1]])
      desired_position = normalize([move[4], move[3]])
      # Identify the piece that the player would like to move as piece
      piece = @board.positions[current_position[0]][current_position[1]]
      # If the piece is not there, if its possible moves don't include the desired position, or if it isn't their piece then go through this loop again
      break if !piece.nil? && piece.possible_moves.include?(desired_position) && piece.color == @current_player.color
      print "\nInvalid move. Try again.\n> "
    end
    # We got through our checks so the move is valid; execute the movement of the piece and switch to the other player
    move(current_position, desired_position)
    switch_player
  end

  # Call this method when starting the game for the first time to draw the board and create the two players
  def game_setup
    @board.fill_board
    @board.logo
    @board.display
    initialize_player
  end

  def play_game
    game_setup
    # Continue playing until checmate or a draw
    until checkmate? || draw?
      # Play a turn, then display the new board layout
      play_turn
      @board.display
    end
  end

  def checkmate?
    strikes = 0
    check = 0
    update_possible_moves
    @board.positions.flatten.select {|square| square.instance_of?(King) && square.color == @current_player.color }.each do |king|
      strikes += 1 if king.in_check?(@board.positions)
      check += 1 if king.in_check?(@board.positions)
      strikes += 1 if any_breaks_checks? == false
      strikes += 1 if king.possible_moves.empty?
    end
    if strikes == 3
      puts "#{@current_player.name}, the #{@current_player.color} king is in checkmate. #{@standby_player.name}, #{@standby_player.color} wins!"
      true
    elsif check.positive?
      puts "#{@current_player.name}, your #{@current_player.color} king is in check!"
      false
    else
      false
    end
  end

  # Check if there is a draw; if white and black each only have one piece, it means they must both be kings and the game is unwinnable
  def draw?
    white_count = 0
    black_count = 0
    # Count the pieces of each color that are left on the board
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
    # This condition only true if there are two kings left
    if (white_count + black_count) == 2
      puts "It's a draw!"
      return true
    end
    false
  end

  # Load the board positions which have been saved
  def breaks_check?(current, desired, piece)
    breaks_check = false
    # Save our current boardstate to be reinstate later
    cache = Board.clone(@board.positions)
    # Now that we saved the board, we'll perform a hypothetical move
    move(current, desired)
    # Go through the board until you find the current player's king
    @board.positions.flatten.select { |square| !square.nil? && square.instance_of?(King) && square.color == @current_player.color }.each do |king|
      # If the hypothetical move results in the king not being in check, this method will return true
      breaks_check = true if king.in_check?(@board.positions) == false
    end
    # Reload previous boardstate, before we tried out a hypothetical move to see if it would break the king out of check
    @board.positions = cache
    update_possible_moves
    # Returns true / false
    breaks_check
  end

  # For each piece on the board of the current player's color, determine if it has a move which can break the king out of check
  def any_breaks_checks?
    # Iterate through each piece of the current player's color
    @board.positions.flatten.select { |square| !square.nil? && square.color == @current_player.color }.each do |piece|
      # Iterate through each move for each piece's moveset
      piece.possible_moves.each do |move|
        # Check if that move has broken the king out of check. There only needs to be one instance of breaking check for the condition to be true
        if breaks_check?([piece.x_position, piece.y_position], move, piece)
          return true
        end
      end
    end
    false
  end

  # Alters the possible moveset attribute of each piece based on current board positions
  def update_possible_moves
    # Flatten 2x2 board arrow into single level array of pieces and iterate through each
    @board.positions.flatten.each do |piece|
      # For each piece on the board, update its possible moveset by feeding in current board positions
      # "&." ensures this will not execute the find_possible_moves function if piece is nil 
      piece&.find_possible_moves(@board.positions) unless piece.instance_of?(King)
    end
    @board.positions.flatten.each do |piece|
      piece&.find_possible_moves(@board.positions) if piece.instance_of?(King)
    end
  end

  # Sets current piece location to nil and desired location to piece (destroys the piece that used to be in the desired position, if there was one)
  def move(current, desired)
    temp = @board.positions[current[0]][current[1]]
    if temp != nil
      temp.x_position = desired[0]
      temp.y_position = desired[1]
    end
    @board.positions[current[0]][current[1]] = nil
    @board.positions[desired[0]][desired[1]] = temp

    update_possible_moves
  end

  # Shows current board state
  def display
    @board.display
  end

  # Standardizes input ("A1 to C2" -> "[1,1], [3,2]")
  def normalize(array)
    array[1] = array[1].ord - 97
    array[0] = 7 - (array[0].to_i - 1)
    array
  end
end
