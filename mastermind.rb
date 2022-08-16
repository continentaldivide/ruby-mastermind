require 'pry-byebug'

class Mastermind
  attr_accessor :code, :player_guess, :prior_guesses, :guess_count, :game_over, :checker_code, :checker_guess
  attr_reader :guess_options

  def initialize
    @code = []
    @player_guess = Array.new(4)
    @prior_guesses = {
      guesses: [],
      results: []
    }
    @checker_code = []
    @guess_count = 0
    @guess_options = %w[red blue green yellow magenta cyan]
    @game_over = false
    start_game
  end

  private

  def start_game
    computer_create_code
    self.guess_count = 0
    until game_over == true
      player_turn
      check_guess
      give_guess_feedback
      show_game_results if game_over
    end
  end

  def computer_create_code
    # 4.times { code.push(guess_options.sample) }
    self.code = %w[red red red green]
  end

  def player_turn
    puts "Please enter your guess. Enter 'history' to see prior guesses."
    get_guess
    if player_guess == 'history'
      show_prior_guesses
      puts 'Please enter your guess.'
      get_guess
    elsif player_guess == 'code'
      puts code
      get_guess
    end
    sanitize_input
    while guess_repeat_check == true
      puts "You've already guessed that.  Please enter a new guess."
      get_guess
      sanitize_input
    end
    prior_guesses[:guesses].push(player_guess)
    self.guess_count += 1
  end

  def get_guess
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
    prior_guesses.include?(player_guess)
  end

  def check_guess
    checker_code = code.clone
    checker_guess = player_guess.clone
    black_pegs = 0
    white_pegs = 0
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
    # checker_code.sort!
    # checker_guess.sort!
    # checker_guess.each_with_index do |element, index|
    #   white_pegs += 1 if element == checker_code[index]
    # end
    white_pegs = count_white_pegs(checker_code, checker_guess)
    prior_guesses[:results].push build_results(black_pegs, white_pegs)
  end

  def count_white_pegs(checker_code, checker_guess)
    white_pegs = 0
    comp_array = Array.new(6) { Array.new(2) }
    guess_options.each_with_index do |element, index|
      comp_array[index].push(checker_code.count(element)) # broken -- need a workaround for this adding nils
      comp_array[index].push(checker_guess.count(element))
    end
    comp_array.each { |element| white_pegs += element.min }
    puts white_pegs
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
    (self.game_over = true) if (player_guess == code) || guess_count == 12
  end

  def show_prior_guesses
    if guess_count == 0
      puts 'No guesses yet.'
    else
      puts 'Here are your prior guesses:'
      prior_guesses[:guesses].each_with_index do |element, index|
        puts "##{index + 1}: #{element.join(' ')} | " + prior_guesses[:results][index].to_s
      end
    end
  end

  def show_game_results
    puts 'these are game results'
    puts "Code was: #{code.join(' ')}"
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
