class Game
  
  def initialize
    @board = Board.new
    @player1 = Player.new("Player 1", "white")
    @player2 = Player.new("Player 2", "black")
    @current_player = @player1
  end

  # main game loop
  def play
    loop do
      @board.display
      move = validate_move
      @board.move_piece(move)
      # break if check?
      # check for pieces to be promoted?
      switch_player
    end
  end

  def switch_player
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

  # prompt_move until valid move
  def validate_move
    loop do
      move = prompt_move 
      return move if valid_move?(move)
      puts "That move is invalid."
    end
  end

  # gets input until valid notation
  def prompt_move
    puts "#{@current_player.name}, what is your move?"
    loop do
      input = gets.chomp.downcase # e2e4
      return input if valid_notation?(input)
      puts "Invalid input. Format as a1a2."
    end
  end

  def valid_notation?(input)
    input.match?(/[a-h][1-8][a-h][1-8]/)
  end

  def valid_move?(move)
    start = @board.square(move[0..1])
    goal = @board.square(move[2..3])

    piece = start.value
    return false if piece.color != @current_player.color

    # check for castling here?
    #return castling? if piece.symbol == "♚" && ((start.y - goal.y).abs > 1)
    #return en_passant? if piece.symbol == "♟︎" && (start.x != goal.x && goal.value == "·")
    
    moves = @board.check_moves(start)
    moves.include?(goal)
  end

  def castling?
    # king hasn't moved?
    # castle hasn't moved?
    # move two pieces!
  end

  def en_passant
    # enemy rook just two-stepped and is now adjacent?
    # diagonally move piece, but slay the enemy rook anyway!
  end
end