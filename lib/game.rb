class Game
  
  def initialize
    @board = Board.new
    @player1 = Player.new("Player 1")
    @player2 = Player.new("Player 2")
  end

  def play
    @board.display
  end

end