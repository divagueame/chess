require_relative './board'
require_relative './pieces'

class Game
  attr_reader :board, :player1, :player2
  def initialize
    @board = Board.new
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
        # p "Checkmate! You lost!"
      end
      
    else
      p "Not check"
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


newgame = Game.new
# newgame.board.drawBoard

newgame.next_turn
# newgame.board.drawBoard
