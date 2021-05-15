# frozen_string_literal: true

# Open file and select words
class WordList
  WORD_FILE = 'doc/5desk.txt'
  MIN_WORD = 5
  MAX_WORD = 12

  def initialize
    @word_list = trim_list(File.readlines(WORD_FILE))
  end

  def new_word
    @word_list.sample
  end

  private

  # String first because of leading white space.
  def trim_list(word_file)
    word_file.each(&:strip!).each(&:downcase!)
    word_file.select do |word|
      word.length >= MIN_WORD && word.length <= MAX_WORD
    end
  end
end
