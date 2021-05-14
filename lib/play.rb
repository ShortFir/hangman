# frozen_string_literal: true

require_relative 'hangman_board'
require_relative 'here_docs'
require_relative 'logo'
require_relative 'menu_system'
require_relative 'player_input'
require_relative 'word_list'

# Game loop
class Play
  include HangedMen
  include HowToPlay
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
      loop { menu_system(MAIN_MENU, extras: true) }
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

  def game_system
    new_screen
    @board.display
    game_system_win_fail
    menu_system(HANG_MENU)
    game_system_input
  end

  def game_system_win_fail
    case @board.win_or_fail
    when 'win' then end_game(win: true)
    when 'fail' then end_game(fail: true)
    end
  end

  def game_system_input
    case input = hang_input
    when '1'
      save_game
      save_message
    when '2' then end_game
    else @board.compare_word(input)
    end
  end

  # Block automatically closes files after use.
  def save_game
    Dir.mkdir('save') unless Dir.exist?('save')
    File.open(FILE, 'w') { |file| @board.save_yaml(file) }
  end

  def save_message
    new_screen
    @board.display
    puts 'Game Saved. Exiting...'
    pause_continue
    end_game
  end

  def load_game
    if File.exist?(FILE)
      File.open(FILE, 'r') { |file| @board = HangmanBoard.load_yaml(file) }
      game_loop
    else
      puts "\n\n", 'File does not exist.'
      pause_continue
    end
  end

  def how_to_play
    new_screen
    print play_rules
    pause_continue
  end

  def end_game(win: false, fail: false)
    if win
      print '---------- YOU WIN ----------', "\n"
    elsif fail
      print 'Game Over! Hidden word was... ', @board.word, "\n"
    end
    pause_continue if win || fail
    throw :game_over
  end

  # This is here because I was using the word friendo originally to say goodbye.
  # "So long friendo", then wondered what the actual quote was.
  # Kind of an appropriate movie character for a game that's technically about hanging people.
  def exit_game
    print clear_screen
    print "\"What business is it of yours where I'm from, friendo?\"", "\n"
    print '-- Anton Chigurh : No Country for Old Men', "\n\n"
    throw :exit
  end
end
