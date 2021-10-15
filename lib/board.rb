
class Board
  attr_accessor :currentBoard, :currentPieces
  
  def initialize
      @currentPieces =[
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
        King.new(0,4,"black")
      ]

      @currentBoard = renderBoardArray
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
      
      @currentPieces.each do |piece|
        thisCol = piece.col
        thisRow = piece.row
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

  def retrievePieceObj(origin)
    currentPiece = currentPieces.select{|piece| piece.row==origin[0]&&piece.col==origin[1]}
    # p currentPiece.color
    currentPiece[0]
  end

  def check? targetObj
    return false if !targetObj || !targetObj.isKing
    true
  end
end


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