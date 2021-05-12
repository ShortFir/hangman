# frozen_string_literal: true

# Get input from player(human)
module PlayerInput
  private

  # similar methods, but different enough
  def menu_input(range, choice = '')
    # puts
    print "Enter (1 - #{range}) : "
    loop do
      choice = input_char.to_i
      break if (1..range).include?(choice)
    end
    choice - 1
  end

  def hang_input(choice = '')
    print 'Guess A Letter : '
    loop do
      choice = input_char # $stdin.getch
      break if choice =~ /[12a-zA-Z]/
    end
    choice.downcase
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
