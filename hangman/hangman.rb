# frozen_string_literal: true

require 'json'

# Holds the score and name of the player. Persists across rounds.
class Player
  attr_accessor :score
  attr_reader :name

  def initialize(name)
    @score = 0
    @name = name
  end

  def hash_player
    { "name": @name,
      "score": @score }
  end

  def dehash_player(player_state)
    @name = player_state['name']
    @score = player_state['score']
  end
end

# Holds methods and information relating to the current round. Re-instantiated each round.
class Round
  attr_reader :guess, :incorrect_letters

  def initialize
    words = File.readlines('hangman/google-10000-english-no-swears.txt')
    @answer = ''
    @incorrect_letters = []
    @answer = words.sample.downcase.chomp while @answer.length < 5 || @answer.length > 12
    @guess = Array.new(@answer.length, '_')
    @lives_remaining = 7

  end

  def guess_letter(player, guess)
    corr = false

    @answer.split('').each_with_index do |letter, index|
      if guess == letter
        @guess[index] = guess
        corr = true
      end
    end

    guess_results(corr, guess, player)
  end

  def guess_word(player, guess)
    corr = false

    if guess == @answer
      corr = true
      @guess = guess.split('')
    end

    guess_results(corr, guess, player)
  end

  def game_over
    puts "Game over! The word was #{@answer}"
    false
  end

  def incorrect_guess(guess)
    @incorrect_letters.append(guess) if guess.length == 1
    @lives_remaining -= 1
    "#{guess.upcase} is incorrect! #{@lives_remaining} lives remaining!"
  end

  def correct_guess(guess)
    "#{guess.upcase} is correct!\n #{@guess.join('')}" if guess.length == 1
    "#{guess[0].upcase}#{guess[1..]} is correct!"
  end

  def guess_results(corr, guess, player)
    # Messaging and flow after a guess has been checked for correctness.
    if corr
      res = correct_guess(guess)
      return res unless guess_match_answer?(player)

      puts "#{res}\n You win! You have #{player.score} points!"
      true
    elsif !corr && @lives_remaining == 1
      game_over
    else
      incorrect_guess(guess)
    end
  end

  def guess_match_answer?(player)
    # Checks for end state, and updates score
    if @guess.join('') == @answer
      player.score += 1
      true
    else
      false
    end
  end

  def hash_round
    { "answer": @answer,
      "incorrect_guesses": @incorrect_letters,
      "current_guess": @guess,
      "lives_remaining": @lives_remaining }
  end

  def dehash_round(round_state)
    @answer = round_state['answer']
    @incorrect_letters = round_state['incorrect_guesses']
    @guess = round_state['current_guess']
    @lives_remaining = round_state['lives_remaining']
  end
end

def serialise_game_state(player, round)
  output_hash = {}
  output_hash['Player'] = player.hash_player
  output_hash['Round'] = round.hash_round
  JSON.generate(output_hash)
end

def save_game_state(filename, game_state)
  File.open("hangman/saves/#{filename}.json", 'w') do |file|
    file.puts game_state
  end
end

def load_game_state
  puts 'Available saves'
  Dir.entries('hangman/saves').map { |f| File.basename(f, '.*') }[2..].each { |save| puts save }
  print 'Enter save name: '
  state = JSON.parse(File.read("hangman/saves/#{gets.downcase.chomp}.json"))
  player = Player.new('')
  player.dehash_player(state['Player'])
  round = Round.new
  round.dehash_round(state['Round'])
  puts("Welcome back #{player.name}!")
  game_loop(player, round)
end

def choose_action(round, player)
  printf "Incorrect Letters Guessed: #{round.incorrect_letters}\n #{round.guess.join('')}\n" \
         "What do you want to do?\n1) Guess a letter\n2) Guess a word\n3) Save game\n"

  case gets.chomp.to_i
  when 1
    print 'Guess a letter: '
    round.guess_letter(player, gets.downcase.chomp)
  when 2
    print 'Guess a word: '
    round.guess_word(player, gets.downcase.chomp)
  when 3
    print('Enter a save name: ')
    save_game_state(gets.chomp.downcase, serialise_game_state(player, round))
    0
  else
    'Invalid entry.'
  end

end

def game_loop(player, round)
  loop do
    action = choose_action(round, player)
    if action.is_a?(String)
      puts action
    elsif action.zero?
      return false
    else
      loop do
        print 'Do you want to play another round?: '
        case gets&.downcase&.chomp
        when 'y'
          round = Round.new
          puts round.guess.join('')
          break
        when 'n'
          puts 'Goodbye'
          return false
        else
          puts 'Invalid entry'
          next
        end
      end
    end
  end
end

puts 'Load game?'
if %w[y yes].include?(gets.downcase.chomp)
  load_game_state
else
  print 'Starting new game. Enter your name: '
  player = Player.new(gets.chomp!)
  round = Round.new
  puts round.guess.join('')

  game_loop(player, round)
end
