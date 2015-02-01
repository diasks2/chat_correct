require 'linguistics'

module ChatCorrect
  class Pluralization
    attr_reader :word_a, :word_b
    def initialize(word_a:, word_b:)
      @word_a = word_a
      @word_b = word_b
    end

    def pluralization_error?
      begin
        Linguistics.use(:en)
        word_a_plural = word_a.en.plural
        word_b_plural = word_b.en.plural
      rescue
        return false
      end
      word_a_plural.eql?(word_b) || word_b_plural.eql?(word_a)
    end
  end
end