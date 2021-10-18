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
    
    p " Origin is : "
    p origin
    originMoves = originObj.getMoves(board)
    
    target = promptMove 
    while !originMoves.include?(target) do
      p "Not a valid move. Try again"
      target = promptMove 
    end

    p "Good move"
    p originObj
    p originObj.row
    p "Target it"
    p target
    originObj.row = target[0]
    originObj.col = target[1]
    p board.currentPieces
    # board.drawBoard
    # p originObj.row
    # targetObj = board.retrievePieceObj(target)
    # p targetObj

    # if(board.currentPieces.include?(targetObj))then
    #       # p board.removePieceObj(target)
    #       p board.currentPieces.size
    #       board.drawBoard
    #       board.currentPieces.delete(targetObj)
    #       p "There's  an opponne piece there"
    #       board.drawBoard
    #       p board.currentPieces.size

    # end

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

# p "ANd the userchose: "
newgame.move

# newgame.board.drawBoard
# p newgame.board.currentPieces[8]


# whiteBishop =  newgame.board.currentPieces[15]
# p whiteBishop
# whiteBishop.getMoves(newgame.board)

# firstPawn.getMoves(newgame.board)
# firstRook = newgame.board.currentPieces[8]
# firstRook.class
# p newgame.board.findDiagonalPiecesofPawn(firstPawn)
# newgame.board.currentPieces[0].getMoves("white","false","col","row")
# newgame.move([6,4],[5,4])
# newgame.board.drawBoard
# p newgame.board
# player1.move([0, 2], [0, 3])
# game.drawBoard
# p game.piecesRoot
