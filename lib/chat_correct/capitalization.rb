module ChatCorrect
  class Capitalization
    attr_reader :token_a, :token_b
    def initialize(token_a:, token_b:)
      @token_a = token_a
      @token_b = token_b
    end

    def capitalization_error?
      token_a.downcase.eql?(token_b.downcase) && (token_a != token_b)
    end
  end
end