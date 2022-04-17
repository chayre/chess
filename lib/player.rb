# frozen_string_literal: true
#require_relative 'pieces/knight.rb'
#require_relative 'pieces/queen.rb'
#require_relative 'pieces/rook.rb'
#require_relative 'pieces/bishop.rb'
#require_relative 'pieces/king.rb'
#require_relative 'pieces/pawn.rb'
#require_relative 'board.rb'

# Class which places pieces on the board, tracks them in a positions array, and draws the board
class Player
  attr_accessor :color, :name, :team

  def initialize(color)
    @color = color ? 'white' : 'black'
    @name = nil
    name_get
  end

  def name_get
    puts "Which player will play #{@team}? Type their name."
    @name = gets.chomp
  end

  def input_get
    puts 'Type your input in the form'
    input = gets.chomp.downcase
    regex = /^([a-h])([1-8])\s{1}to\s{1}([a-h])([1-8])$/
    until regex =~ input
      puts 'Invalid input format; try again.'
      input = gets.chomp.downcase
    end
    regex.match(input)
  end
end
