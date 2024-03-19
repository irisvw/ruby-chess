class Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def moves(square, direction, array = [])
    x, y = square.x + direction[0], square.y + direction[1]
    return array unless x.between?(0, @board.length - 1) && y.between?(0, @board[0].length - 1)

    next_square = @board[x][y]

    return array if next_square.value != "·" && next_square.value.color == "white"

    array << next_square
    moves(next_square, direction, array) if next_square.value == "·"
    array
  end

  # def diagonal(square)
  #   diagonal = [[1, 1], [-1, 1], [-1, -1], [1, -1]]
  #   up_right = [1, 1]
  #   down_right = [-1, 1]
  #   down_left = [-1, -1]
  #   up_left = [1, -1]

  #   array = moves(square, up_right)
  #   array << moves(square, down_right)
  #   array << moves(square, down_left)
  #   array << moves(square, up_left)
  #   # get adjacent empty squares on the diagonal, until it runs into a piece. 
  #   # keep square if enemy piece, discard square if friendly piece.
  #   # return square if enemy square
  # end

  # def horizontal(square)
  #   # get adjacent empty squares on the horizontal, until it runs into a piece. 
  #   # keep square if enemy piece, discard square if friendly piece.
  #   left = [0, -1]
  #   right = [0, 1]

  #   array = moves(square, left)
  #   array << moves(square, right)
  # end

  # def vertical(square)
  #   up = [1, 0]
  #   down = [-1, 0]

  #   array = moves(square, up)
  #   array << moves(square, down)
  #   # get adjacent empty squares on the vertical, until it runs into a piece. 
  #   # keep square if enemy piece, discard square if friendly piece. 
  # end

  # diagonal = [[1, 1], [-1, 1], [-1, -1], [1, -1]]
  # horizontal = [[0, -1], [0, 1]]
  # vertical = [[1, 0], [-1, 0]]

  # # can this be simplified some more?
  #   def all_moves(square, directions, array = [])
  #     directions.each do |direction|
  #       array << moves(square, direction)
  #     end
  #   end

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

  # def moves
  #   # may move in any straight line, horizontal, vertical, or diagonal.
  # end

  def valid_moves(square, directions = orthogonal + diagonal, array = [])
    directions.each do |direction|
      array << moves(square, direction)
    end
  end

end

class King < Piece

  def initialize(color)
    super(color)
    @symbol = "♚"
  end

  def valid_moves(x, y)
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

  def valid_moves(x, y)
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

  # def moves
  #   # moves in a straight line, horizontally or vertically.
  # end

  def valid_moves(square, directions = orthogonal, array = [])
    directions.each do |direction|
      array << moves(square, direction)
    end
  end

end

class Bishop < Piece

  def initialize(color)
    super(color)
    @symbol = "♝"
  end

  # def moves
  #   # moves in a straight diagonal line.
  # end

  def valid_moves(square, directions = diagonal, array = [])
    directions.each do |direction|
      array << moves(square, direction)
    end
  end

end

class Pawn < Piece

  def initialize(color)
    super(color)
    @symbol = "♟︎"
  end

  def valid_moves
    # When a pawn does not take, it moves one square straight forward. 
    # When this pawn has not moved at all, the pawn may make a double step straight forward.
    # When taking, the pawn goes one square diagonally forward.
  end

end
