class Game
  
  def initialize
    @board = Board.new
    @player1 = Player.new("Player 1", "white")
    @player2 = Player.new("Player 2", "black")
    @current_player = @player1
  end

  def play
    @board.display
    move = prompt_move
  end

  def switch_player
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

  def prompt_move
    puts "#{@current_player}, what is your move? (format as a1a2)"
    loop do
      input = gets.chomp.downcase # e2e4
      return input if valid_notation?(input)
      puts "Invalid input."
    end
  end

  def valid_notation?(input)
    input.match?(/[a-h][1-8][a-h][1-8]/)
  end

  def valid_move?(move)
    start = board.square(move[0,1])
    goal = board.square(move[2,3])
    
    moves = board.check_moves(start)
    moves.include?(goal)
  end

end