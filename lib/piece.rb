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

    # @single_step = [1, 0]
    # @double_step = [2, 0]
    # @diagonal = [[1, 1], [1, -1]]
  end

  def update(start, goal)
    @has_moved = true if @has_moved == false
    @double_stepped = false if @double_stepped == true
    @double_stepped = true if (start.x - goal.x).abs > 1
  end

  def valid_moves(square, board, array = [])
    var = (@color == "white") ? 1 : -1
    array = moves(square, board, var)
  end

  def moves(square, board, var)
    array << single_step(square, board, var)
    array << double_step(square, board, var) unless @has_moved
    array << capture(square, board, var)
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

  def capture(square, board, var)
    x, y = square.x, square.y
    right = board[x+var][y+var]
    left = board[x+var][y-var]
  end

  # def en_passant
  #   left = board[x][y-var]
  #   right = board[x][y+var]
  #   return left if is_enemy_pawn?(left)
  #   return right if is_enemy_pawn?(right)
  # end

  # def is_enemy_pawn?(square)
  #   return false if square.value == "·"

  #   piece = square.value
  #   piece.symbol == "♟︎" && piece.color != @color && piece.double_stepped == true
  # end
    # (adjacent != "·" && adjacent.color != @color && adjacent.symbol == @symbol && adjacent.double_stepped == true)
    # left_adjacent = board[x][y-var].value if it's an enemy pawn that hasn't moved
    # right_adjacent = board[x][y+var].value if it's an enemy pawn that hasn't moved

    # check_step
    # front = board[x+var][y].value if front is empty
    # twostep = board[x+var+var][y].value if front is empty and twostep is empty

     # check_en_passant
    # left_adjacent = board[x][y-var].value if it's an enemy pawn that hasn't moved
    # right_adjacent = board[x][y+var].value if it's an enemy pawn that hasn't moved

    # x, y = square.x, square.y
    # # standard move
    # # array << (@color == 'white') ? [x+1, y] : [x-1, y]
    # array << (@color == 'white') ? (x = square.x + @single_step[0]) : (x = square.x - @single_step[0])

    # # double step
    # array << ((@color == 'white') ? [x+2, y] : [x-2, y]) if @has_moved == false

    # # capture (white)
    # if @color == 'white'
    #   array << [x+1, y+1] if (board[x+1][y+1].value != "·" && board[x+1][y+1].value.color != @color)
    #   array << [x+1, y-1] if (board[x+1][y-1].value != "·" && board[x+1][y-1].value.color != @color)
    # end

    # # capture (black)
    # if @color == 'black'
    #   array << [x-1, y+1] if (board[x-1][y+1].value != "·" && board[x-1][y+1].value.color != @color)
    #   array << [x-1, y-1] if (board[x-1][y-1].value != "·" && board[x-1][y-1].value.color != @color)
    # end

    # if @color == 'white'
    #   adjacent = board[x][y+1].value
    #   array << [x+1, y+1] if (adjacent != "·" && adjacent.color != @color && adjacent.symbol == @symbol && adjacent.double_stepped == true)
    #   array << [x+1, y-1] if (board[x][y-1].value != "·" && board[x+1][y-1].value.color != @color)
    # end

    # # capture (black)
    # if @color == 'black'
    #   array << [x-1, y+1] if (board[x-1][y+1].value != "·" && board[x-1][y+1].value.color != @color)
    #   array << [x-1, y-1] if (board[x-1][y-1].value != "·" && board[x-1][y-1].value.color != @color)
    # end

    # en passant


    # Pawns only move forward!
    # When a pawn does not take, it moves one square straight forward. 
    # When this pawn has not moved at all, the pawn may make a double step straight forward.
    # When taking, the pawn goes one square diagonally forward.

    # filter_moves(moves, board, @color)

    # returns an array of valid moves.
    # - includes one step forward if that square is empty.
    # - includes a forward diagonal if it is occupied by an enemy piece
    # - includes two steps forward if one step forward is empty, two steps forward is empty, and the pawn hasn't moved yet.
    # - includes a forward diagonal if a pawn that just double stepped is adjacent to the pawn.

    # if black, x is always -1 (except first move)
    # if white, x is always 1
    # single step, y = 0
    # diagonal, y = -1 and y = 1
    # color == "white" ? moves(1) : moves(-1)


    # def moves(square, board, var)
    # check_step
    # front = board[x+var][y].value if front is empty
    # twostep = board[x+var+var][y].value if front is empty and twostep is empty

    # check_en_passant
    # left_adjacent = board[x][y-var].value if it's an enemy pawn that hasn't moved
    # right_adjacent = board[x][y+var].value if it's an enemy pawn that hasn't moved

    # check_capture
    # left_diagonal = board[x+var][y+var].value if it's an enemy piece
    # right_diagonal = board[x+var][y-var].value if it's an enemy piece
end
