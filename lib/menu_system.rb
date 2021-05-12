# frozen_string_literal: true

# Menu system
module MenuSystem
  JUSTIFY = 1

  private

  # rubocop:disable Style/OptionalBooleanParameter
  def menu_system(menu, extras = false)
    display_menu(menu, extras)
    return unless extras

    choice = menu_input(menu.length)
    send(string_to_method(menu[choice]))
  end
  # rubocop:enable Style/OptionalBooleanParameter

  def display_menu(menu, extras)
    new_screen if extras
    display_options(menu)
  end

  def display_options(options)
    options.each_with_index do |item, index|
      puts "#{(index + 1).to_s.rjust(JUSTIFY)}: #{item}"
    end
    puts
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
