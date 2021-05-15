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

  # These are converted to method names, so must align correctly.
  MAIN_MENU = ['New Game', 'Load Game', 'Options', 'How To Play', 'Exit Game'].freeze
  HANG_MENU = ['Save Game', 'End Game'].freeze

  SAVE_DIR = 'save/'
  FILE_TYPE = '.yaml'
  TIME_FORMAT = '%Y-%m-%d--%H:%M:%S'

  def initialize
    @word_list = WordList.new
    @new_length = HangmanBoard::GAME_LENGTH_DEFAULT
  end

  # multiple saves?
  def game
    catch :exit do
      loop { menu_system(MAIN_MENU, method: true) }
    end
  end

  private

  def new_game
    @board = HangmanBoard.new(@word_list.new_word, game_length: @new_length)
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

  # Because there are three outcomes, rather than a ternary.
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
    Dir.mkdir(SAVE_DIR) unless Dir.exist?(SAVE_DIR)
    file_name = create_save_name
    File.open(file_name, 'w') { |file| @board.save_yaml(file) }
  end

  def create_save_name
    current_time = Time.new.strftime(TIME_FORMAT)
    "#{SAVE_DIR}#{current_time}#{FILE_TYPE}"
  end

  def load_game
    if Dir["#{SAVE_DIR}*#{FILE_TYPE}"].count < 1
      load_error
      return
    end
    file_name = select_save_file
    File.open(file_name, 'r') { |file| @board = HangmanBoard.load_yaml(file) }
    game_loop
  end

  def select_save_file
    saves = Dir["#{SAVE_DIR}*#{FILE_TYPE}"].sort
    file_index = menu_system(saves, number: true) - 1
    saves[file_index]
  end

  def options
    new_screen
    puts options_info
    @new_length = options_input
  end

  def how_to_play
    new_screen
    print play_rules
    pause_continue
  end

  def end_game(win: false, fail: false)
    if win
      puts '---------- YOU WIN ----------'
    elsif fail
      print 'Game Over! Hidden word was... ', @board.word, "\n"
    end
    # Because end game from hangman screen doesn't need a pause.
    pause_continue if win || fail
    throw :game_over
  end

  # This is here because I was using the word friendo originally to say goodbye.
  # "So long friendo", then wondered what the actual quote was.
  # Kind of an appropriate movie character for a game that's technically about hanging people.
  def exit_game
    print clear_screen, "\n"
    print "\"What business is it of yours where I'm from, friendo?\"", "\n"
    print '-- Anton Chigurh : No Country for Old Men', "\n\n"
    throw :exit
  end
end
