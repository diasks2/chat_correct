module ChatCorrect
  class Time
    attr_reader :text
    def initialize(text:)
      @text = text
    end

    def is_time?
      text.include?(':') &&
        text.to_s.partition(':').last[0].gsub(/\A\d+/, '').eql?('')  &&
        text.to_s.partition(':').first[-1].gsub(/\A\d+/, '').eql?('')
    end
  end
end
