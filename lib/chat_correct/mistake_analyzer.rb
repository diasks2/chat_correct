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

  end
end