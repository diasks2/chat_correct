module ChatCorrect
  class CombineMultiWordVerbs
    TOKEN_ARRAY = ['are', 'am', 'was', 'were', 'have', 'has', 'had', 'will', 'would', 'could', 'did', 'arenƪt', 'wasnƪt', 'werenƪt', 'havenƪt', 'hasnƪt', 'hadnƪt', 'wouldnƪt', 'couldnƪt', 'didnƪt']
    TOKEN_ARRAY_2 = ['are', 'am', 'was', 'were', 'have', 'has', 'had', 'will', 'would', 'did', 'could']
    attr_reader :text, :tgr
    def initialize(text:, tgr:)
      @text = text
      @tgr = tgr
    end

    def combine
      tokens = ChatCorrect::Tokenize.new(text: text).tokenize
      sentence_tagged = tgr.add_tags(text).split
      tokens_to_delete = []
      tokens.each_with_index do |token, index|
        case
        when ((token.eql?('will') && tokens[index + 1].eql?('have')) || (token.eql?('would') && tokens[index + 1].eql?('have')) || (token.eql?('had') && tokens[index + 1].eql?('been'))) &&
          sentence_tagged[index + 2].to_s.partition('>').first[1..-1][0].eql?('v')
            tokens[index] = token + ' ' + tokens[index + 1] + ' ' + tokens[index + 2]
            tokens_to_delete << tokens[index + 1].to_s
            tokens_to_delete << tokens[index + 2].to_s
        when TOKEN_ARRAY_2.include?(token) &&
          tokens[index + 1].to_s.eql?('not') &&
          sentence_tagged[index + 2].to_s[1].to_s.eql?('v')
            tokens[index] = token + ' ' + tokens[index + 1] + ' ' + tokens[index + 2]
            tokens_to_delete << tokens[index + 1].to_s
            tokens_to_delete << tokens[index + 2].to_s
        when TOKEN_ARRAY.include?(token) &&
          (sentence_tagged[index + 1].to_s[1].to_s.eql?('v') ||
          sentence_tagged[index + 1].to_s[1..2].to_s.eql?('rb')) &&
          tokens[index - 1].exclude?(' ') &&
          tokens[index + 1] != 'had'
            tokens[index] = token + ' ' + tokens[index + 1]
            tokens_to_delete << tokens[index + 1].to_s
        end
      end
      delete_tokens_from_array(tokens, tokens_to_delete)
    end

    private

    def delete_tokens_from_array(tokens, array)
      array.each do |token_to_delete|
        tokens.delete(token_to_delete) if tokens.include?(token_to_delete)
      end
      tokens
    end
  end
end
