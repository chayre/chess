# frozen_string_literal: true

# Class which defines player name and their team (color)
class Player
  attr_accessor :color, :name

  # Initialize the player by creating an object with true/false indicating white/black, then get their name
  def initialize(color)
    @color = color ? 'white' : 'black'
    @name = nil
    name_get
  end

  # Queries player and gets name
  def name_get
    puts "Which player will play #{@color}? Type their name."
    @name = gets.chomp
  end

  # Compare input to regex for a match; if not a match, loop through until input is valid
  def input_get
    puts 'Submit input:'
    input = gets.chomp.downcase
    regex = /^([a-h])([1-8])\s{1}to\s{1}([a-h])([1-8])$/
    until regex =~ input
      puts 'Invalid input format; try again.'
      input = gets.chomp.downcase
    end
    regex.match(input)
  end
end
