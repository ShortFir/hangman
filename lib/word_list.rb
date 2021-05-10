# frozen_string_literal: true

# Open file and select words
# Object
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

  def trim_list(word_file)
    word_file.each(&:strip!)
    word_file.select do |word|
      word.length >= MIN_WORD && word.length <= MAX_WORD
    end
  end
end
