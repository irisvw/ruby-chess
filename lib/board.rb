class Board

  def initialize
    @board = create_board
    starting_pieces
  end

  def create_board
    Array.new(8) do |x|
      Array.new(8) do |y|
        Square.new(x, y)
      end
    end
  end

  def display
    @board.reverse.each_with_index { |row, i|
      puts "#{8 - i} #{row.join(" ")}"
    }
    puts "  a b c d e f g h "
  end

  def check_moves(start)
    piece = start.value
    return [] if piece == "·"

    piece.valid_moves(start, @board)
  end

  def move_piece(move)
    start = square(move[0,2])
    goal = square(move[2,3])

    goal.value = start.value
    start.value = "·"
  end

  def starting_pieces
    place_piece(@board[1], Pawn.new("white"))
    place_piece(@board[6], Pawn.new("black"))

    place_piece([square("a1"), square("h1")], Rook.new("white"))
    place_piece([square("a8"), square("h8")], Rook.new("black"))

    place_piece([square("b1"), square("g1")], Knight.new("white"))
    place_piece([square("b8"), square("g8")], Knight.new("black"))

    place_piece([square("c1"), square("f1")], Bishop.new("white"))
    place_piece([square("c8"), square("f8")], Bishop.new("black"))

    place_piece([square("d1")], Queen.new("white"))
    place_piece([square("d8")], Queen.new("black"))

    place_piece([square("e1")], King.new("white"))
    place_piece([square("e8")], King.new("black"))
  end

  def place_piece(squares, piece)
    squares.each { |square| square.value = piece }
  end

  # translate chess notation to a square
  def square(value)
    col = value[0].ord - 97
    row = value[1].to_i - 1
    return @board[row][col]
  end
end

# what do you want your board to do?
# hold 64 squares.
# if nothing is on the square, display ‧

#   # can this be simplified some more?
#   def all_moves(square, directions, array = [])
#     directions.each do |direction|
#       array << moves(square, direction)
#     end
#   end

# def moves(square, direction, array = [])
#   # check the next_square. does it exist?
#   x, y = square.x + direction[0], square.y + direction[1]
#   return array unless x.between?(0, @board.length - 1) && y.between?(0, @board[0].length - 1)

#   next_square = @board[x][y]

#   # check if the next_square is occupied by friendly piece. if so, do not add square to list and return.
#   return array if next_square.value != "·" && next_square.value.color == "white"

#   # add square to list.
#   array << next_square

#   # look for another square only if the current square was empty.
#   moves(next_square, direction, array) if next_square.value == "·"

#   # return array.
#   array
# end