module ChatCorrect
  class Contraction
    NOT_CONTRACTION = {
      'am' => "ain't",
      'do' => "don't",
      'will' => "won't",
      'shall' => "shan't",
      'is' => "isn't"
    }
    IRREGULAR_CONTRACTION = {
      ['is', 'not'] => "ain't",
      ['madam', nil] => "ma'am",
      ['never-do-well', nil] => "ne'er-do-well",
      ['cat-of-nine-tails', nil] => "cat-o'-nine-tails",
      ['jack-of-the-lantern', nil] => "jack-o'-lantern",
      ['will-of-the-wisp', nil] => "will-o'-the-wisp"
    }
    attr_reader :token_a, :token_b, :contraction
    def initialize(token_a:, token_b:, contraction:)
      return false if token_a.nil? || contraction.nil?
      @token_a = token_a.downcase
      token_b ? @token_b = token_b.downcase : @token_b = token_b
      @contraction = contraction.downcase.gsub(/ƪ/, "'")
    end

    def contraction?
      !token_a.nil? && !contraction.nil? &&
      (is_a_not_contraction? ||
      is_an_irregular_contraction? ||
      is_an_us_contraction? ||
      is_an_am_contraction? ||
      is_an_are_contraction? ||
      is_an_is_does_has_contraction? ||
      is_a_have_contraction? ||
      is_a_had_did_would_contraction? ||
      is_a_will_contraction? ||
      is_an_of_contraction? ||
      is_an_it_contraction? ||
      is_a_them_contraction?)
    end

    private

    def is_a_not_contraction?
      token_b.eql?('not') && (NOT_CONTRACTION[token_a].eql?(contraction) ||
        (contraction.partition("n't")[0].eql?(token_a)) &&
        contraction.partition("n't")[2].empty?)
    end

    def is_an_irregular_contraction?
      IRREGULAR_CONTRACTION[[token_a, token_b]].eql?(contraction)
    end

    def is_an_us_contraction?
      token_b.eql?('us') && contraction.partition("'s")[0].eql?(token_a) &&
      token_a.eql?('let') && contraction.partition("'s")[2].empty?
    end

    def is_an_am_contraction?
      token_b.eql?("am") && contraction.partition("'m")[0].eql?(token_a) &&
      token_a.eql?('i') && contraction.partition("'m")[2].empty?
    end

    def is_an_are_contraction?
      token_b.eql?('are') && contraction.partition("'re")[0].eql?(token_a) &&
      contraction.partition("'re")[2].empty?
    end

    def is_an_is_does_has_contraction?
      (token_b.eql?('is') || token_b.eql?('does') || token_b.eql?('has')) &&
        contraction.partition("'s")[0].eql?(token_a) && contraction.partition("'s")[2].empty?
    end

    def is_a_have_contraction?
      token_b.eql?('have') && contraction.partition("'ve")[0].eql?(token_a) &&
        contraction.partition("'ve")[2].empty?
    end

    def is_a_had_did_would_contraction?
      (token_b.eql?('had') || token_b.eql?('did') || token_b.eql?('would')) &&
        contraction.partition("'d")[0].eql?(token_a) &&
        contraction.partition("'d")[2].empty?
    end

    def is_a_will_contraction?
      token_b.eql?('will') && contraction.partition("'ll")[0].eql?(token_a) &&
        contraction.partition("'ll")[2].empty?
    end

    def is_an_of_contraction?
      token_a.eql?('of') && (contraction.eql?("o'") ||
        contraction.partition("o' ")[-1].eql?(token_b))
    end

    def is_an_it_contraction?
      token_a.eql?('it') && contraction.partition("'t")[-1].eql?(token_b)
    end

    def is_a_them_contraction?
      token_b.eql?('them') && contraction.partition(" 'em")[0].eql?(token_a)
    end
  end
end
