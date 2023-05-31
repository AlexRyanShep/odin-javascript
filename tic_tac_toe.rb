# frozen_string_literal: false

# Contains piece, name and score for the given player
class Player
  attr_reader :score, :piece, :name

  def initialize(name, piece)
    @score = 0
    @name = name
    @piece = piece
    @random = Random.new
  end

  def submit_coordinates(board)
    case @name
    when 'Computer'
      computer_input(board)
    else
      player_input_val(board)
    end
  end

  def computer_input(board)
    puts "Computer's turn:"
    x = @random.rand(0..2)
    y = @random.rand(0..2)
    until board[y][x] == ''
      x = @random.rand(0..2)
      y = @random.rand(0..2)
      puts "#{x} /#{y}"
    end
    [x, y]
  end

  def player_input_val(board)
    x, y = player_input_get
    until (x.between?(0, 2) && y.between?(0, 2)) && board[y][x] == ''
      puts "Invalid coordinates X: #{x + 1}, Y: #{y + 1}"
      x, y = player_input_get
    end
    [x, y]
  end

  def player_input_get
    puts 'Enter X coordinate (1-3)'
    x = gets.chomp.to_i - 1
    puts 'Enter Y coordinate (1-3)'
    y = gets.chomp.to_i - 1
    [x, y]
  end

  def check_score(other)
    if @score > other.score
      puts "#{@name} is winning with #{@score} points, versus #{other.name} with #{other.score} points"
    elsif @score < other.score
      puts "#{other.name} is winning with #{other.score} points, versus #{@name} with #{score} points"
    else
      puts "#{@name} and #{other.name} are drawing at #{@score} points"
    end
  end
end

# Each instance represents a separate round of tic-tac-toe
class Game
  attr_reader :current_player

  def initialize(player1, player2, first_player)
    @player1 = player1
    @player2 = player2
    @board = Array.new(3) { Array.new(3, '') }
    @current_player = first_player
    @diagonals = {
      ul_dr: [[0, 0], [1, 1], [2, 2]],
      ur_dl: [[0, 2], [1, 1], [2, 0]]
    }
  end

  def display
    @board.each { |row| puts row.inspect }
    puts
  end

  def play_round(player)
    x, y = player.submit_coordinates(@board)
    @board[y][x] = player.piece
    display
    @current_player = @current_player == @player1 ? @player2 : @player1
    check_victory # TODO: modify to report victor
  end
  
  # Checks various victory conditions (or for a draw) and returns true if it encounters them
  def check_victory
    if row?
      puts 'Row!'
      true
    elsif draw?
      puts 'Draw!'
      true
    elsif vertical?
      puts 'Vertical!'
      true
    elsif diagonal?
      puts 'Diagonal!'
      true
    else
      false
    end
  end

  def row?
    @board.each { |row| return true if row[0] != '' && (row[0] == row[1] && row[1] == row[2]) }
    false
  end

  def draw?
    !@board.flatten.include?('')
  end

  def vertical?
    3.times { |x| return true if @board[0][x] != '' && (@board[0][x] == @board[1][x] && @board[1][x] == @board[2][x])}
    false
  end

  def diagonal?
    @diagonals.each do |_, arr|
      if @board[arr[0][0]][arr[0][1]] != '' &&
         (@board[arr[1][0]][arr[1][1]] == @board[arr[0][0]][arr[0][1]] &&
         @board[arr[1][0]][arr[1][1]] == @board[arr[2][0]][arr[2][1]])
        return true
      end
    end
    false
  end
end

puts 'Please enter your name:'
player_name = gets.chomp
human = Player.new(player_name, 'X')
computer = Player.new('Computer', 'O')

game1 = Game.new(human, computer, human)

until game1.play_round(game1.current_player)
end

# TODO: Multiple rounds
