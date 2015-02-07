module ChatCorrect
  class Verb
    attr_reader :word, :pos, :text
    def initialize(word:, pos:, text:)
      if word.eql?('am') || word.eql?('been') || word.eql?('are') || word.eql?('is') || word.eql?('was') || word.eql?('were')
        @word = 'be'
      else
        @word = word
      end
      @pos = pos
      @text = text
    end

    def verb_error?
      !word.eql?('a') && !word.eql?('an') &&
        !word.gsub(/[[:punct:]]/, '').eql?('') && !word.include?('ƪ') &&
        pos.downcase[0].eql?('v') && !word.eql?('to') && check_conjugated_word(word)
    end

    private

    def get_verb_infinitive(word)
      if word[-2..-1].eql?('ed')
        if word[-3..-3].eql?('i')
          word[0..-4] + 'y'
        else
          word[0..-3]
        end
      elsif word[-1].eql?('s')
        word[0..-2]
      else
        word
      end
    end

    def check_conjugated_word(word)
      tense = [:past, :present, :future]
      person = [:first, :second, :third]
      plurality = [:singular, :plural]
      aspect = [:habitual, :perfect, :perfective, :progressive, :prospective]
      mood = [:indicative, :imperative, :subjunctive]

      tense.each do |tense|
        person.each do |person|
          plurality.each do |plurality|
            aspect.each do |aspect|
              mood.each do |mood|
                if (mood.eql?(:imperative) && tense.eql?(:present) && person.eql?(:second)) || mood != :imperative
                  conjugated_word = get_verb_infinitive(word).verb.conjugate :tense => tense, :person => person, :plurality => plurality, :aspect => aspect, :mood => mood
                  if text.match(/#{conjugated_word}/) && conjugated_word.length > 0
                    return true
                    break
                  end
                end
              end
            end
          end
        end
      end
      return false
    end
  end
end