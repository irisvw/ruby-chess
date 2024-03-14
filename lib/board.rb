class Board

  def initialize
    @board = Array.new(8) { Array.new(8) { Square.new() } }
  end

  def display
    @board.reverse.each_with_index { |row, i|
      puts "#{8 - i} #{row.join(" ")}"
    }
    puts "  a b c d e f g h "
  end

  def starting_pieces
    @board[1].each { |square| square.value = Pawn.new() }
    @board[6].each { |square| square.value = Pawn.new() }
    @board[0][0].value = Rook.new()
    @board[0][7].value = Rook.new()
  end

end

# what do you want your board to do?
# hold 64 squares.
# if nothing is on the square, display ‧

# @board[0][0].value = "x"
# @board[1][1].value = "x"
# @board[6][6].value = "x"