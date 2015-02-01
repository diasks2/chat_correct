module ChatCorrect
  class PunctuationMasqueradingAsSpellingError
    attr_reader :word_a, :word_b
    def initialize(word_a:, word_b:)
      @word_a = word_a
      @word_b = word_b
    end

    def exists?
      (word_a.include?('ƪ') || word_b.include?('ƪ')) &&
        word_a.delete("ƪ").eql?(word_b.delete("ƪ"))
    end
  end
end