class Mastermind
  attr_accessor :code, :player_guess, :guess_count

  def initialize
    @code = Array.new(4)
    @player_guess = Array.new(4)
    @guess_count = 0
    start_game
  end

  private

  def start_game
    computer_create_code
    self.guess_count = 0
    player_guess_code
    check_guess
    show_turn_results
  end

  def computer_create_code
    self.code = "blue"
  end

  def player_guess_code
    puts 'Please enter your guess.'
    self.player_guess = gets.chomp
  end

  def check_guess
    puts player_guess == code
  end

  def show_turn_results
    puts 'these are turn results'
  end
end

Mastermind.new
