module ChatCorrect
  class Spelling
    WORD_CHOICE = ["the", "that", "this", "on", "at", "in", "an", "it", "if", "of", "to"]
    attr_reader :token_a, :token_b
    def initialize(token_a:, token_b:)
      @token_a = token_a
      @token_b = token_b
    end

    def spelling_error?
      token_a.length > 1 && token_b.length > 1 &&
      token_a.gsub(/[[:punct:]]/, "") != "" && token_b.gsub(/[[:punct:]]/, "") != "" &&
      !(token_a[0] != token_b[0] && Text::Levenshtein.distance(token_a.downcase, token_b.downcase) > 1) &&
      !(WORD_CHOICE.include?(token_a.downcase) && WORD_CHOICE.include?(token_b.downcase)) &&
      Text::Levenshtein.distance(token_a.downcase, token_b.downcase) < 3 && token_a.downcase != token_b.downcase
    end
  end
end
