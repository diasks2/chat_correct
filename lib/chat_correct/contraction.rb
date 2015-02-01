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
    attr_reader :word_a, :word_b, :contraction
    def initialize(word_a:, word_b:, contraction:)
      return false if word_a.nil? || contraction.nil?
      @word_a = word_a.downcase
      word_b ? @word_b = word_b.downcase : @word_b = word_b
      @contraction = contraction.downcase.gsub(/ƪ/, "'")
    end

    def contraction?
      !word_a.nil? && !contraction.nil? &&
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
      word_b.eql?('not') && (NOT_CONTRACTION[word_a].eql?(contraction) ||
        (contraction.partition("n't")[0].eql?(word_a)) &&
        contraction.partition("n't")[2].empty?)
    end

    def is_an_irregular_contraction?
      IRREGULAR_CONTRACTION[[word_a, word_b]].eql?(contraction)
    end

    def is_an_us_contraction?
      word_b.eql?('us') && contraction.partition("'s")[0].eql?(word_a) &&
      word_a.eql?('let') && contraction.partition("'s")[2].empty?
    end

    def is_an_am_contraction?
      word_b.eql?("am") && contraction.partition("'m")[0].eql?(word_a) &&
      word_a.eql?('i') && contraction.partition("'m")[2].empty?
    end

    def is_an_are_contraction?
      word_b.eql?('are') && contraction.partition("'re")[0].eql?(word_a) &&
      contraction.partition("'re")[2].empty?
    end

    def is_an_is_does_has_contraction?
      (word_b.eql?('is') || word_b.eql?('does') || word_b.eql?('has')) &&
        contraction.partition("'s")[0].eql?(word_a) && contraction.partition("'s")[2].empty?
    end

    def is_a_have_contraction?
      word_b.eql?('have') && contraction.partition("'ve")[0].eql?(word_a) &&
        contraction.partition("'ve")[2].empty?
    end

    def is_a_had_did_would_contraction?
      (word_b.eql?('had') || word_b.eql?('did') || word_b.eql?('would')) &&
        contraction.partition("'d")[0].eql?(word_a) &&
        contraction.partition("'d")[2].empty?
    end

    def is_a_will_contraction?
      word_b.eql?('will') && contraction.partition("'ll")[0].eql?(word_a) &&
        contraction.partition("'ll")[2].empty?
    end

    def is_an_of_contraction?
      word_a.eql?('of') && (contraction.eql?("o'") ||
        contraction.partition("o' ")[-1].eql?(word_b))
    end

    def is_an_it_contraction?
      word_a.eql?('it') && contraction.partition("'t")[-1].eql?(word_b)
    end

    def is_a_them_contraction?
      word_b.eql?('them') && contraction.partition(" 'em")[0].eql?(word_a)
    end
  end
end