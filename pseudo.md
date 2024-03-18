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
