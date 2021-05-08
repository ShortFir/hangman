# frozen_string_literal: true

require_relative 'logo'
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

# Get input from player(human)
class Player
  def initialize; end
end

# loop
class Play
  include Logo
  def game
    word_list = WordList.new
    print new_screen, logo_four
    board = HangmanBoard.new(word_list.new_word)
    board.display
  end

  def new_screen
    "\e[H\e[2J"
  end
end
