module ChatCorrect
  class PunctuationMasqueradingAsSpellingError
    attr_reader :token_a, :token_b
    def initialize(token_a:, token_b:)
      @token_a = token_a
      @token_b = token_b
    end

    def exists?
      (token_a.include?('ƪ') || token_b.include?('ƪ')) &&
        token_a.delete("ƪ").eql?(token_b.delete("ƪ"))
    end
  end
end
