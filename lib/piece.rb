class Piece
  attr_reader :color

  def initialize(color)
    @color = color
    @diagonal = [[1, 1], [-1, 1], [-1, -1], [1, -1]]
    @orthogonal = [[0, -1], [0, 1], [1, 0], [-1, 0]]
    @all = @diagonal + @orthogonal
  end

  def update(*)
    puts "Nothing to update."
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

  def filter_moves(moves, board, color)
    # receives all possible moves.
    # keeps the ones that are a square that exists
    # deletes the ones that have a friendly piece on them

    moves.keep_if { |move| move[0].between?(0, 7) && move[1].between?(0,7)}
    moves.map! { |move| board[move[0]][move[1]]}
    moves.delete_if { |square| square.value != "·" && square.value.color == color }
    moves
  end

  def to_s
    @color == "black" ? "\e[34m#{@symbol}\e[0m" : @symbol
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
    filter_moves(moves, board, @color)
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
    filter_moves(moves, board, @color)
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
    @has_moved = false
    @double_stepped = false
  end

  def update(start, goal)
    @has_moved = true if @has_moved == false
    @double_stepped = false if @double_stepped == true
    @double_stepped = true if (start.x - goal.x).abs > 1
  end

  def valid_moves(square, board)
    var = (@color == "white") ? 1 : -1
    moves(square, board, var)
  end

  def moves(square, board, var, array = [])
    array << single_step(square, board, var)
    array << double_step(square, board, var) unless @has_moved
    array << capture_right(square, board, var)
    array << capture_left(square, board, var)
  end

  def single_step(square, board, var)
    x, y = square.x, square.y
    forward = board[x+var][y]
    return forward if forward.value == "·"
  end

  def double_step(square, board, var)
    x, y = square.x, square.y
    forward = board[x+var][y]
    two_forward = board[x+var+var][y]
    return two_forward if forward.value == "·" && two_forward.value == "·"
  end

  def capture_right(square, board, var)
    x, y = square.x, square.y
    right = board[x+var][y+var]
    return right if right.value != "·" && right.value.color != @color
  end

  def capture_left(square, board, var)
    x, y = square.x, square.y
    left = board[x+var][y-var]
    return left if left.value != "·" && left.value.color != @color
  end
end
