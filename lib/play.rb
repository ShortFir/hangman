# frozen_string_literal: true

require_relative 'hangman_board'
require_relative 'here_docs'
require_relative 'logo'
require_relative 'menu_system'
require_relative 'player_input'
require_relative 'word_list'

# Game loop
class Play
  include HereDocs
  include Logo
  include MenuSystem
  include PlayerInput

  MAIN_MENU = ['New Game', 'Load Game', 'How To Play', 'Exit Game'].freeze
  HANG_MENU = ['Save Game', 'End Game'].freeze
  FILE = 'save/save_game.yaml'

  def initialize
    @word_list = WordList.new
  end

  def game
    catch :exit do
      loop { menu_system(MAIN_MENU, true) }
    end
  end

  private

  def new_game
    @board = HangmanBoard.new(@word_list.new_word)
    game_loop
  end

  def game_loop
    catch :game_over do
      loop { game_system }
    end
  end

  # goto menu from hangscreen? save load exit etc...?
  def game_system
    new_screen
    @board.display
    end_game if @board.game_over?
    menu_system(HANG_MENU)
    # clean up
    letter = hang_input
    save_game if letter == '1'
    end_game if letter == '2'
    @board.compare_word(letter)
  end

  def save_game
    Dir.mkdir('save') unless Dir.exist?('save')
    # Block automatically closes file after use.
    File.open(FILE, 'w') { |file| @board.save_yaml(file) }
  end

  def load_game
    if File.exist?(FILE)
      File.open(FILE, 'r') { |file| @board = HangmanBoard.load_yaml(file) }
      game_loop
    else
      # temp
      puts 'no file exists'
      await_enter
    end
  end

  def how_to_play
    new_screen
    print rules_doc, "\n"
    print 'Return...'
    await_enter
  end

  # Add win loss later
  # can enter letters after word. FIX
  def end_game
    print "\n", 'Game Over. Word was : ', @board.word
    await_enter
    throw :game_over
  end

  def exit_game
    print clear_screen
    print 'So long friendo...', "\n\n"
    throw :exit
  end
end
