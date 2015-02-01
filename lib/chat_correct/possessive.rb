module ChatCorrect
  class Possessive
    attr_reader :word_a, :word_b
    def initialize(word_a:, word_b:)
      @word_a = word_a
      @word_b = word_b
    end

    def possessive?
      check_for_possessive(word_a, word_b, "ƪ") ||
      check_for_possessive(word_b, word_a, "ƪ") ||
      check_for_possessive(word_a, word_b, "∮") ||
      check_for_possessive(word_b, word_a, "∮")
    end

    private

    def check_for_possessive(word_1, word_2, mark)
      word_1.include?(mark) &&
        word_1.partition(mark)[0].downcase.eql?(word_2.downcase) ||
        (word_1.partition(mark)[0].downcase.eql?(word_1.downcase[0...-1]) &&
        (word_1.partition(mark)[2].eql?('s') || word_1.partition(mark)[2].length < 3))
    end
  end
end