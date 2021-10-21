require_relative './board'
require_relative './pieces'

class Game
  attr_reader :board, :player1, :player2
  def initialize (newBoard = Board.new)
    @board = newBoard
    @player1 = Player.new('white', 'human')
    @player2 = Player.new('black', 'human')
    @activePlayer = "white"
  end

  def promptMove
    p 'Please... Choose a square...'
    origin = gets.chomp
    originCols = "abcdefgh".split("")
    originRows = "12345678".split("")
    while !originCols.include?(origin[0]) || !originRows.include?(origin[1]) do
      p "not a valid position! Choose a position like a2 or f7"
      origin = gets.chomp
    end
    
    decodeUserInputPos(origin)
  end

  def decodeUserInputPos(userStr)
    rows = {
      8 => 0,
      7 => 1,
      6 => 2,
      5 => 3,
      4 => 4,
      3 => 5,
      2 => 6,
      1 => 7
    }

    cols = {
      'a' => 0,
      'b' => 1,
      'c' => 2,
      'd' => 3,
      'e' => 4,
      'f' => 5,
      'g' => 6,
      'h' => 7
    }
    

    arr = []
    usersplitted =  userStr.split("")
    thisRow = usersplitted[1].to_i
    row = rows[thisRow]
    thisCol = usersplitted[0]
    col =  cols[thisCol]

    arr << row
    arr << col
    
    arr
  end

  def next_turn
    p "It's #{@activePlayer}'s player turn"
    board.drawBoard
    if(board.check?(@activePlayer))then
      p "Check!"
      if(board.checkmate?(@activePlayer))then
        p "Checkmate! You lost!"
      else
        p "Not checkmate"
      end
      
    else
      
      # move
    end

    
    
    @activePlayer == "white"? @activePlayer = "black" : @activePlayer = "white"
    
  end
  

  def move
    board.drawBoard
    origin = promptMove 
    originObj = board.retrievePieceObj(origin)

    while originObj.nil? do
      p "That's an empty square! Try another square"
      origin = promptMove 
      originObj = board.retrievePieceObj(origin)
    end

    while  originObj.nil? || originObj.color != @activePlayer do
      p "That's not your piece! Try again"
      origin = promptMove 
      originObj = board.retrievePieceObj(origin)
    end
    
    while (originObj.getMoves(board).size<1) do
      p "That piece can't move!"
      origin = promptMove 
      originObj = board.retrievePieceObj(origin)
    end
    originMoves = originObj.getMoves(board)
    
    target = promptMove 
    while !originMoves.include?(target) do
      p "Not a valid move. Try again"
      target = promptMove 
    end

    targetObj = board.retrievePieceObj(target)
    if(board.currentPieces.include?(targetObj))then
          board.currentPieces.delete(targetObj)
    end

    
  end


end
  
class Player
  def initialize(colorPlayer = 'white', humanPlayer = true)
    @colorPlayer = colorPlayer
    @humanPlayer = humanPlayer
  end 
end


newSituation =
[
      # White pieces
      Pawn.new(6,0,"white"),
      Pawn.new(6,1,"white"),
      Pawn.new(6,2,"white"),
      Pawn.new(6,3,"white"),
      Pawn.new(6,4,"white"),
      Pawn.new(5,5,"white"),
      Pawn.new(6,6,"white"),
      # Pawn.new(6,7,"white"),
      Rook.new(7,0,"white"),
      Rook.new(7,7,"white"),
      Horse.new(7,1,"white"),
      Horse.new(7,6,"white"),
      Bishop.new(7,2,"white"),
      Bishop.new(7,5,"white"),
      Queen.new(7,3,"white"),
      King.new(7,4,"white"),
      
      # black pieces
      Pawn.new(1,0,"black"),
      Pawn.new(1,1,"black"),
      Pawn.new(1,2,"black"),
      Pawn.new(1,3,"black"),
      Pawn.new(1,4,"black"),
      Pawn.new(1,5,"black"),
      Pawn.new(1,6,"black"),
      Pawn.new(1,7,"black"),
      Rook.new(0,0,"black"),
      Rook.new(0,7,"black"),
      Horse.new(0,1,"black"),
      Horse.new(0,6,"black"),
      Bishop.new(0,2,"black"),
      
      Bishop.new(0,5,"black"),
      Queen.new(0,3,"black"),
      King.new(0,4,"black"),
      Bishop.new(5,6,"black"),
]

thisBoard = Board.new(newSituation)
newgame = Game.new(thisBoard)
# newgame.board.drawBoard

newgame.next_turn
# newgame.board.drawBoard
