# frozen_string_literal: true

# Get input from player(human)
module PlayerInput
  def menu_input(range, choice = '')
    puts
    loop do
      print "Enter (1 - #{range}) : "
      choice = gets.chomp.to_i
      break if (1..range).include?(choice)
    end
    choice - 1
  end
end
