

p "Chess init"

class Game

  def initialize()
    # @board = Board.new
    @player1 = Player.new
    @player2 = Player.new
  end

end

class Player
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

