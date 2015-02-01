module ChatCorrect
  class Capitalization
    attr_reader :word_a, :word_b
    def initialize(word_a:, word_b:)
      @word_a = word_a
      @word_b = word_b
    end

    def capitalization_error?
      word_a.downcase.eql?(word_b.downcase) && (word_a != word_b)
    end
  end
end