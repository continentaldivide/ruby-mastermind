class Mastermind
  attr_accessor :code, :player_guess, :prior_guesses, :guess_count, :guess_options, :game_over

  def initialize
    @code = Array.new(4)
    @player_guess = Array.new(4)
    @prior_guesses = []
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
      player_guess_code
      check_guess
      game_over ? show_game_results : show_turn_results
    end
  end

  def computer_create_code
    self.code = %w[blue green red yellow]
  end

  def player_guess_code
    puts 'Please enter your guess.'
    self.player_guess = sanitize_input
    prior_guesses.push(player_guess)
    self.guess_count += 1
  end

  def sanitize_input
    guess_array = gets.chomp.downcase.split(' ')
    until guess_array.all? { |element| guess_options.include?(element) } && (guess_array.length == 4)
      puts "Sorry, that's not a valid guess. Please provide four colors separated by spaces."
      puts 'Valid colors: red | blue | green | yellow | magenta | cyan'
      guess_array = gets.chomp.downcase.split(' ')
    end
    guess_array
  end

  def check_guess
    puts "guess matches computer code? #{player_guess == code}"
    (self.game_over = true) if (player_guess == code) || guess_count == 3
  end

  def show_turn_results
    puts 'these are turn results'
    puts 'here are your prior guesses:'
    prior_guesses.each_with_index { |element, index| puts "##{index + 1}: #{element.join(' ')}" }
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
