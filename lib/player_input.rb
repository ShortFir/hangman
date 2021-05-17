# frozen_string_literal: true

require 'io/console'

# Get input from player(human)
module PlayerInput
  private

  def menu_input(range, choice = '')
    print "\n", "Enter (1 - #{range}) : "
    loop do
      choice = input_char.to_i
      break if (1..range).include?(choice)
    end
    choice
  end

  def hang_input(choice = '')
    print "\n", 'Guess A Letter : '
    loop do
      choice = input_char
      break if choice =~ /[12a-z]/
    end
    choice
  end

  def options_input(choice = '')
    # Save cursor position.
    print 'Enter new amount :', "\e[s"
    loop do
      break if (1..10).include?(choice = gets.chomp.to_i)

      # Return to cursor save. Clear from cursor to end of line.
      print "\e[u\e[0K"
    end
    choice
  end

  def pause_continue
    print "\n", 'Press spacebar to continue...'
    until input_char == ' '
    end
  end

  # Copied from...
  # https://stackoverflow.com/questions/174933/how-to-get-a-single-character-without-pressing-enter
  #
  # https://man7.org/linux/man-pages/man1/stty.1.html
  # stty    --- change and print terminal line settings
  # stty -g --- saves current settings
  # raw     --- disable most stuff (including icanon, isig)
  # -echo   --- disable echo input characters
  #           - so no characters appear when typing
  # -icanon --- disable special characters: erase, kill, werase, rprnt
  # isig    --- enable interrupt, quit, and suspend special characters
  #           - So Ctrl-c still works to interrupt program

  # https://superuser.com/questions/640338/how-to-reset-a-broken-tty/640341
  # Reset terminal. Just in case.
  # Run echo ^v^o. That is echo and then Ctrl-v and then Ctrl-o, Enter.

  # I wanted a method of entering a letter without having to press enter aswell
  # This way works. Allows Ctrl-c. But gives a warning in replit.
  def input_char
    state = `stty -g`
    `stty raw -echo isig`
    $stdin.getc.chr
  ensure
    # Loads stty saved state
    `stty #{state}`
  end
end

# Doesn't allow Ctrl-c interrupt. No replit warning.
def input_char_no_ctrlc
  $stdin.getch
end
