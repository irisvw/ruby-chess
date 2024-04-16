# Chess.

Okay, intimidating as fuck. But it's just connect four with more rules, right?

## Classes

Board
Player
Piece

### Board
- 8 x 8 grid (a-h, 1-8)

### Squares
- x, y
- name?
- content

### Player
- Player 1 with white pieces
- Player 2 with black pieces

### Pieces
- King, queen, rooks, bishops, knights, pawns
- has_moved? can_jump?
- get possible moves for all pieces
- check if a possible move includes the other player's king

### A move
- "Player 1, what is your move?"
- gets: "e2e4"
- translate e2 to [1][4] and e4 to [3][4]
- check what piece is on e2
- confirm it belongs to current player
- get all valid moves for the piece on e2
- check if valid moves include e4
- if not, display valid moves (?)
- check if any piece is on e4
- move piece to e4
- check for check and checkmate
- switch player 

### Get all valid moves for the piece on e2
- get the piece (eg. Queen)
- moves = piece.valid_moves(location = e2/@board[1][4])
- translate e2 to 1, 4
- add direction to 1, 4 (eg direction = 1, 1) -> 2, 5
- moves.include(e4?)

### How to get corresponding moves from a certain piece, like a bishop?
- The pieces don't know about the board and other pieces positions.

### Fucking pawns
- Three possible directions:
- WHITE
- [x+1, y] (normal move)
- [x+1, y+1], [x+1, y-1] (capture/en-passant)
- [x+2, y] (first move)

- BLACK
- [x-1, y] (normal move) - if space is empty
- [x-1, y+1], [x-1, y-1] (capture/en-passant) - if enemy pawn is adjacent or diagonal
- [x-2, y] (first move) - if two spaces in front are empty

### Would it be easier to literally only check for the move the user wants to make?
- probably not.

### Back on april 16th.
- what do i need to implement?
- castling
- en-passant
- i almost feel like i need to relearn how to type
- are the keys spaced differently or something?
- check
- checkmate
- just write more pseudocode (i think)

### Move proceedings!
- get user input. validate user input notation.
- check if move is valid and if it is a special move.
- normal move? call move_piece
- castle? call castle_piece
- passant? call en_passant

- i need somewhat of a restructure
- but my brain's not functioning
- and i really want to play planet crafter

### validate move should:
- check if it's a castling move. call castling.
- check if it's en passant. call en passant.
- if neither, check if move is included in the piece's available moves. call move piece.
- if none, ask user for another move.