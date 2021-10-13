# require 'rspec/autorun'

class Player
  def initialize(colorPlayer="white", humanPlayer = true)
    @colorPlayer = colorPlayer
    @humanPlayer = humanPlayer
  end

  def movePiece

  end
end

# Module Pieces 
  # include Pawn
  # PIECES  = {
  #   whitepawn: '♟', 
  #   whitehorse: '♞',
  #   whitebishop: '♝',
  #   whitequeen: '♛',
  #   whiteking: '♚',
  #   whiterook: '♜',
  #   blackpawn: '♙',
  #   blackhorse: '♘',
  #   blackbishop: '♗',
  #   blackqueen: '♕',
  #   blackking: '♔',
  #   blackrook: '♖'
  # }


  class Pawn
    attr_accessor :allowedMoves, :row, :col, :pieceStr
    def initialize(row,col,color,moved = false)
      @row = row
      @col = col
      @color = color
      @moved = moved
      color=="white"? @pieceStr = '♟': @pieceStr = '♙'
      @allowedMoves = [[1,0],[2,0]]
    end
  end

  class Rook
    attr_accessor :allowedMoves, :row, :col, :pieceStr
    def initialize(row,col,color,moved = false)
      @row = row
      @col = col
      @color = color
      @moved = moved
      color=="white"? @pieceStr = '♜': @pieceStr = '♖'
      @allowedMoves = getRookMoves
    end

    def getRookMoves
      arr = []
      # Horizontal positive

      # Horizontal negative

      # Vertical positive

      # Vertical negative
      arr
    end
  end

class Board
  attr_accessor :currentBoard
  
  def initialize

      @piecesRoot =[
        # White pieces
        Pawn.new(6,0,"white"),
        Pawn.new(6,1,"white"),
        Pawn.new(6,2,"white"),
        Pawn.new(6,3,"white"),
        Pawn.new(6,4,"white"),
        Pawn.new(6,5,"white"),
        Pawn.new(6,6,"white"),
        Pawn.new(6,7,"white"),
        Rook.new(7,0,"white"),
        Rook.new(7,7,"white"),
        
        # Black pieces
        Pawn.new(1,0,"Black"),
        Pawn.new(1,1,"Black"),
        Pawn.new(1,2,"Black"),
        Pawn.new(1,3,"Black"),
        Pawn.new(1,4,"Black"),
        Pawn.new(1,5,"Black"),
        Pawn.new(1,6,"Black"),
        Pawn.new(1,7,"Black"),
        Rook.new(0,0,"black"),
        Rook.new(0,7,"black")
      ]

      @currentBoard = renderBoardArray
      # @currentBoard = [
      #   ['♖','♘','♗','♕','♔','♗','♘','♖'], #0
      #   ['♙','♙','♙','♙','♙','♙','♙','♙'], #1
      #   [0,0,0,0,0,0,0,0],                        #2  
      #   [0,0,0,0,0,0,0,0],                        #3
      #   [0,0,0,0,0,0,0,0],                        #4
      #   [0,0,0,0,0,0,0,0],                        #5
      #   ['♟','♟','♟','♟','♟','♟','♟','♟'], #6
      #   ['♜','♞','♝','♛','♚','♝','♞','♜']  #7
      #   # 0    1    2    3    4    5    6   7
      # ]
    end

  def renderBoardArray
    currentBoardArray = [
        [0,0,0,0,0,0,0,0],                         #0
        [0,0,0,0,0,0,0,0],                         #1
        [0,0,0,0,0,0,0,0],                         #2  
        [0,0,0,0,0,0,0,0],                         #3
        [0,0,0,0,0,0,0,0],                         #4
        [0,0,0,0,0,0,0,0],                         #5
        [0,0,0,0,0,0,0,0],                         #6
        [0,0,0,0,0,0,0,0]                          #7
       # 0 1 2 3 4 5 6 7
      ]
      
      @piecesRoot.each do |piece|
        # p piece.row
        # p piece.col
        # p piece.pieceStr
        thisCol = piece.col
        thisRow = piece.row
        # p thisCol
        # p thisRow
        currentBoardArray[thisRow][thisCol] = piece.pieceStr
      end
      currentBoardArray

  end

  def drawSquare(color,piece=0)
    if piece == 0 || piece == "0" then piece = " " end
    return "\u001b[46;1m #{piece}  \u001b[0m" if (color=="white")
    return "\u001b[44;1m #{piece}  \u001b[0m" if (color=="black")
  end

  def drawRow(arr,rowNum)
    arr.each_with_index do |piece,index|
      if(rowNum.even?&&index.even?) then
        print drawSquare("black",piece)
      elsif(rowNum.even?&& !index.even?) then
        print print drawSquare("white",piece)
      elsif (!rowNum.even?&&index.even?) then
        print drawSquare("white",piece)
      else
        print drawSquare("black",piece)
      end
    end
  end

  def drawBoard
    # p @currentBoard
    print "\n"
    @currentBoard.each_with_index do |row,rowNumber|
      drawRow(row,rowNumber)
      print "\n"
    end
    print "\n"
  end

  def emptySquare?(col,row)
    @currentBoard[row][col] == 0 ? true : false
  end

  def getCurrentPiece(col,row)
    return @currentBoard[row][col]
  end

  def emptyOriginSquare(col,row)
    return nil if @currentBoard[row][col] = 0
    @currentBoard[row][col] = 0
  end

  def updateTargetSquare(col,row,movingPiece)
    @currentBoard[row][col] = movingPiece
  end

  def updateMoveOnBoard(origin,target)
    movingPiece = getCurrentPiece(origin[0],origin[1])
    emptyOriginSquare(origin[0],origin[1])
    updateTargetSquare(target[0],target[1],movingPiece)
  end

  def isInsideOfBoard(col,row)
    return false if col<0 || row< 0 || col > 7 || row > 7
    true
  end

  def isValidMove(origin,target,piece)

  end

end
game = Board.new
# game.renderBoardArray

game.drawBoard
# p Board.ancestors
# pawn = Pawn.new(0,1,"white")
# pawn2 = Pawn.new(0,1,"black")
# p pawn
# p pawn.allowedMoves
# pawn.move()
# p game.ancestors

# game.updateMoveOnBoard([1,0],[2,2])

# game.drawBoard
