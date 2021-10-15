module Pieces
  
  def getMoves(pieceType,*args) 
    arr = []
    #Pawn
    case pieceType
    when "pawn"
      # p "it's a pawn"
      # p pieceType
      p args
      # p moved
      
    else
      # p "not a pawn"
    end
      # Advances forward
      #If moved=false can advance two
      #Edge cases
      #Capture move if rival piece on next or previous column of the next row

    #Rook
      # Horizontal positive until there's a piece

      # Horizontal negative

      # Vertical positive

      # Vertical negative
    #Horse
      #+2 +1
      #+2 -1
      #-2 +1
      #-2 -1
      #-1 +2
      #+1 +2
      #+1 -2
      #-1  -2
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
      @allowedMoves = getMoves("pawn",@color,@moved)
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
      @allowedMoves = getMoves("rook")
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
      @allowedMoves = getMoves("horse")
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
      @allowedMoves = getMoves("bishop")
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
    @allowedMoves = getMoves("queen")
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
    @allowedMoves = getMoves("king")
  end

end
