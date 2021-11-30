require 'timeout'
require_relative './board'
require_relative './pieces'

class Player
  attr_accessor :colorPlayer, :humanPlayer

  def initialize(colorPlayer = 'white', humanPlayer = true)
    @colorPlayer = colorPlayer
    @humanPlayer = humanPlayer
  end
end

class Game
  attr_reader :board, :player1, :player2

  def initialize(newBoard = Board.new)
    @board = newBoard
    @player1 = Player.new('white', true)
    @player2 = Player.new('black', true)
    @activePlayerWhite = true
  end

  def promptMove
    p 'Please... Choose a square...'
    origin = gets.chomp
    originCols = 'abcdefgh'.split('')
    originRows = '12345678'.split('')
    while !originCols.include?(origin[0]) || !originRows.include?(origin[1])
      p 'not a valid position! Choose a position like a2 or f7'
      origin = gets.chomp
    end

    decodeUserInputPos(origin)
  end

  def decodeUserInputPos(userStr)
    rows = {
      8 => 0,
      7 => 1,
      6 => 2,
      5 => 3,
      4 => 4,
      3 => 5,
      2 => 6,
      1 => 7
    }

    cols = {
      'a' => 0,
      'b' => 1,
      'c' => 2,
      'd' => 3,
      'e' => 4,
      'f' => 5,
      'g' => 6,
      'h' => 7
    }

    arr = []
    usersplitted = userStr.split('')
    thisRow = usersplitted[1].to_i
    row = rows[thisRow]
    thisCol = usersplitted[0]
    col =  cols[thisCol]

    arr << row
    arr << col

    arr
  end

  def init_menu
    print "\n"
    print "Welcome! Please select one of the following:\n\n"
    print "1) Start a new game against the computer. \n"
    print "2) Start a new game against another human player\n"
    user_answer = gets.chomp

    while user_answer.to_i != 1 && user_answer.to_i != 2
      print "Sorry. That's not right. Try again.\n"
      user_answer = gets.chomp
    end

    # Computer/Human game selector
    if user_answer.to_i == 1
      print "\n"
      print "Would you like to play as (1) white or (2) black?\n"
      user_color = gets.chomp
      while user_color.to_i != 1 && user_color.to_i != 2
        print "Sorry. That's not right. Try again.\n"
        user_color = gets.chomp
      end

      if user_color.to_i == 1
        @player2.humanPlayer = false
      else
        @player1.humanPlayer = false
      end
      next_turn
    else
      next_turn
    end
  end

  def getCurrentActivePlayer
    @activePlayer == 1 ? @player1 : @player2
  end

  def next_turn
    active_player_color = 'white'
    active_player_color = 'black' if @activePlayerWhite == false
    p "It's #{active_player_color}'s player turn"
    # p board.currentPieces
    board.drawBoard

    if board.check?(active_player_color)
      p 'Check!'
      if board.checkmate?(active_player_color)
        p 'Checkmate! You lost!'
        return
      else
        # p "Not checkmate"
        move
      end

      @activePlayerWhite = !@activePlayerWhite
      next_turn
    end

    # if active player is human, run move. Else run move_ai
    if (active_player_color == @player1.colorPlayer && @player1.humanPlayer == true) ||
       (active_player_color == @player2.colorPlayer && @player2.humanPlayer == true)
      move
    else
      move_ai
    end
    # p " END"
    # p @activePlayerWhite
    @activePlayerWhite = !@activePlayerWhite

    next_turn
  end

  def move_ai
    p 'AI player move: '
    active_player_color = 'white'
    active_player_color = 'black' if @activePlayerWhite == false
 

  end

  def move
    # p "Human player move"
    active_player_color = 'white'
    active_player_color = 'black' if @activePlayerWhite == false
    p 'Human player move: '
    origin = promptMove
    originObj = board.retrievePieceObj(origin)

    while originObj.nil?
      p "That's an empty square! Try another square"
      origin = promptMove
      originObj = board.retrievePieceObj(origin)
    end

    while originObj.nil? || originObj.color != active_player_color
      p "That's not your piece! Try again"
      origin = promptMove
      originObj = board.retrievePieceObj(origin)
    end

    while originObj.getMoves(board).size < 1
      p "That piece can't move!"
      origin = promptMove
      originObj = board.retrievePieceObj(origin)
    end
    originMoves = originObj.getMoves(board)
    # p originMoves
    # p "  / "
    # Filter out moves that reveal a check board
    originMoves.reject! do |target_position|
      newBoardPieces = board.updatePiecesArray(board.currentPieces, originObj, target_position)
      newBoard = Board.new(newBoardPieces)
      newBoard.check?(active_player_color)
    end
    # p "After is: "
    # p originMoves
    # p !originMoves.length.positive?
    until originMoves.length.positive?
      p "Try again... That piece can't move!"
      origin = promptMove
      originObj = board.retrievePieceObj(origin)
      originMoves = originObj.getMoves(board)
    end

    p 'Alright... Where is it going to?'
    target = promptMove
    until originMoves.include?(target)
      p 'Not a valid move. Try again'
      target = promptMove
    end
    next_turn_board_pieces = board.updatePiecesArray(board.currentPieces, originObj, target)
    board.currentPieces = next_turn_board_pieces
  end
end

newSituation = [
  # White pieces
  # Pawn.new(6,0,"white"),
  # Pawn.new(6,1,"white"),
  # Pawn.new(6,2,"white"),
  # Pawn.new(6,3,"white"),
  # Pawn.new(6,4,"white"),
  # Pawn.new(5,5,"white"),
  Pawn.new(6, 6, 'white'),
  # Pawn.new(6,7,"white"),
  # Rook.new(7,0,"white"),
  # Rook.new(7,7,"white"),
  # Horse.new(7,1,"white"),
  # Horse.new(7,6,"white"),
  # Bishop.new(7,2,"white"),
  # Bishop.new(7,5,"white"),
  # Queen.new(7,3,"white"),
  King.new(7, 4, 'white'),

  # black pieces
  # Pawn.new(1,0,"black"),
  # Pawn.new(1,1,"black"),
  # Pawn.new(1,2,"black"),
  # Pawn.new(1,3,"black"),
  # Pawn.new(1,4,"black"),
  # Pawn.new(1,5,"black"),
  # Pawn.new(1,6,"black"),
  # Pawn.new(1,7,"black"),
  # Rook.new(0,0,"black"),
  # Rook.new(0,7,"black"),
  # Horse.new(0,1,"black"),
  # Horse.new(0,6,"black"),
  # Bishop.new(0,2,"black"),

  # Bishop.new(0,5,"black"),
  # Queen.new(0,3,"black"),
  King.new(0, 4, 'black'),
  # Bishop.new(3,0,"black"),
  Horse.new(5, 5, 'black')
]

thisBoard = Board.new(newSituation)
newgame = Game.new(thisBoard)
newgame = Game.new
newgame.init_menu
# newgame.board.getMoves
# newgame.next_turn
# newgame.board.drawBoard
