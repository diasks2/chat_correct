require 'engtagger'

module ChatCorrect
  class CombineMultiWordVerbs
    attr_reader :sentence
    def initialize(sentence:)
      @sentence = sentence
    end

    def combine
      tgr = EngTagger.new
      tokens = ChatCorrect::Tokenize.new(text: sentence).tokenize
      sentence_tagged = tgr.add_tags(sentence).split
      words_to_delete = Array.new
      tokens.each_with_index do |word, index|
        case
        when ((word == "will" && tokens[index + 1] == "have") || (word == "would" && tokens[index + 1] == "have") || (word == "had" && tokens[index + 1] == "been")) && sentence_tagged[index + 2].to_s.partition('>').first[1..-1][0] == "v"
          tokens[index] = word + " " + tokens[index + 1] + " " + tokens[index + 2]
          words_to_delete << tokens[index + 1].to_s
          words_to_delete << tokens[index + 2].to_s
        when (word == "are" || word == "am" || word == "was" || word == "were" || word == "have" || word == "has" || word == "had" || word == "will" || word == "would" || word == "could" || word == "did" || word == "arenƪt" || word == "wasnƪt" || word == "werenƪt" || word == "havenƪt" || word == "hasnƪt" || word == "hadnƪt" || word == "wouldnƪt" || word == "couldnƪt" || word == "didnƪt") && (sentence_tagged[index + 1].to_s[1].to_s == "v") && (tokens[index - 1].exclude?(' ')) && (tokens[index + 1] != "had") #&& tokens[index - 1] != "had")
          tokens[index] = word + " " + tokens[index + 1]
          words_to_delete << tokens[index + 1].to_s
        when (word == "are" || word == "am" || word == "was" || word == "were" || word == "have" || word == "has" || word == "had" || word == "will" || word == "would" || word == "did" || word == "could") && (tokens[index + 1].to_s == "not") && (sentence_tagged[index + 2].to_s[1].to_s == "v")
          tokens[index] = word + " " + tokens[index + 1] + " " + tokens[index + 2]
          words_to_delete << tokens[index + 1].to_s
          words_to_delete << tokens[index + 2].to_s
        end
      end
    end
  end
end
