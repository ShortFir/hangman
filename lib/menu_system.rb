# frozen_string_literal: true

# Menu system
module MenuSystem
  JUSTIFY = 1

  private

  # Return send(method) or integer
  def menu_system(menu, method: false, number: false)
    display_menu(menu, method, number)
    choice = menu_input(menu.length) if method || number
    return choice if number

    send(string_to_method(menu[choice - 1])) if method
  end

  def display_menu(menu, method, number)
    new_screen if method || number
    display_options(menu)
  end

  def display_options(options)
    options.each_with_index do |item, index|
      print "#{(index + 1).to_s.rjust(JUSTIFY)}: #{item}", "\n"
    end
  end

  def string_to_method(menu)
    menu.downcase.split(' ').join('_')
  end

  def save_message
    new_screen
    @board.display
    puts 'Game Saved. Exiting...'
    pause_continue
    end_game
  end

  def load_error
    puts "\n\n", 'Save folder empty.'
    pause_continue
  end

  def options_info
    <<~OPSINFO
      Change the amount of tries.
      ───────────────────────────
      Min     : #{HangmanBoard::GAME_LENGTH_MIN}
      Max     : #{HangmanBoard::GAME_LENGTH_MAX}
      Default : #{HangmanBoard::GAME_LENGTH_DEFAULT}
      ───────────────────────────
      Current : #{@new_length}

    OPSINFO
  end

  def new_screen
    print clear_screen, logo_four, "\n"
  end

  # https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
  # ESC    = \e
  # ESC[H  = Moves cursor to home position (0,0)
  # ESC[2J = Clears entire screen
  def clear_screen
    "\e[H\e[2J"
  end
end
