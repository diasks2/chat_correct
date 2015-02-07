module ChatCorrect
  class Possessive
    attr_reader :token_a, :token_b
    def initialize(token_a:, token_b:)
      @token_a = token_a
      @token_b = token_b
    end

    def possessive?
      check_for_possessive(token_a, token_b, "ƪ") ||
      check_for_possessive(token_b, token_a, "ƪ") ||
      check_for_possessive(token_a, token_b, "∮") ||
      check_for_possessive(token_b, token_a, "∮")
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
