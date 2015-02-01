require 'levenshtein'

module ChatCorrect
  class Spelling
    WORD_CHOICE = ["the", "that", "this", "on", "at", "in", "an", "it", "if", "of", "to"]
    attr_reader :word_a, :word_b
    def initialize(word_a:, word_b:)
      @word_a = word_a
      @word_b = word_b
    end

    def spelling_error?
      word_a.length > 1 && word_b.length > 1 &&
      word_a.gsub(/[[:punct:]]/, "") != "" && word_b.gsub(/[[:punct:]]/, "") != "" &&
      !(word_a[0] != word_b[0] && Levenshtein.distance(word_a.downcase, word_b.downcase) > 1) &&
      !(WORD_CHOICE.include?(word_a.downcase) && WORD_CHOICE.include?(word_b.downcase)) &&
      Levenshtein.distance(word_a.downcase, word_b.downcase) < 3
    end
  end
end