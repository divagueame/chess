require 'chess'

describe Board do
  context "draws empty squares properly" do
    it "shows an empty white square" do
      emptyBoard = Board.new
      actual = emptyBoard.drawSquare("white")
      expect(actual).to eq('\\u001b[46;1m   \\e[0m')
    end
    
    
  end
end