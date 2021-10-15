module Pieces
  
  def getMoves(currentBoard) 
    arr = []
    # p "args"
    # p args

    #Pawn
    case self.class.to_s
    when "Pawn"
      #white pawns move up and black pawn move down
      
      selfRow = self.row
      selfCol = self.col

      if self.color== 'white' then
        forwardPos = [selfRow-1,selfCol]
        if(currentBoard.retrievePieceObj((forwardPos)).nil?)then
          arr << forwardPos
          forwardPos = [forwardPos[0]-1,forwardPos[1]]
          if(self.moved==false&&currentBoard.retrievePieceObj((forwardPos)).nil?)then
            arr << forwardPos
          end
        end

        # p "find diagonal of self"
        currentBoard.findDiagonalPiecesofPawn(self)
        .size.times do |index|
          thisRow = currentBoard.findDiagonalPiecesofPawn(self)[index].row
          thisCol = currentBoard.findDiagonalPiecesofPawn(self)[index].col
          arr << [thisRow, thisCol]
        end

      else #Black Pawn
        forwardPos = [selfRow+1,selfCol]
        p currentBoard.retrievePieceObj((forwardPos)).nil?
        if(currentBoard.retrievePieceObj((forwardPos)).nil?)then
          arr << forwardPos
          forwardPos = [forwardPos[0]+1,forwardPos[1]]
          if(self.moved==false&&currentBoard.retrievePieceObj((forwardPos)).nil?)then
            arr << forwardPos
          end
        end

        # p "find diagonal of self"
        currentBoard.findDiagonalPiecesofPawn(self)
        .size.times do |index|
          thisRow = currentBoard.findDiagonalPiecesofPawn(self)[index].row
          thisCol = currentBoard.findDiagonalPiecesofPawn(self)[index].col
          arr << [thisRow, thisCol]
        end
      end

    when "Horse"
      p "It's a horse"
      p self
      selfCol = self.col
      selfRow = self.row
      horseCombinations = [[2,1],[2,-1],[-2,1],[-2,-1],[-1,2],[1,2],[1,-2],[-1,-2]]
      
      horseCombinations.each_with_index do |combination,index|
        checkRow = selfRow + combination[0]
        checkCol = selfCol + combination[1]
        if(currentBoard.isInsideOfBoard(checkCol,checkRow))then
          if currentBoard.retrievePieceObj([checkRow,checkCol]).nil? then
            p "Empty square"
            arr << [checkRow,checkCol]
          else
            if !(self.color == currentBoard.retrievePieceObj([checkRow,checkCol]).color)then
              arr << [checkRow,checkCol]
            end
          end
        end
      end
      
      
    when "Bishop"
      p "It's a bishop"
      p self
      selfCol = self.col
      selfRow = self.row
      # bishopCombinations = [1,1]
      # TOP RIGHT
      # p "Current, ", [selfRow,selfCol]
      7.times do |i|
        # break if selfRow+i+1<0
        rowDirection = selfRow-i-1
        colDirection = selfCol+i+1
        break if rowDirection<0 || colDirection>7
        p "Top right", [rowDirection,colDirection]
        # p "Top right", [selfRow-i-1,selfCol+i+1]
        # p currentBoard.retrievePieceObj([rowDirection,colDirection]).nil?
        if currentBoard.retrievePieceObj([rowDirection,colDirection]).nil? then
          arr << [rowDirection,colDirection]
        else
          
          if(self.color!= currentBoard.retrievePieceObj([rowDirection,colDirection]).color)then
            arr << [rowDirection,colDirection]
          end
          break
        end
        #if empty, add to array and continue
        #if not empty, check if same color and break. Add if opposite
        
      end
      # TOP LEFT
      7.times do |i|
        # p "Top left", [selfRow-i-1,selfCol-i-1]
      end
      # DOWN RIGHT
      
      7.times do |i|
        # p "Down right", [selfRow+i+1,selfCol+i+1]
      end
      # DOWN LEFT
      
      7.times do |i|
        # p "Down left", [selfRow+i+1,selfCol-i-1]
      end
    else
      p "not a pawn"
    end
    
    #Rook
      # Horizontal positive until there's a piece

      # Horizontal negative

      # Vertical positive

      # Vertical negative

    #Bishop
      #Diagonal right up  until a piece
      #Diagonal right down until a piece
      #Diagonal left up until a piece
      #Diagonal left down until a piece
    #Queen
      # Bishop+Rook moves
    #King
      #is checked
      #Check which pieces can move to any of his influence
      # Moves 1 square any direction
    
      p "This piece can move to the following squares: "
      p arr
      arr
  end
end

  class Pawn
    include Pieces
    attr_accessor :allowedMoves, :row, :col, :moved
    attr_reader :color, :pieceStr, :isKing
    def initialize(row,col,color,moved = false)
      color=="white"? @pieceStr = '♟': @pieceStr = '♙'
      @row = row
      @col = col
      @color = color
      @moved = moved
      @isKing=false
      @allowedMoves = []
    end

  end

  class Rook
    include Pieces
    attr_accessor :allowedMoves, :row, :col
    attr_reader  :color, :pieceStr, :isKing
    def initialize(row,col,color,moved = false)
      @row = row
      @col = col
      @color = color
      @moved = moved
      @isKing=false
      color=="white"? @pieceStr = '♜': @pieceStr = '♖'
      # @allowedMoves = getMoves("rook")
    end

  end

  class Horse
    include Pieces
    attr_accessor :allowedMoves, :row, :col
    attr_reader  :color, :pieceStr, :isKing
    def initialize(row,col,color)
      @row = row
      @col = col
      @color = color
      @isKing=false
      color=="white"? @pieceStr = '♞': @pieceStr = '♘'
      @allowedMoves = []
    end
  end

  class Bishop
    include Pieces
    attr_accessor :allowedMoves, :row, :col
    attr_reader :color, :pieceStr, :isKing
    def initialize(row,col,color)
      @row = row
      @col = col
      @color = color
      @isKing=false
      color=="white"? @pieceStr = '♝': @pieceStr = '♗'
      @allowedMoves = []
    end
  end

class Queen
  include Pieces
  attr_accessor :allowedMoves, :row, :col
  attr_reader  :color, :pieceStr, :isKing
  def initialize(row,col,color)
    @row = row
    @col = col
    @color = color
    @isKing=false
    color=="white"? @pieceStr = '♛': @pieceStr = '♕'
    # @allowedMoves = getMoves("queen")
  end
end

class King
  include Pieces
  attr_accessor :allowedMoves, :row, :col
  attr_reader  :color, :pieceStr, :isKing
  def initialize(row,col,color,moved = false)
    @row = row
    @col = col
    @color = color
    @moved = moved
    @isKing=true
    color=="white"? @pieceStr = '♚': @pieceStr = '♔'
    # @allowedMoves = getMoves("king")
  end

end
