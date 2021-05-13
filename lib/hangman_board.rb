# frozen_string_literal: false

require 'yaml'

require_relative 'here_docs'

# Display board, provide feedback
class HangmanBoard
  include HereDocs

  GAME_LENGTH = 6

  # attr_accessor :word, :hidden, :wrong, :alphabet
  attr_reader :word

  def initialize(word)
    @word = word.downcase
    @hidden = hide_word(word.length)
    @wrong = ''
    @alphabet = build_alphabet
  end

  # countdown fails left
  def display
    puts hanged_full
    print "\n", 'Alphabet  : '
    print_alphabet
    # print "\n", 'Secret    : '
    # show(@word)
    print "\n", 'Word      : '
    show(@hidden)
    print "\n", "Fails (#{GAME_LENGTH}) : "
    show(@wrong)
    print "\n"
  end

  def compare_word(letter)
    return unless @alphabet.include?(letter)

    @alphabet.delete(letter)
    @word.include?(letter) ? correct_letter(letter) : wrong_letter(letter)
  end

  def game_over?
    @wrong.length == GAME_LENGTH || @word == @hidden
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

  def load_yaml(file)
    data = YAML.load_file(file)
    @word = data[:word]
    @hidden = data[:hidden]
    @wrong =  data[:wrong]
    @alphabet = data[:alphabet]
  end

  private

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
    word.split('').each { |char| print "#{char} " }
    puts
  end

  def hide_word(length, hidden = '')
    length.times { hidden << '_' }
    hidden
  end

  def print_alphabet
    @alphabet.each { |char| print "#{char} " }
    puts
  end

  def build_alphabet
    ('a'..'z').to_a
  end
end
