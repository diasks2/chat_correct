module ChatCorrect
  class Correct
    attr_reader :original_sentence, :corrected_sentence
    def initialize(original_sentence:, corrected_sentence:)
      @original_sentence = original_sentence
      @corrected_sentence = corrected_sentence
    end

    def correct
      []
    end

    def number_of_mistakes
      []
    end

    def mistake_report
      []
    end
  end
end