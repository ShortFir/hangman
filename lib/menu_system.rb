# frozen_string_literal: true

require_relative 'here_docs'
require_relative 'logo'
require_relative 'player_input'

# Menu system
module MenuSystem
  include HereDocs
  include Logo
  include PlayerInput

  JUSTIFY = 1

  private

  def menu_system(menu)
    display_menu(menu)
    choice = menu_input(menu.length)
    send(string_to_method(menu[choice]))
  end

  def display_menu(menu)
    new_screen
    display_options(menu)
  end

  def display_options(options)
    options.each_with_index do |item, index|
      puts "#{(index + 1).to_s.rjust(JUSTIFY)}: #{item}"
    end
  end

  def string_to_method(menu)
    menu.downcase.split(' ').join('_')
  end

  def new_screen
    print clear_screen, logo_four, "\n"
  end

  def clear_screen
    "\e[H\e[2J"
  end
end
