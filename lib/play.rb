# frozen_string_literal: true

require_relative 'information'
require_relative 'logo'
require_relative 'menu_system'
require_relative 'word_list'

# Display board, provide feedback
class HangmanBoard
  def initialize(word)
    @word = word
  end

  def display
    puts @word
  end
end

# game loop
class Play
  include MenuSystem

  MAIN_MENU = ['New Game', 'Continue Game', 'How To Play', 'Exit Game'].freeze

  def initialize
    @word_list = WordList.new
  end

  def game
    catch :exit do
      loop { menu_system(MAIN_MENU) }
    end
  end

  private

  def new_game
    @board = HangmanBoard.new(@word_list.new_word)
    @board.display
  end

  def continue_game; end

  def how_to_play
    print new_screen, logo_four, "\n"
    print rules_doc, "\n"
    print 'Return...'
    gets
  end

  def exit_game
    print new_screen
    print 'So long friendo...', "\n\n"
    throw :exit
  end
end
