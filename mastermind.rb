class Mastermind
  attr_accessor :code, :player_guess, :prior_guesses, :guess_count, :game_over, :checker_code, :checker_guess
  attr_reader :guess_options

  def initialize
    @code = Array.new(4)
    @player_guess = Array.new(4)
    @prior_guesses = []
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
      game_over ? show_game_results : show_turn_results
    end
  end

  def computer_create_code
    self.code = %w[blue blue red red]
  end

  def player_turn
    puts "Please enter your guess. Enter 'history' to see prior guesses."
    get_guess
    if player_guess == 'history'
      show_prior_guesses
      puts 'Please enter your guess.'
      get_guess
    end
    sanitize_input
    while guess_repeat_check == true
      puts "You've already guessed that.  Please enter a new guess."
      get_guess
      sanitize_input
    end
    prior_guesses.push(player_guess)
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
    loop_times = 0
    white_code = []
    white_guess = []
    checker_guess.each_with_index do |element, index|
      loop_times += 1
      if element == checker_code[index]
        black_pegs += 1
      else
        white_code.push(checker_code[index])
        white_guess.push(checker_guess[index])
      end
    end
    puts "Black pegs: #{black_pegs}"
    white_code.sort!
    white_guess.sort!
    white_guess.each_with_index do |element, index|
      white_pegs += 1 if element == white_code[index]
    end
    puts "White pegs: #{white_pegs}"
  end

  def give_guess_feedback
    puts "guess matches computer code? #{player_guess == code}"
    (self.game_over = true) if (player_guess == code) || guess_count == 3
  end

  def show_prior_guesses
    if guess_count == 0
      puts 'No guesses yet.'
    else
      puts 'Here are your prior guesses:'
      prior_guesses.each_with_index { |element, index| puts "##{index + 1}: #{element.join(' ')}" }
    end
  end

  def show_turn_results
    puts 'these are turn results'
  end

  def show_game_results
    puts 'these are game results'
  end
end

class String
  def colorize(color_code)
    "\e[1;#{color_code}m#{self}\e[0m"
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
end

Mastermind.new
