# frozen_string_literal: false

# Contains the code
class Code
  attr_reader :turns_remaining

  def initialize(code)
    @code = code
    @turns_remaining = 12
  end

  def make_guess(guess, player)
    @turns_remaining -= 1
    if @turns_remaining.zero?
      puts 'Out of guesses!'
      return
    end

    return unless code_feedback(guess)

    puts 'Well done!'
    @turns_remaining = 0
    player.score += 1
  end

  def code_feedback(guess)
    checks = [0, 0]
    temp_code = @code.clone

    # Check for matches
    guess.each_with_index do |guess_peg, index|
      next unless guess_peg == temp_code[index]

      checks[0] += 1
      temp_code[index] = ''
      guess[index] = ''
    end

    return true if checks[0] == 4

    guess.each do |guess_peg|
      if guess_peg != '' && temp_code.include?(guess_peg)
        checks[1] += 1
        temp_code.delete_at(temp_code.index(guess_peg))
      end
    end

    puts "#{checks[0]} pegs are the correct colour and in the correct hole."
    puts "#{checks[1]} pegs are the correct colour, but in the wrong hole"

    false
  end
end

# Stores details for the players
class Player
  attr_reader :name, :turns_remaining
  attr_accessor :score

  def initialize(name)
    @name = name
    @score = 0
  end
end

COLOURS = %w[r o p g y b].freeze
def generate_code
  code = []
  4.times { code.append(COLOURS.sample) }
  code
end

def take_turn(player, secret_code)
  guess = []
  puts "Turn #{12 - (secret_code.turns_remaining - 1)}: The available colours are Red, Yellow, Orange, Purple, Green," \
       ' Blue. You can use the first letter of each word.'
  4.times do |x|
    puts "Guess peg number #{x + 1}:"
    guess.append(gets.downcase[0])
  end
  puts guess

  secret_code.make_guess(guess, player)
end

def new_round_query
  choice = gets.downcase[0]
  loop do
    case choice
    when 'y'
      code = generate_code
      p code # TODO: Remove this when done
      return Code.new(code)
    when 'n'
      puts 'Goodbye!'
      return false
    else
      puts 'Invalid Entry'
      next
    end
  end
end

# Game initialization
puts 'Enter your name:'
player1 = Player.new(gets.chomp!)

# Generate initial code
code = %w[g y p g]
p code # TODO: Remove this when done
secret_code = Code.new(code)

# Game loop
puts caesar_cipher("What a string!", 5)
loop do
  # Check for game end.

  if secret_code.turns_remaining.zero?
    puts "#{player1.name}, your score is #{player1.score}. Do you want to play another game? (Y/N)"
    break unless (secret_code = new_round_query) #Returns a new code, or false if user chooses to end the game.

  end

  # Take a turn
  take_turn(player1, secret_code)
end
