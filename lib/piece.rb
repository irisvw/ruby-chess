class Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def diagonal
    # get adjacent empty squares on the diagonal, until it runs into a piece. 
    # keep square if enemy piece, discard square if friendly piece.

    # return square if enemy square

    # diagonal(square)
  end

  def horizontal
    # get adjacent empty squares on the horizontal, until it runs into a piece. 
    # keep square if enemy piece, discard square if friendly piece. 
  end

  def vertical
    # get adjacent empty squares on the vertical, until it runs into a piece. 
    # keep square if enemy piece, discard square if friendly piece. 
  end

  # def moves(square, direction, array = [])
  #   return square if square.value != "." || square.nil?
  #   next_square = square.x + direction[0], square.y + direction[1]

  #   array << moves(, direction)
  # end

  def to_s
    @symbol
  end

end

class Queen < Piece

  def initialize(color)
    super(color)
    @symbol = "♛"
  end

  def moves
    # may move in any straight line, horizontal, vertical, or diagonal.
  end

end

class King < Piece

  def initialize(color)
    super(color)
    @symbol = "♚"
  end

  def moves(x, y)
    # moves one square in any direction, horizontally, vertically, or diagonally. (castling)
    [[x-1, y-1], [x, y-1], [x+1, y-1], [x, y-1], [x, y+1], [x+1, y-1], [x+1, y], [x+1, y+1]]
    # keep move if valid square and no friendly piece
  end

end

class Knight < Piece

  def initialize(color)
    super(color)
    @symbol = "♞"
  end

  def moves(x, y)
    # makes a move that consists of first one step in a horizontal or vertical direction, and then one step diagonally in an outward direction.
    [[x-2, y+1], [x-2, y-1], [x-1, y+2], [x-1, y-2], [x+1, y+2], [x+1, y-2], [x+2, y+1], [x+2, y-1]]
    # keep move if valid square and no friendly piece
  end

end

class Rook < Piece

  def initialize(color)
    super(color)
    @symbol = "♜"
  end

  def moves
    # moves in a straight line, horizontally or vertically.
  end

end

class Bishop < Piece

  def initialize(color)
    super(color)
    @symbol = "♝"
  end

  def moves
    # moves in a straight diagonal line.
  end

end

class Pawn < Piece

  def initialize(color)
    super(color)
    @symbol = "♟︎"
  end

  def moves
    # When a pawn does not take, it moves one square straight forward. 
    # When this pawn has not moved at all, the pawn may make a double step straight forward.
    # When taking, the pawn goes one square diagonally forward.
  end

end