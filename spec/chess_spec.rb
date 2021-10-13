require 'chess'

describe Board do
  let(:startingBoard) {Board.new}
  context "#emptySquare checks empty squares properly" do
    # let(:emptySquareBoard) {Board.new}
    it "returns true if there's no piece in the given square" do
      actual = startingBoard.emptySquare?(3,3)
      expect(actual).to eq(true)
    end
    it "returns false if there's a piece in it" do
      actual = startingBoard.emptySquare?(0,0)
      expect(actual).to eq(false)
    end
    
    context "#getCurrentPiece returns the correct piece" do
      it 'returns the white king from 4,0' do
        actual = startingBoard.getCurrentPiece(4,7)
        whiteking = '♚'
        expect(actual).to eq(whiteking)
      end
      it "returns 0 if it's empty square" do
        actual = startingBoard.getCurrentPiece(3,3)
        expect(actual).to eq(0)
      end
    end

    context "#emptyOriginSquare" do
      it "empties the origin square" do
        startingBoard.emptyOriginSquare(0,6)
        actual = startingBoard.currentBoard[6][0]
        expect(actual).to eq(0)
      end
      it "returns nil if the square is already empty" do
        startingBoard.emptyOriginSquare(3,3)
        actual = startingBoard.getCurrentPiece(3,3)
        expect(actual).to eq(0)
      end
    end

    context "#updateTargetSquare moves the piece to its target" do
      it 'updates the new value of the target square' do
        movingPiece = '♟'
        startingBoard.updateTargetSquare(6,5,movingPiece)
        actual = startingBoard.currentBoard[5][6]
        expect(actual).to eq(movingPiece)
      end
    end

    context "#updateMoveOnBoard" do
      it 'advances pawn on the array @currentBoard' do
        origin = [0,6]
        target = [0,5]
        startingBoard.updateMoveOnBoard(origin,target)
        actual = startingBoard.currentBoard
        updatedBoard= 
        [
          ['♖','♘','♗','♕','♔','♗','♘','♖'], #0
          ['♙','♙','♙','♙','♙','♙','♙','♙'], #1
          [0,0,0,0,0,0,0,0],                        #2  
          [0,0,0,0,0,0,0,0],                        #3
          [0,0,0,0,0,0,0,0],                        #4
          ['♟',0,0,0,0,0,0,0],                        #5
          [0,'♟','♟','♟','♟','♟','♟','♟'], #6
          ['♜','♞','♝','♛','♚','♝','♞','♜']  #7
          # 0    1    2    3    4    5    6   7
        ]
        expect(actual).to eq(updatedBoard)
      end
    end
  end
end