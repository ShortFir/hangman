# frozen_string_literal: true

# Save and load files. Hangman_board handles itself.
module SaveLoad
  private

  SAVE_DIR = 'save/'
  FILE_TYPE = '.yaml'
  TIME_FORMAT = '%Y-%m-%d--%H:%M:%S'

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
    name_for_menu = saves.each_with_object([]) do |file, a|
      a << file.delete_prefix(SAVE_DIR).delete_suffix(FILE_TYPE)
    end
    file_index = menu_system(name_for_menu, number: true) - 1
    saves[file_index]
  end
end
