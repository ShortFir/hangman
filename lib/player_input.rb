# frozen_string_literal: true

# Get input from player(human)
module PlayerInput
  private

  def menu_input(range, choice = '')
    print "\n", "Enter (1 - #{range}) : "
    loop do
      choice = input_char.to_i
      break if (1..range).include?(choice)
    end
    choice - 1
  end

  def hang_input(choice = '')
    print "\n", 'Guess A Letter : '
    loop do
      choice = input_char
      break if choice =~ /[12a-z]/
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
  # Doesn't require io/console
  def input_char
    state = `stty -g`
    `stty raw -echo -icanon isig`
    $stdin.getc # .chr
  ensure
    `stty #{state}`
  end
end
