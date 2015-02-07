module ChatCorrect
  class Pluralization
    attr_reader :token_a, :token_b
    def initialize(token_a:, token_b:)
      @token_a = token_a
      @token_b = token_b
    end

    def pluralization_error?
      begin
        token_a_plural = token_a.en.plural
        token_b_plural = token_b.en.plural
      rescue
        return false
      end
      token_a_plural.eql?(token_b) || token_b_plural.eql?(token_a)
    end
  end
end
