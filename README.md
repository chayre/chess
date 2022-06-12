# WIP; READ-ME NOT FINISHED

# Chess
Chess recreated in Ruby (command-line). Fully-functional (piece movement and captures, check/checkmate, en passe, castling, pawn promotion) and developed iteratively with RSpec testing.

# Test-driven development
When creating new methods for this project, I first wrote tests in RSpec (a Ruby testing tool) to define the behavior I wanted my code to return. I wrote code until this test (and all others in the test suite) were completed successfully. After finishing major features, I went back to write more tests to ensure that everything was still functional before moving on. TDD was critical for my success in developing this project as it saved me multiple times from missing corner cases (for example, unforseen interaction of pieces that I had initially failed to account for).

# Object-Oriented Programming
My first major goal with this project was to ensure I was adhering to object-oriented programming principles - making sure that the most important pieces of my project were objects or incorporated within classes, not stand-alone methods. When the game begins, a _Chess_ object is instantiated. _Chess_ instantiates and contains a _Board_ object. _Board_ instantiates an array of objects that are each occupied by nil or children of the _ChessPiece_ class.

## ChessPiece Class

This class defines some basic traits which all other pieces possess.
```ruby
class ChessPiece
  Attributes:  
    @color : boolean input that resolves via ternary operator to white or black
    @moveset : a constant array of arrays that defines the basic legal moves for ChessPieces
    @x_position : a number which represents x-position on the 8x8 chess board (in the chess board, 
    the x-axis runs between the black and white player)
    @y_position : a number which represents y-position on the 8x8 chess board (in the chess board, 
    the y-axis runs perpendicular to the black and white front lines)
    @possible_moves : an array containing x/y-position arrays which are valid moves for a piece
    @icon : a symbol (string) specific to each piece type (i.e. castle for Rook, horse for Knight)
  Methods:
 class Queen/Rook/Bishop < ChessPiece
```


### Queen/Rook/Bishop Class

### Knight Class

### Pawn Class

### King Class

## Board Class

## Chess Class

![image](https://user-images.githubusercontent.com/88121502/165210322-e5e381eb-a31c-4758-8780-04feba80c492.png)


![image](https://user-images.githubusercontent.com/88121502/165210857-d565c7e4-26e6-4ab4-944e-4ecf233dc8d0.png)
