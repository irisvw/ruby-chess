class Piece
  attr_reader :color

  def initialize(color)
    @color = color
    @diagonal = [[1, 1], [-1, 1], [-1, -1], [1, -1]]
    @orthogonal = [[0, -1], [0, 1], [1, 0], [-1, 0]]
    @all = @diagonal + @orthogonal
  end

  def moves(square, direction, board, array = [])
    x, y = square.x + direction[0], square.y + direction[1]
    return array unless x.between?(0, 7) && y.between?(0, 7)

    next_square = board[x][y]
    return array if next_square.value != "·" && next_square.value.color == "white"

    array << next_square
    moves(next_square, direction, array) if next_square.value == "·"
    array
  end

  def filter_moves(moves, color)
    moves.keep_if { |move| move[0].between?(0, 7) && move[1].between?(0,7)}
    moves.map! { |move| board[move[0]][move[1]]}
    moves.delete_if { |square| square.value != "·" && square.value.color == color }
    moves
  end

  def to_s
    @symbol
  end

end

class Queen < Piece

  def initialize(color)
    super(color)
    @symbol = "♛"
  end

  # may move in any straight line, horizontal, vertical, or diagonal.
  def valid_moves(square, board, directions = @all, array = [])
    directions.each do |direction|
      array << moves(square, direction, board)
    end
  end

end

class King < Piece

  def initialize(color)
    super(color)
    @symbol = "♚"
  end

  # moves one square in any direction, horizontally, vertically, or diagonally. (castling)
  def valid_moves(square, board)
    x, y = square.x, square.y
    moves = [[x-1, y-1], [x, y-1], [x+1, y-1], [x, y-1], [x, y+1], [x+1, y-1], [x+1, y], [x+1, y+1]]
    filter_moves(moves, @color)
    # keep move if valid square and no friendly piece
  end

end

class Knight < Piece

  def initialize(color)
    super(color)
    @symbol = "♞"
  end

  # makes a move that consists of first one step in a horizontal or vertical direction, and then one step diagonally in an outward direction.
  def valid_moves(square, board)
    x, y = square.x, square.y
    moves = [[x-2, y+1], [x-2, y-1], [x-1, y+2], [x-1, y-2], [x+1, y+2], [x+1, y-2], [x+2, y+1], [x+2, y-1]]
    filter_moves(moves, @color)
    # moves.keep_if { |move| move[0].between?(0, 7) && move[1].between?(0,7)}
    # moves.map! { |move| board[move[0]][move[1]]}
    # moves.delete_if { |element| element.value != "·" && element.value.color == "white" }
    # keep move if valid square and no friendly piece
  end

end

class Rook < Piece

  def initialize(color)
    super(color)
    @symbol = "♜"
  end

  # moves in a straight line, horizontally or vertically.
  def valid_moves(square, board, directions = @orthogonal, array = [])
    directions.each do |direction|
      array << moves(square, direction, board)
    end
  end

end

class Bishop < Piece

  def initialize(color)
    super(color)
    @symbol = "♝"
  end

  # moves in a straight diagonal line.
  def valid_moves(square, board, directions = @diagonal, array = [])
    directions.each do |direction|
      array << moves(square, direction, board)
    end
  end

end

class Pawn < Piece

  def initialize(color)
    super(color)
    @symbol = "♟︎"
  end

  def valid_moves(square, board)
    x, y = square.x, square.y
    # When a pawn does not take, it moves one square straight forward. 
    # When this pawn has not moved at all, the pawn may make a double step straight forward.
    # When taking, the pawn goes one square diagonally forward.
    filter_moves(moves, @color)
  end

end
