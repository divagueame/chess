class Board
  attr_accessor :currentBoard, :currentPieces

  def initialize (initPieces = [
    # White pieces
    Pawn.new(6,0,"white"),
    Pawn.new(6,1,"white"),
    Pawn.new(6,2,"white"),
    Pawn.new(6,3,"white"),
    Pawn.new(5,4,"white"),
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
    # Pawn.new(5,2,"black"),
    Pawn.new(4,0,"black"),
    Pawn.new(1,1,"black"),
    Pawn.new(1,2,"black"),
    Pawn.new(1,3,"black"),
    Pawn.new(1,4,"black"),
    Pawn.new(1,5,"black"),
    Pawn.new(1,6,"black"),
    Pawn.new(1,7,"black"),
    Rook.new(0,0,"black"),
    Rook.new(0,7,"black"),
    Horse.new(5,3,"black"),
    Horse.new(0,6,"black"),
    # Bishop.new(3,7,"black"),
    Bishop.new(0,5,"black"),
    Queen.new(0,3,"black"),
    King.new(0,4,"black")
  ])
      @currentPieces = initPieces
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
    refreshBoardArray = renderBoardArray
    # p "And... refreshBoardArray"
    # p refreshBoardArray
    print "\n"
    refreshBoardArray.each_with_index do |row,rowNumber|
      inverted = (row.length)-rowNumber
      print "#{inverted}  "
      drawRow(row,rowNumber)
      print "\n"
    end
    print "    a   b   c   d   e   f   g   h\n"
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
    return nil if (!origin)
    currentPiece = currentPieces.select{|piece| piece.row==origin[0]&&piece.col==origin[1]}
    currentPiece[0]
  end

  def findDiagonalPiecesofPawn(pawnObj)
    arr = []
    return p "Not a pawn" if pawnObj.class.to_s != "Pawn"
        
    if pawnObj.color=="white" then
      diagonalLeftPos = [(pawnObj.row) -1,(pawnObj.col)-1]
      diagonalRightPos = [(pawnObj.row) -1,(pawnObj.col)+1]
    else 
      diagonalLeftPos = [(pawnObj.row) +1,(pawnObj.col)-1]
      diagonalRightPos = [(pawnObj.row) +1,(pawnObj.col)+1]
    end

      diagonalLeftPiece = retrievePieceObj(diagonalLeftPos)
      diagonalRightPiece = retrievePieceObj(diagonalRightPos)
      
      arr << diagonalLeftPiece if diagonalLeftPiece && diagonalLeftPiece.color != pawnObj.color
      arr << diagonalRightPiece if diagonalRightPiece && diagonalRightPiece.color != pawnObj.color

    arr
  end
  
  def check?(activePlayer)
    p "Is #{activePlayer} in check?"
    check = false

    # Find coordinates of the activePlayer king
    thisKing = currentPieces.select {|piece| piece.color == activePlayer && piece.class.to_s == "King" }[0]
    thisKingPos = [thisKing.row,thisKing.col]

    # allEnemyMoves
    currentPieces.each_with_index do |pieceObj, i|
      if(pieceObj.color != activePlayer) then
        thisPieceMoves = pieceObj.getMoves(self)
        if thisPieceMoves.include?(thisKingPos) then 
          check = true
          break 
        end
        # if thisPieceMoves.size>0 then p thisPieceMoves end
      end
      
        # thisPieceMoves = pieceObj.getMoves(self)
        # if thisPieceMoves.size>0 then
        
    end
    check
  end

  def checkmate?(activePlayer)
    p "Is #{activePlayer} in checkmate?"
    active_player_pieces = currentPieces.select {|piece| piece.color == activePlayer}
    non_active_player_pieces = currentPieces - active_player_pieces
    
    active_player_moves = []
    active_player_pieces.each do |piece|
      
      if !piece.getMoves(self).empty? then
        # p piece
        # p piece.getMoves(self)
        piece.getMoves(self).size.times do |i|
          thisTarget = piece.getMoves(self)[i]
          # p piece
          # p thisTarget
    #       newPiecesArray = updatePiecesArray(@currentPieces,piece, thisTarget)
        end
      end
    end 
    # p active_player_moves
  end
  
  
  def updatePiecesArray(original_array,moving_piece,target)
  
    # arr = original_array.clone
    #Remove target position piece
    # if !(arr.select {|piece,i| piece.row == target[0] && piece.col == target[1]}).empty? then
      # arr = arr.select {|piece| piece.row != target[0] && piece.col != target[1]}
    # end

    
    # arr.map do |piece| 
      # if piece.row == moving_piece.row && piece.col == moving_piece.col then
        # piece.row = target[0]
        # piece.col = target[1]
      # end 
      # piece
    # end
  end

end