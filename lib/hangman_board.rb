# frozen_string_literal: false

require 'yaml'

require_relative 'here_docs'

# Display board, provide feedback
class HangmanBoard
  include HangedMen
  include HowToPlay

  GAME_LENGTH_MAX = 10
  GAME_LENGTH = 9

  attr_reader :word

  # Can use load_yaml as class method.
  def initialize(
    word,
    hidden = hide_word(word.length),
    wrong = '',
    alphabet = build_alphabet
  )
    @word = word.downcase
    @hidden = hidden
    @wrong = wrong
    @alphabet = alphabet
  end

  def display
    puts show_hangedman
    puts display_info
  end

  def display_alt
    puts show_hangedman
    print "\n", "Alphabet  : #{spaced_alphabet}", "\n"
    print "\n", "Word      : #{show(@hidden)}", "\n"
    print "\n", "Tries #{GAME_LENGTH - @wrong.length}/#{GAME_LENGTH} : #{show(@wrong)}", "\n"
  end

  def display_info
    space = GAME_LENGTH == GAME_LENGTH_MAX ? '  ' : ''
    <<~HANGEDINFO

      Alphabet #{space} : #{spaced_alphabet}

      Word #{space}     : #{show(@hidden)}

      Tries #{GAME_LENGTH - @wrong.length}/#{GAME_LENGTH} : #{show(@wrong)}

    HANGEDINFO
  end

  def compare_word(letter)
    return unless @alphabet.include?(letter)

    @alphabet.delete(letter)
    @word.include?(letter) ? correct_letter(letter) : wrong_letter(letter)
  end

  def win_or_fail
    if @word == @hidden then 'win'
    elsif @wrong.length == GAME_LENGTH then 'fail'
    end
  end

  def save_yaml(file)
    YAML.dump(
      {
        word: @word,
        hidden: @hidden,
        wrong: @wrong,
        alphabet: @alphabet
      }, file
    )
  end

  def self.load_yaml(file)
    data = YAML.load_file(file)
    new(
      @word = data[:word],
      @hidden = data[:hidden],
      @wrong =  data[:wrong],
      @alphabet = data[:alphabet]
    )
  end

  private

  def show_hangedman
    hangman = "hanged#{(GAME_LENGTH_MAX - GAME_LENGTH) + @wrong.length}"
    send(hangman)
  end

  def correct_letter(letter)
    @word.split('').each_with_index do |char, index|
      if char == letter
        @hidden.slice!(index)
        @hidden.insert(index, letter)
      end
    end
  end

  def wrong_letter(letter)
    @wrong += letter
  end

  def show(word)
    word.split('').each_with_object('') { |char, s| s << "#{char} " }
    # puts
  end

  def hide_word(length, hidden = '')
    length.times { hidden << '_' }
    hidden
  end

  def spaced_alphabet
    @alphabet.each_with_object('') { |char, s| s << "#{char} " }
  end

  def build_alphabet
    ('a'..'z').to_a
  end
end
