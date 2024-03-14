class Game

  def initialize
    @board = Board.new
  end

  def play
    @board.display
  end

end