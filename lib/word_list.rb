# frozen_string_literal: true

# Open file and select words
class WordList
  WORD_FILE = 'doc/5desk.txt'
  MIN_WORD = 5
  MAX_WORD = 12
  def initialize
    @dictionary = trim_list(File.readlines(WORD_FILE))
  end

  def new_word
    @dictionary.sample
  end

  private

  def trim_list(word_array)
    word_array.each(&:strip!)
    word_array.select do |word|
      word.length >= MIN_WORD && word.length <= MAX_WORD
    end
  end
end
