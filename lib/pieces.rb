module Pieces
  
  def getMoves(currentBoard) 
    arr = []
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
      7.times do |i|
        # break if selfRow+i+1<0
        rowDirection = selfRow-i-1
        colDirection = selfCol+i+1
        break if rowDirection<0 || colDirection>7
        # p "Top right", [rowDirection,colDirection]
        if currentBoard.retrievePieceObj([rowDirection,colDirection]).nil? then
          arr << [rowDirection,colDirection]
        else
          
          if(self.color!= currentBoard.retrievePieceObj([rowDirection,colDirection]).color)then
            arr << [rowDirection,colDirection]
          end
          break
        end
      end

      # TOP LEFT
      7.times do |i|
        # p "Top left", [selfRow-i-1,selfCol-i-1]
        rowDirection = selfRow-i-1
        colDirection = selfCol-i-1
        break if rowDirection<0 || colDirection<0
        # p "Top left", [rowDirection,colDirection]
        if currentBoard.retrievePieceObj([rowDirection,colDirection]).nil? then
          arr << [rowDirection,colDirection]
        else
          if(self.color!= currentBoard.retrievePieceObj([rowDirection,colDirection]).color)then
            arr << [rowDirection,colDirection]
          end
          break
        end
      end

      # DOWN RIGHT
      7.times do |i|
        rowDirection = selfRow+i+1
        colDirection = selfCol+i+1
        break if rowDirection>7 || colDirection>7
        # p "Top left", [rowDirection,colDirection]
        if currentBoard.retrievePieceObj([rowDirection,colDirection]).nil? then
          arr << [rowDirection,colDirection]
        else
          if(self.color!= currentBoard.retrievePieceObj([rowDirection,colDirection]).color)then
            arr << [rowDirection,colDirection]
          end
          break
        end
      end

      # DOWN LEFT
      7.times do |i|
        # p "Down left", [selfRow+i+1,selfCol-i-1]
        rowDirection = selfRow+i+1
        colDirection = selfCol-i-1
        break if rowDirection>7 || colDirection<0
        # p "Top left", [rowDirection,colDirection]
        if currentBoard.retrievePieceObj([rowDirection,colDirection]).nil? then
          arr << [rowDirection,colDirection]
        else
          if(self.color!= currentBoard.retrievePieceObj([rowDirection,colDirection]).color)then
            arr << [rowDirection,colDirection]
          end
          break
        end

      end
      p "This bishop can go to: "
      p arr
      return arr
    
    
    when 'Rook'
      p "It's a rook"
      p self
      selfCol = self.col
      selfRow = self.row
      # p selfCol, selfRow
      # TOP
      7.times do |i|  
        rowDirection = selfRow-i-1
        colDirection = selfCol
        break if rowDirection<0 #|| colDirection>7
        # p currentBoard.retrievePieceObj([rowDirection,colDirection])
        if currentBoard.retrievePieceObj([rowDirection,colDirection]).nil? then
          arr << [rowDirection,colDirection]
        else
          
          if(self.color!= currentBoard.retrievePieceObj([rowDirection,colDirection]).color)then
            arr << [rowDirection,colDirection]
          end
          break
        end
      end

      # DOWN
      7.times do |i|  
        rowDirection = selfRow+i+1
        colDirection = selfCol
        break if rowDirection>7 #|| colDirection>7
        # p currentBoard.retrievePieceObj([rowDirection,colDirection])
        if currentBoard.retrievePieceObj([rowDirection,colDirection]).nil? then
          arr << [rowDirection,colDirection]
        else
          if(self.color!= currentBoard.retrievePieceObj([rowDirection,colDirection]).color)then
            arr << [rowDirection,colDirection]
          end
          break
        end
      end

      
      # LEFT
      7.times do |i|  
        rowDirection = selfRow
        colDirection = selfCol-i-1
        break if colDirection<0
        # p currentBoard.retrievePieceObj([rowDirection,colDirection])
        if currentBoard.retrievePieceObj([rowDirection,colDirection]).nil? then
          arr << [rowDirection,colDirection]
        else
          if(self.color!= currentBoard.retrievePieceObj([rowDirection,colDirection]).color)then
            arr << [rowDirection,colDirection]
          end
          break
        end
      end

      
      # RIGHT
      7.times do |i|  
        rowDirection = selfRow
        colDirection = selfCol+i+1
        break if colDirection>7 #|| colDirection>7
        # p currentBoard.retrievePieceObj([rowDirection,colDirection])
        if currentBoard.retrievePieceObj([rowDirection,colDirection]).nil? then
          arr << [rowDirection,colDirection]
        else
          if(self.color!= currentBoard.retrievePieceObj([rowDirection,colDirection]).color)then
            arr << [rowDirection,colDirection]
          end
          break
        end
      end
      
      p arr
      return arr
    when 'Queen'
      p "It's the queen"
      p self
      selfCol = self.col
      selfRow = self.row
            # TOP
            7.times do |i|  
              rowDirection = selfRow-i-1
              colDirection = selfCol
              break if rowDirection<0 #|| colDirection>7
              # p currentBoard.retrievePieceObj([rowDirection,colDirection])
              if currentBoard.retrievePieceObj([rowDirection,colDirection]).nil? then
                arr << [rowDirection,colDirection]
              else
                
                if(self.color!= currentBoard.retrievePieceObj([rowDirection,colDirection]).color)then
                  arr << [rowDirection,colDirection]
                end
                break
              end
            end
      
            # DOWN
            7.times do |i|  
              rowDirection = selfRow+i+1
              colDirection = selfCol
              break if rowDirection>7 #|| colDirection>7
              # p currentBoard.retrievePieceObj([rowDirection,colDirection])
              if currentBoard.retrievePieceObj([rowDirection,colDirection]).nil? then
                arr << [rowDirection,colDirection]
              else
                if(self.color!= currentBoard.retrievePieceObj([rowDirection,colDirection]).color)then
                  arr << [rowDirection,colDirection]
                end
                break
              end
            end
      
            
            # LEFT
            7.times do |i|  
              rowDirection = selfRow
              colDirection = selfCol-i-1
              break if colDirection<0
              # p currentBoard.retrievePieceObj([rowDirection,colDirection])
              if currentBoard.retrievePieceObj([rowDirection,colDirection]).nil? then
                arr << [rowDirection,colDirection]
              else
                if(self.color!= currentBoard.retrievePieceObj([rowDirection,colDirection]).color)then
                  arr << [rowDirection,colDirection]
                end
                break
              end
            end
      
            
            # RIGHT
            7.times do |i|  
              rowDirection = selfRow
              colDirection = selfCol+i+1
              break if colDirection>7 #|| colDirection>7
              # p currentBoard.retrievePieceObj([rowDirection,colDirection])
              if currentBoard.retrievePieceObj([rowDirection,colDirection]).nil? then
                arr << [rowDirection,colDirection]
              else
                if(self.color!= currentBoard.retrievePieceObj([rowDirection,colDirection]).color)then
                  arr << [rowDirection,colDirection]
                end
                break
              end
            end



      # TOP RIGHT
      7.times do |i|
        # break if selfRow+i+1<0
        rowDirection = selfRow-i-1
        colDirection = selfCol+i+1
        break if rowDirection<0 || colDirection>7
        # p "Top right", [rowDirection,colDirection]
        if currentBoard.retrievePieceObj([rowDirection,colDirection]).nil? then
          arr << [rowDirection,colDirection]
        else
          
          if(self.color!= currentBoard.retrievePieceObj([rowDirection,colDirection]).color)then
            arr << [rowDirection,colDirection]
          end
          break
        end
      end

      # TOP LEFT
      7.times do |i|
        # p "Top left", [selfRow-i-1,selfCol-i-1]
        rowDirection = selfRow-i-1
        colDirection = selfCol-i-1
        break if rowDirection<0 || colDirection<0
        # p "Top left", [rowDirection,colDirection]
        if currentBoard.retrievePieceObj([rowDirection,colDirection]).nil? then
          arr << [rowDirection,colDirection]
        else
          if(self.color!= currentBoard.retrievePieceObj([rowDirection,colDirection]).color)then
            arr << [rowDirection,colDirection]
          end
          break
        end
      end

      # DOWN RIGHT
      7.times do |i|
        rowDirection = selfRow+i+1
        colDirection = selfCol+i+1
        break if rowDirection>7 || colDirection>7
        # p "Top left", [rowDirection,colDirection]
        if currentBoard.retrievePieceObj([rowDirection,colDirection]).nil? then
          arr << [rowDirection,colDirection]
        else
          if(self.color!= currentBoard.retrievePieceObj([rowDirection,colDirection]).color)then
            arr << [rowDirection,colDirection]
          end
          break
        end
      end

      # DOWN LEFT
      7.times do |i|
        # p "Down left", [selfRow+i+1,selfCol-i-1]
        rowDirection = selfRow+i+1
        colDirection = selfCol-i-1
        break if rowDirection>7 || colDirection<0
        # p "Top left", [rowDirection,colDirection]
        if currentBoard.retrievePieceObj([rowDirection,colDirection]).nil? then
          arr << [rowDirection,colDirection]
        else
          if(self.color!= currentBoard.retrievePieceObj([rowDirection,colDirection]).color)then
            arr << [rowDirection,colDirection]
          end
          break
        end

      end
      p "This Queen can go to: "
      p arr
      return arr
    else
      p "It's the king.. .hopefully"
      p self
      selfCol = self.col
      selfRow = self.row
      kingMoves = [[1,-1],[1,0],[1,1],[0,-1],[0,1],[-1,-1],[-1,0],[-1,1]]

      kingMoves.each do |move|
        rowDirection = selfRow+move[0]
        colDirection = selfCol+move[1]
        next if rowDirection>7 || colDirection<0|| rowDirection<0 || colDirection>7
        # p "Top left", [rowDirection,colDirection]
        if currentBoard.retrievePieceObj([rowDirection,colDirection]).nil? then
          arr << [rowDirection,colDirection]
        else
          if(self.color!= currentBoard.retrievePieceObj([rowDirection,colDirection]).color)then
            arr << [rowDirection,colDirection]
          end
        end
      end
    end
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
