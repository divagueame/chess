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
    p 'Please... Choose a piece to move...'
    origin = gets.chomp
  end


  def move(origin,target)
    originObj = board.retrievePieceObj(origin)
    return p "That's an empty square!" if originObj.nil?
    originPieceColor = originObj.color
    return p "Wrong piece! That's not yours!" if originObj.color != @activePlayer
    targetObj = board.retrievePieceObj(target)
    return p "Wrong move! Your own piece is there!" if targetObj && targetObj.color == @activePlayer

    # p originObj.class.name
    # p originObj.getMoves
    # p targetObj

    #If it's an empty square or 
    # if(targetObj.empty || !board.check?(targetObj))then  end
    # return p "Check!" if board.check?(targetObj)
    #if there's targetObj, delete from board.currentpieces
  end

end

class Player
  def initialize(colorPlayer = 'white', humanPlayer = true)
    @colorPlayer = colorPlayer
    @humanPlayer = humanPlayer
  end 
end


newgame = Game.new
newgame.board.drawBoard
# newgame.promptMove
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
