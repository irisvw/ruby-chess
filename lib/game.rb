class Game
  
  def initialize
    @board = Board.new
    @player1 = Player.new("Player 1", "white")
    @player2 = Player.new("Player 2", "black")
    @current_player = @player1
  end

  def play
    @board.display
  end

  def switch_player
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

end