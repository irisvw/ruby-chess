class Board

  def initialize
    @board = Array.new(8) { Array.new(8) { Square.new() } }
  end

  def display
    @board[0][0].value = "x"
    @board[1][1].value = "x"
    @board[6][6].value = "x"

    @board.reverse.each_with_index { |row, i|
      puts "#{8 - i} #{row.join(" ")}"
    }
    puts "  a b c d e f g h "
  end

end

# what do you want your board to do?
# hold 64 squares.
# if nothing is on the square, display ‧