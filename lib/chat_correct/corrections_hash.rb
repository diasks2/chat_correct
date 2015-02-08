module ChatCorrect
  class CorrectionsHash
    PUNCTUATION_SYMBOLS = ['∯', '∬', '∫', '∮']
    attr_reader :original_sentence_info_hash, :corrected_sentence_info_hash
    def initialize(original_sentence_info_hash:, corrected_sentence_info_hash:)
      @original_sentence_info_hash = original_sentence_info_hash
      @corrected_sentence_info_hash = corrected_sentence_info_hash
      @combined_hash = {}
      @final_matched_array = []
    end

    def create
      @j = 0
      @i = 0
      while @i < corrected_sentence_info_hash.length do
        @correct_info = {}
        @mistake_info = {}
        if @j >= original_sentence_info_hash.length
          if corrected_sentence_info_hash[@i]['token'].gsub(/[[:punct:]]/, '').eql?('')
            @correct_info[corrected_sentence_info_hash[@i]['token']] = 'missing_punctuation_correction'
            @combined_hash[@combined_hash.length] = @correct_info
          else
            @correct_info[corrected_sentence_info_hash[@i]['token']] = 'missing_word_mistake'
            @combined_hash[@combined_hash.length] = @correct_info
          end
          @i +=1
        else
          case
          when original_sentence_info_hash[@j]['match_id'].to_s[0].eql?('c') && original_sentence_info_hash[@j]['match_id'].to_s[1..original_sentence_info_hash[@j]['match_id'].to_s.length].eql?(@i.to_s)
            matching_ids_error_analysis(original_sentence_info_hash[@j], corrected_sentence_info_hash[@i])
          when original_sentence_info_hash[@j]['match_id'].to_s[0].eql?('c') && original_sentence_info_hash[@j]['match_id'].to_s[1..original_sentence_info_hash[@j]['match_id'].to_s.length] != @i.to_s
            unmatched_ids_error_analysis
          when original_sentence_info_hash[@j]['match_id'].to_s[0].eql?('s')
            special_error_analysis
          when original_sentence_info_hash[@j]['match_id'].to_s[0].eql?('d')
            duplicate_error_analysis
          end
        end
      end
      original_sentence_info_hash.each do |k, v|
        if v['match_id'].to_s[0].eql?('s') && !@final_matched_array.include?(v['match_id'].to_s)
          if v['token'].gsub(/[[:punct:]]/, '').eql?('') || PUNCTUATION_SYMBOLS.include?(v['token'])
            @mistake_info = {}
            @mistake_info[v['token']] = 'punctuation_mistake'
            @combined_hash[@combined_hash.length] = @mistake_info
            @final_matched_array << v['match_id'].to_s
          else
            @mistake_info = {}
            @mistake_info[v['token']] = 'unnecessary_word_mistake'
            @combined_hash[@combined_hash.length] = @mistake_info
            @final_matched_array << v['match_id'].to_s
          end
        end
      end
      @combined_hash.each do |k, v|
        v.each do |k1, v1|
          next unless k1.include?('ƪ')
          case
          when v1.include?('missing_word_mistake') && @combined_hash[k - 1].to_s.include?('unnecessary_word_mistake') && @combined_hash[k - 2].to_s.include?('unnecessary_word_mistake')
            next if !ChatCorrect::Contraction.new(token_a: @combined_hash[k - 2].key('unnecessary_word_mistake').to_s, token_b: @combined_hash[k - 1].key('unnecessary_word_mistake').to_s, contraction: k1.to_s).contraction?
            @combined_hash[k][k1] = 'stylistic_choice_correction'
            @combined_hash[k - 1][@combined_hash[k - 1].key('unnecessary_word_mistake')] = 'stylistic_choice'
            @combined_hash[k - 2][@combined_hash[k - 2].key('unnecessary_word_mistake')] = 'stylistic_choice'
          when v1.include?('missing_word_mistake') && @combined_hash[k + 1].to_s.include?('unnecessary_word_mistake') && @combined_hash[k + 2].to_s.include?('unnecessary_word_mistake')
            next if !ChatCorrect::Contraction.new(token_a: @combined_hash[k + 2].key('unnecessary_word_mistake').to_s, token_b: @combined_hash[k + 1].key('unnecessary_word_mistake').to_s, contraction: k1.to_s).contraction?
            @combined_hash[k][k1] = 'stylistic_choice_correction'
            @combined_hash[k + 1][@combined_hash[k + 1].key('unnecessary_word_mistake')] = 'stylistic_choice'
            @combined_hash[k + 2][@combined_hash[k + 2].key('unnecessary_word_mistake')] = 'stylistic_choice'
          when v1.include?('unnecessary_word_mistake') && @combined_hash[k + 1].to_s.include?('missing_word_mistake') && @combined_hash[k + 2].to_s.include?('missing_word_mistake')
            next if !ChatCorrect::Contraction.new(token_a: @combined_hash[k + 1].key('missing_word_mistake').to_s, token_b: @combined_hash[k + 2].key('missing_word_mistake').to_s,  contraction: k1.to_s).contraction?
            @combined_hash[k][k1] = 'stylistic_choice'
            @combined_hash[k + 1][@combined_hash[k + 1].key('missing_word_mistake')] = 'stylistic_choice_correction'
            @combined_hash[k + 2][@combined_hash[k + 2].key('missing_word_mistake')] = 'stylistic_choice_correction'
          when v1.include?('unnecessary_word_mistake') && @combined_hash[k - 1].to_s.include?('missing_word_mistake') && @combined_hash[k - 2].to_s.include?('missing_word_mistake')
            next if !ChatCorrect::Contraction.new(token_a: @combined_hash[k - 2].key('missing_word_mistake').to_s, token_b: @combined_hash[k - 1].key('missing_word_mistake').to_s,  contraction: k1.to_s).contraction?
            @combined_hash[k][k1] = 'stylistic_choice'
            @combined_hash[k - 1][@combined_hash[k - 1].key('missing_word_mistake')] = 'stylistic_choice_correction'
            @combined_hash[k - 2][@combined_hash[k - 2].key('missing_word_mistake')] = 'stylistic_choice_correction'
          when v1.include?('verb_mistake') && @combined_hash[k + 1].to_s.include?('verb_mistake_correction')
            next if !ChatCorrect::Contraction.new(token_a: @combined_hash[k + 1].key('verb_mistake_correction').to_s.split[0].to_s, token_b: @combined_hash[k + 1].key('verb_mistake_correction').to_s.split[1].to_s,  contraction: k1.gsub(/ƪ/o, "'").split[0].to_s.gsub(/'/o, 'ƪ')).contraction?
            @combined_hash[k][k1] = 'stylistic_choice'
            @combined_hash[k + 1][@combined_hash[k + 1].key('verb_mistake_correction')] = 'stylistic_choice_correction'
          when v1.include?('verb_mistake_correction') && @combined_hash[k - 1].to_s.include?('verb_mistake')
            next if !ChatCorrect::Contraction.new(token_a: @combined_hash[k - 1].key('verb_mistake').to_s.split[0].to_s, token_b: @combined_hash[k - 1].key('verb_mistake').to_s.split[1].to_s,  contraction: k1.gsub(/ƪ/o, "'").split[0].to_s.gsub(/'/o, 'ƪ')).contraction?
            @combined_hash[k][k1] = 'stylistic_choice_correction'
            @combined_hash[k - 1][@combined_hash[k - 1].key('verb_mistake')] = 'stylistic_choice'
          end
        end
      end
      @combined_hash
    end

    private

    def update_combined_hash(mistake, original, corrected, opposite_mistake)
      opposite_mistake.nil? ? om = "#{mistake.gsub(/_mistake/, '')}_correction" : om = opposite_mistake
      @mistake_info[original] = "#{mistake}"
      @correct_info[corrected] = om
      @combined_hash[@combined_hash.length] = @mistake_info
      @combined_hash[@combined_hash.length] = @correct_info
    end

    def update_combined_hash_single_mistake_original(mistake)
      @mistake_info[original_sentence_info_hash[@j]['token']] = mistake
      @combined_hash[@combined_hash.length] = @mistake_info
    end

    def update_combined_hash_single_mistake_corrected(mistake)
      @correct_info[corrected_sentence_info_hash[@i]['token']] = mistake
      @combined_hash[@combined_hash.length] = @correct_info
    end

    def matching_ids_error_analysis(original, corrected)
      case
      when ChatCorrect::MistakeAnalyzer.new(original: original, corrected: corrected).no_mistake?
        @correct_info[corrected['token']] = 'no_mistake'
        @combined_hash[@combined_hash.length] = @correct_info
      when ChatCorrect::MistakeAnalyzer.new(original: original, corrected: corrected).verb_mistake?
        update_combined_hash('verb_mistake', original['token'], corrected['token'], nil)
      when ChatCorrect::MistakeAnalyzer.new(original: original, corrected: corrected).capitalization_mistake?
        update_combined_hash('capitalization_mistake', original['token'], corrected['token'], nil)
      when ChatCorrect::Pluralization.new(token_a: corrected['token'], token_b: original['token']).pluralization_error?
        update_combined_hash('pluralization_mistake', original['token'], corrected['token'], nil)
      when ChatCorrect::MistakeAnalyzer.new(original: original, corrected: corrected).spelling_mistake?
        update_combined_hash('spelling_mistake', original['token'], corrected['token'], nil)
      when ChatCorrect::MistakeAnalyzer.new(original: original, corrected: corrected).punctuation_mistake?
        update_combined_hash('punctuation_mistake', original['token'], corrected['token'], nil)
      when ChatCorrect::MistakeAnalyzer.new(original: original, corrected: corrected).unnecessary_word_missing_punctuation_mistake?
        update_combined_hash('unnecessary_word_mistake', original['token'], corrected['token'], 'missing_punctuation_correction')
      else
        update_combined_hash('word_choice_mistake', original['token'], corrected['token'], nil)
      end
      @j +=1
      @i +=1
    end

    def unmatched_ids_error_analysis
      word_order_counter = 0
      word_order_key = 0
      original_sentence_info_hash.each do |ks1, kv1|
        if kv1['match_id'] == corrected_sentence_info_hash[@i]['match_id']
          word_order_counter = 1
          word_order_key = ks1
        end
      end
      if word_order_counter == 1
        if corrected_sentence_info_hash[@i]['token'].downcase == original_sentence_info_hash[word_order_key]['token'].downcase
          update_combined_hash_single_mistake_corrected('word_order_mistake')
        else
          if ChatCorrect::Verb.new(word: corrected_sentence_info_hash[@i]['token'], pos: 'vb', text: original_sentence_info_hash[word_order_key]['token']).verb_error?
            update_combined_hash_single_mistake_corrected('verb_mistake_correction')
            @mistake_info[original_sentence_info_hash[word_order_key]['token']] = 'verb_mistake'
            @combined_hash[@combined_hash.length] = @mistake_info
          elsif ChatCorrect::Pluralization.new(token_a: corrected_sentence_info_hash[@i]['token'], token_b: original_sentence_info_hash[word_order_key]['token']).pluralization_error?
            update_combined_hash_single_mistake_corrected('pluralization_mistake_correction')
            @mistake_info[original_sentence_info_hash[word_order_key]['token']] = 'pluralization_mistake'
            @combined_hash[@combined_hash.length] = @mistake_info
          else
            update_combined_hash_single_mistake_corrected('missing_word_mistake')
            @mistake_info[original_sentence_info_hash[word_order_key]['token']] = 'unnecessary_word_mistake'
            @combined_hash[@combined_hash.length] = @mistake_info
          end
        end
        @j +=1
      else
        if corrected_sentence_info_hash[@i]['token'].gsub(/[[:punct:]]/, '').eql?('')
          update_combined_hash_single_mistake_corrected('punctuation_mistake')
        else
          if @j != 0
            concatenated_corrected_string = corrected_sentence_info_hash[@i - 1]['token'].to_s + corrected_sentence_info_hash[@i]['token'].to_s
            if ChatCorrect::Possessive.new(token_a: original_sentence_info_hash[@j - 1]['token'], token_b: concatenated_corrected_string).possessive?
              @mistake_info[original_sentence_info_hash[@j - 1]['token']] = 'possessive_mistake'
              @correct_info[concatenated_corrected_string] = 'possessive_mistake_correction'
              @combined_hash[@combined_hash.length - 1] = @mistake_info
              @combined_hash[@combined_hash.length] = @correct_info
            else
              update_combined_hash_single_mistake_corrected('missing_word_mistake')
            end
          else
            update_combined_hash_single_mistake_corrected('missing_word_mistake')
          end
        end
      end
      @i +=1
    end

    def special_error_analysis
      if original_sentence_info_hash[@j]['token'].gsub(/[[:punct:]]/, '').eql?('') ||
        PUNCTUATION_SYMBOLS.include?(original_sentence_info_hash[@j]['token'])
        update_combined_hash_single_mistake_original('punctuation_mistake')
        @final_matched_array << original_sentence_info_hash[@j]['match_id'].to_s
      else
        update_combined_hash_single_mistake_original('unnecessary_word_mistake')
        @final_matched_array << original_sentence_info_hash[@j]['match_id'].to_s
      end
      @j +=1
    end

    def duplicate_error_analysis
      update_combined_hash_single_mistake_original('duplicate_word_mistake')
      @j +=1
    end
  end
end
