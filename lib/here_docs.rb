# frozen_string_literal: true

# How to play information.
module HowToPlay
  private

  def play_rules
    <<~'HOWTOPLAY'
      A word to guess is represented by a row of
      dashes, representing each letter of the word.

      If the guessing player types a letter which
      occurs in the word, the computer writes it in
      all its correct positions.

      If the suggested letter does not occur in the
      word, the computer draws one element of a hanged
      man stick figure as a tally mark.

      If the guesser makes enough incorrect guesses to
      allow the computer to complete the diagram, the
      game is over.

      The guesser can win by guessing all the letters
      that appear in the word, thereby completing the
      word, before the hangedman diagram is completed.
    HOWTOPLAY
  end

  # From the Wikipedia article.
  def play_rules_orig
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

# Progressing diagram of HangedMen.
# rubocop:disable Metrics/ModuleLength
module HangedMen
  private

  def hanged10
    <<~'HANG10'
                    _____
                    |   |
                    o   |
                   /O\  |
                   / \  |
                ________|_
      ---------/----------\---------
    HANG10
  end

  def hanged9
    <<~'HANG9'
                    _____
                    |   |
                    o   |
                   /O\  |
                   /    |
                ________|_
      ---------/----------\---------
    HANG9
  end

  def hanged8
    <<~'HANG8'
                    _____
                    |   |
                    o   |
                   /O\  |
                        |
                ________|_
      ---------/----------\---------
    HANG8
  end

  def hanged7
    <<~'HANG7'
                    _____
                    |   |
                    o   |
                   /O   |
                        |
                ________|_
      ---------/----------\---------
    HANG7
  end

  def hanged6
    <<~'HANG6'
                    _____
                    |   |
                    o   |
                    O   |
                        |
                ________|_
      ---------/----------\---------
    HANG6
  end

  def hanged5
    <<~'HANG5'
                    _____
                    |   |
                    o   |
                        |
                        |
                ________|_
      ---------/----------\---------
    HANG5
  end

  def hanged4
    <<~'HANG4'
                    _____
                    |   |
                        |
                        |
                        |
                ________|_
      ---------/----------\---------
    HANG4
  end

  def hanged3
    <<~'HANG3'
                    _____
                        |
                        |
                        |
                        |
                ________|_
      ---------/----------\---------
    HANG3
  end

  def hanged2
    <<~'HANG2'

                        |
                        |
                        |
                        |
                ________|_
      ---------/----------\---------
    HANG2
  end

  def hanged1
    <<~'HANG1'





                __________
      ---------/----------\---------
    HANG1
  end

  def hanged0
    <<~'HANG0'






      ------------------------------
    HANG0
  end
end
# rubocop:enable Metrics/ModuleLength
