module ChatCorrect
  class MistakeAnalyzer
    attr_reader :original, :corrected
    def initialize(original:, corrected:)
      @original = original
      @corrected = corrected
    end

    def no_mistake?
      original['token'].eql?(corrected['token'])
    end

    def verb_mistake?
      ChatCorrect::CommonVerbMistake.new(token_a: corrected['token'], token_b: original['token']).exists? ||
      original['multiple_words'] ||
      corrected['multiple_words'] ||
      ChatCorrect::Verb.new(word: original['token'], pos: corrected['pos_tag'], text: corrected['token']).verb_error?
    end

    def capitalization_mistake?
      ChatCorrect::Capitalization.new(token_a: corrected['token'], token_b: original['token']).capitalization_error?
    end

    def punctuation_mistake?
      (corrected['punctuation'] && original['punctuation']) ||
      (ChatCorrect::Spelling.new(token_a: corrected['token'], token_b: original['token']).spelling_error? &&
      ChatCorrect::PunctuationMasqueradingAsSpellingError.new(token_a: corrected['token'], token_b: original['token']).exists? &&
      !ChatCorrect::Possessive.new(token_a: original['token'], token_b: corrected['token']).possessive?)
    end

    def unnecessary_word_missing_punctuation_mistake?
      corrected['punctuation'] && !original['punctuation']
    end

    def spelling_mistake?
      ChatCorrect::Spelling.new(token_a: corrected['token'], token_b: original['token']).spelling_error? &&
      !ChatCorrect::PunctuationMasqueradingAsSpellingError.new(token_a: corrected['token'], token_b: original['token']).exists?
    end
  end
end
