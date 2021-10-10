# require 'rspec/autorun'




class Board
  
  PIECES  = {
    whitepawn: '♟', 
    whitehorse: '♞',
    whitebishop: '♝',
    whitequeen: '♛',
    whiteking: '♚',
    whitetower: '♜',
    blackpawn: '♙',
    blackhorse: '♘',
    blackbishop: '♗',
    blackqueen: '♕',
    blackking: '♔',
    blacktower: '♖'
  }

attr_accessor :currentBoard
    def initialize
      @currentBoard = [
        ['♖','♘','♗','♕','♔','♗','♘','♖'],
        ['♙','♙','♙','♙','♙','♙','♙','♙'],
        [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0],
        ['♟','♟','♟','♟','♟','♟','♟','♟'],
        ['♜','♞','♝','♛','♔','♝','♞','♜'],
      ]
      
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

  
  
end
game = Board.new
# print game.currentBoard
# print game.drawSquare("white",Board::PIECES[:whitepawn])
game.drawBoard
# p game.currentBoard
# miarr = ['♙','♙','♙','♙','♙','0',0,'♙']
# game.drawRow(miarr,1)
# print  "\n"
# game.drawRow(miarr,0)
