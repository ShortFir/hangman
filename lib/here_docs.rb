# frozen_string_literal: true

# How to play info
module HowToPlay
  private

  def how_to_play
    <<~'HOWTOPLAY'
      The word to guess is represented by a row of dashes,
      representing each letter of the word.
      In most variants, proper nouns, such as names, places, and brands,
      are not allowed.
      Slang words, sometimes referred to as informal or shortened words,
      are also not allowed.
      If the guessing player suggests a letter which occurs in the word,
      the other player writes it in all its correct positions.
      If the suggested letter does not occur in the word,
      the other player draws one element of a hanged man stick figure
      as a tally mark.

      The player guessing the word may, at any time, attempt to guess
      the whole word.
      If the word is correct, the game is over and the guesser wins.
      Otherwise, the other player may choose to penalize the guesser by
      adding an element to the diagram.
      On the other hand, if the other player makes enough incorrect guesses
      to allow his opponent to complete the diagram, the game is also over,
      this time with the guesser losing.
      However, the guesser can also win by guessing all the letters that
      appear in the word, thereby completing the word, before the diagram
      is completed.
    HOWTOPLAY
  end
end

# Pictures of HangedMen
module HangedMen
  def hanged10
    <<~'HANG10'
        ______
         |   |
         O   |
        /|\  |
        / \  |
             |
      ----------
    HANG10
  end

  def hanged9
    <<~'HANG9'
        ______
         |   |
         O   |
        /|\  |
        / \  |
             |
      ----------
    HANG9
  end

  def hanged8
    <<~'HANG8'
        ______
         |   |
         O   |
        /|\  |
        / \  |
             |
      ----------
    HANG8
  end

  def hanged7
    <<~'HANG7'
        ______
         |   |
         O   |
        /|\  |
        / \  |
             |
      ----------
    HANG7
  end

  def hanged6
    <<~'HANG6'
        ______
         |   |
         O   |
        /|\  |
        / \  |
             |
      ----------
    HANG6
  end

  def hanged5
    <<~'HANG5'
        ______
         |   |
         O   |
        /|\  |
        / \  |
             |
      ----------
    HANG5
  end

  def hanged4
    <<~'HANG4'
        ______
         |   |
             |
             |
             |
             |
      ----------
    HANG4
  end
end
