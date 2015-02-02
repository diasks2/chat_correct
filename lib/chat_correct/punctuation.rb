module ChatCorrect
  class Punctuation
    attr_reader :text
    def initialize(text:)
      @text = text
    end

    def is_punctuation?
      text.gsub(/[[:punct:]]/, '').eql?('') ||
      text.eql?('∫') ||
      text.eql?('∬') ||
      text.eql?('∯') ||
      text.eql?('∮') ||
      text.eql?('ƪ')
    end
  end
end
