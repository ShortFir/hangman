# frozen_string_literal: true

# Get input from player(human)
module PlayerInput
  private

  # make it universal? add print, range, optional?
  def menu_input(range, choice = '')
    puts
    loop do
      print "Enter (1 - #{range}) : "
      choice = gets.chomp.to_i
      break if (1..range).include?(choice)
    end
    choice - 1
  end

  def hang_input(choice = '')
    puts
    loop do
      print 'Enter a letter : '
      choice = gets.chomp
      break if choice =~ /[a-zA-Z]/
    end
    choice.downcase
  end
end
