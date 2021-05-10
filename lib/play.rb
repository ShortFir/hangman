# frozen_string_literal: true

require_relative 'logo'
require_relative 'information'
require_relative 'word_list'
# Display board, provide feedback
# Object
class HangmanBoard
  def initialize(word)
    @word = word
  end

  def display
    puts @word
  end
end

# Get input from player(human)
module PlayerInput
  def menu_input(range, choice = '')
    loop do
      print "Enter (1 - #{range})>"
      choice = gets.chomp.to_i
      break if (1..range).include?(choice)
    end
    choice - 1
  end
end

# Menu system
module Menu
  include Logo
  include Information
  include PlayerInput
  MAIN_MENU = ['New Game', 'Continue Game', 'How To Play', 'Exit Game'].freeze

  private

  # loop
  def start_menu_system
    menu(MAIN_MENU)
  end

  def menu(menu)
    display_menu(menu)
    choice = menu_input(menu.length)
    send(convert_to_method(menu[choice]))
  end

  def display_menu(menu)
    print new_screen, logo_four
    display_options(menu)
  end

  def display_options(options)
    options.each_with_index do |item, index|
      puts "#{(index + 1).to_s.rjust(2)}: #{item}"
    end
  end

  def convert_to_method(menu)
    menu.downcase.split(' ').join('_')
  end

  def how_to_play
    print new_screen, logo_four
    puts "\n", rules
    print "\n", 'Return...'
    gets
  end

  def exit_game
    puts 'So long friendo...'
  end

  def new_screen
    "\e[H\e[2J"
  end
end

# game loop
class Play
  include Menu
  def initialize
    @word_list = WordList.new
  end

  def game
    start_menu_system
  end

  private

  def new_game
    @board = HangmanBoard.new(@word_list.new_word)
    @board.display
  end

  def continue_game; end
end
