require 'pry-byebug'

class Mastermind
  attr_accessor :code, :player_guess, :prior_guesses, :guess_count, :game_over, :play_again
  attr_reader :guess_options

  def initialize
    play_game until play_again == false
  end

  private

  def play_game
    set_variables
    computer_create_code
    startup_text
    until game_over == true
      player_turn
      check_guess
      give_guess_feedback
      (self.game_over = true) if (player_guess == code) || guess_count == 12
    end
    show_game_results
    check_if_playing_again
  end

  def set_variables
    @code = []
    @player_guess = Array.new(4)
    @prior_guesses = {
      guesses: [],
      results: []
    }
    @guess_count = 0
    @guess_options = %w[red blue green yellow magenta cyan]
    @game_over = false
    @play_again = true
  end

  def computer_create_code
    self.code = %w[red red red red]
    # 4.times { code.push(guess_options.sample) }
  end

  def startup_text
    puts 'PH.  Will ask the player if they need instructions, if yes give instructions if no advance to game.'
    puts 'press 1 for instructions'
    puts 'press 2 to continue'
    input = ''
    input = gets.chomp until %w[1 2].include?(input)
    input == '1' ? give_instructions : (puts 'go ahead and guess')
    # if yes give_instructions
    # if no puts "Please enter your guess. Enter 'history' to see prior guesses."
  end

  def give_instructions
    puts 'these are instructions'
    puts 'go ahead and guess'
  end

  def player_turn
    retrieve_input
    if player_guess == 'history'
      show_prior_guesses
      puts 'Please enter your guess.'
      retrieve_input
    end
    sanitize_input
    while guess_repeat_check == true
      puts "You've already guessed that.  Please enter a new guess."
      retrieve_input
      sanitize_input
    end
    prior_guesses[:guesses].push(player_guess)
    self.guess_count += 1
  end

  def retrieve_input
    self.player_guess = gets.chomp
  end

  def sanitize_input
    guess_array = player_guess.downcase.split(' ')
    until guess_array.all? { |element| guess_options.include?(element) } && (guess_array.length == 4)
      puts "Sorry, that's not a valid guess. Please provide four colors separated by spaces."
      puts "Valid colors: #{guess_options.join(' | ')}"
      guess_array = gets.chomp.downcase.split(' ')
    end
    self.player_guess = guess_array
  end

  def guess_repeat_check
    prior_guesses[:guesses].include?(player_guess)
  end

  def check_guess
    checker_code = code.clone
    checker_guess = player_guess.clone
    black_pegs = count_black_pegs(checker_code, checker_guess)
    white_pegs = count_white_pegs(checker_code, checker_guess)
    prior_guesses[:results].push build_results(black_pegs, white_pegs)
  end

  def count_black_pegs(checker_code, checker_guess)
    black_pegs = 0
    i = 0
    while i < checker_guess.length
      if checker_guess[i] == checker_code[i]
        black_pegs += 1
        checker_code.slice!(i)
        checker_guess.slice!(i)
      else
        i += 1
      end
    end
    black_pegs
  end

  def count_white_pegs(checker_code, checker_guess)
    white_pegs = 0
    comp_array = Array.new(6) { Array.new(0) }
    guess_options.each_with_index do |element, index|
      comp_array[index].push(checker_code.count(element))
      comp_array[index].push(checker_guess.count(element))
    end
    comp_array.each { |element| white_pegs += element.min }
    white_pegs
  end

  def build_results(black_pegs, white_pegs)
    str = ''
    black_pegs.times { str += '●'.green }
    white_pegs.times { str += '●'.yellow }
    (4 - black_pegs - white_pegs).times { str << 'o' }
    str
  end

  def give_guess_feedback
    puts prior_guesses[:results].last
  end

  def show_prior_guesses
    if guess_count.zero?
      puts 'No guesses yet.'
    else
      puts 'Here are your prior guesses:'
      prior_guesses[:guesses].each_with_index do |element, index|
        puts "##{index + 1}: #{element.join(' ')}".ljust(36, ' ') + " | #{prior_guesses[:results][index]}"
      end
    end
  end

  def show_game_results
    puts 'these are game results'
    puts "Code was: #{code.join(' ')}"
  end

  def check_if_playing_again
    self.play_again = false
  end
end

class String
  def colorize(color_code)
    "\e[1;#{color_code}m#{self}\e[0m"
  end

  def black
    "\e[30m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end

  def white
    colorize(37)
  end

  def bg_cyan
    "\e[46m#{self}\e[0m"
  end
end

Mastermind.new
