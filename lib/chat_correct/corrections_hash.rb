module ChatCorrect
  class CorrectionsHash
    attr_reader :original_sentence_info_hash, :corrected_sentence_info_hash
    def initialize(original_sentence_info_hash:, corrected_sentence_info_hash:)
      @original_sentence_info_hash = original_sentence_info_hash
      @corrected_sentence_info_hash = corrected_sentence_info_hash
      @combined_hash = {}
      @final_matched_array = []
    end

    def create
      j = 0
      i = 0
      while i < corrected_sentence_info_hash.length do
        @correct_info = {}
        @mistake_info = {}
        if j >= original_sentence_info_hash.length
          if corrected_sentence_info_hash[i]['token'].gsub(/[[:punct:]]/, '') == ''
            #puts corrected_sentence_info_hash[i]['match_id'] + ' :punctuation_mistake 1'
            @correct_info[corrected_sentence_info_hash[i]['token']] = 'missing_punctuation_mistake'
            @combined_hash[@combined_hash.length] = @correct_info
            #puts @combined_hash.to_s + ' :punctuation_mistake 1'
          else
            #puts corrected_sentence_info_hash[i]['match_id']  + ' :missing_word_mistake 2'
            @correct_info[corrected_sentence_info_hash[i]['token']] = 'missing_word_mistake'
            @combined_hash[@combined_hash.length] = @correct_info
            #puts @combined_hash.to_s + ' :missing_word_mistake 2'
          end
          i +=1
        else
          case
            when original_sentence_info_hash[j]['match_id'].to_s[0].eql?('c') && original_sentence_info_hash[j]['match_id'].to_s[1..original_sentence_info_hash[j]['match_id'].to_s.length].eql?(i.to_s)
              case
              when ChatCorrect::MistakeAnalyzer.new(original: original_sentence_info_hash[j], corrected: corrected_sentence_info_hash[i]).no_mistake?
                @correct_info[corrected_sentence_info_hash[i]['token']] = 'no_mistake'
                @combined_hash[@combined_hash.length] = @correct_info
              when ChatCorrect::MistakeAnalyzer.new(original: original_sentence_info_hash[j], corrected: corrected_sentence_info_hash[i]).verb_mistake?
                update_combined_hash('verb_mistake', original_sentence_info_hash[j]['token'], corrected_sentence_info_hash[i]['token'])
              when ChatCorrect::MistakeAnalyzer.new(original: original_sentence_info_hash[j], corrected: corrected_sentence_info_hash[i]).capitalization_mistake?
                update_combined_hash('capitalization_mistake', original_sentence_info_hash[j]['token'], corrected_sentence_info_hash[i]['token'])
              when ChatCorrect::Pluralization.new(token_a: corrected_sentence_info_hash[i]['token'], token_b: original_sentence_info_hash[j]['token']).pluralization_error?
                update_combined_hash('pluralization_mistake', original_sentence_info_hash[j]['token'], corrected_sentence_info_hash[i]['token'])
              when ChatCorrect::MistakeAnalyzer.new(original: original_sentence_info_hash[j], corrected: corrected_sentence_info_hash[i]).spelling_mistake?
                update_combined_hash('spelling_mistake', original_sentence_info_hash[j]['token'], corrected_sentence_info_hash[i]['token'])
              when ChatCorrect::MistakeAnalyzer.new(original: original_sentence_info_hash[j], corrected: corrected_sentence_info_hash[i]).punctuation_mistake?
                update_combined_hash('punctuation_mistake', original_sentence_info_hash[j]['token'], corrected_sentence_info_hash[i]['token'])
              when ChatCorrect::MistakeAnalyzer.new(original: original_sentence_info_hash[j], corrected: corrected_sentence_info_hash[i]).unnecessary_word_missing_punctuation_mistake?
                @mistake_info[original_sentence_info_hash[j]['token']] = 'unnecessary_word_mistake'
                @correct_info[corrected_sentence_info_hash[i]['token']] = 'missing_punctuation_mistake'
                @combined_hash[@combined_hash.length] = @mistake_info
                @combined_hash[@combined_hash.length] = @correct_info
              when ChatCorrect::MistakeAnalyzer.new(original: original_sentence_info_hash[j], corrected: corrected_sentence_info_hash[i]).possessive_mistake?
                update_combined_hash('possessive_mistake', original_sentence_info_hash[j]['token'], corrected_sentence_info_hash[i]['token'])
              else
                update_combined_hash('word_choice_mistake', original_sentence_info_hash[j]['token'], corrected_sentence_info_hash[i]['token'])
              end
              j +=1
              i +=1
            when original_sentence_info_hash[j]['match_id'].to_s[0] == 'c' && original_sentence_info_hash[j]['match_id'].to_s[1..original_sentence_info_hash[j]['match_id'].to_s.length] != i.to_s
              word_order_counter = 0
              word_order_key = 0
              original_sentence_info_hash.each do |ks1, kv1|
                if kv1['match_id'] == corrected_sentence_info_hash[i]['match_id']
                  word_order_counter = 1
                  word_order_key = ks1
                end
              end
              if word_order_counter == 1
                #puts 'Corrected: ' + corrected_sentence_info_hash[i]['token'].to_s
                #puts 'Student: ' + original_sentence_info_hash[j]['token']
                if corrected_sentence_info_hash[i]['token'].downcase == original_sentence_info_hash[word_order_key]['token'].downcase
                  #puts corrected_sentence_info_hash[i]['match_id'] + ' :word_order_mistake 17'
                  @correct_info[corrected_sentence_info_hash[i]['token']] = 'word_order_mistake'
                  @combined_hash[@combined_hash.length] = @correct_info
                  #puts @combined_hash.to_s + ' :word_order_mistake 17'
                else
                  #puts '17.1 corrected sentence word: ' + corrected_sentence_info_hash[i]['token'].to_s
                  #puts '17.1 student sentence word: ' + original_sentence_info_hash[word_order_key]['token'].to_s
                  #puts '17.1 corrected sentence pos_tag: ' + corrected_sentence_info_hash[i]['pos_tag'].to_s
                  if ChatCorrect::Verb.new(word: corrected_sentence_info_hash[i]['token'], pos: 'vb', text: original_sentence_info_hash[word_order_key]['token']).verb_error?
                    #puts corrected_sentence_info_hash[i]['match_id'] + ' :verb_mistake_opposite 17.001'
                    @correct_info[corrected_sentence_info_hash[i]['token']] = 'verb_mistake_opposite'
                    @combined_hash[@combined_hash.length] = @correct_info
                    #puts @combined_hash.to_s + ' :verb_mistake_opposite 17.001'
                    #puts original_sentence_info_hash[j]['match_id'] + ' :verb_mistake 17.002'
                    @mistake_info[original_sentence_info_hash[word_order_key]['token']] = 'verb_mistake'
                    @combined_hash[@combined_hash.length] = @mistake_info
                    #puts @combined_hash.to_s + ' :verb_mistake 17.002'
                  elsif ChatCorrect::Pluralization.new(token_a: corrected_sentence_info_hash[i]['token'], token_b: original_sentence_info_hash[word_order_key]['token']).pluralization_error?
                    #puts corrected_sentence_info_hash[i]['match_id'] + ' :pluralization_mistake_opposite 17.01'
                    @correct_info[corrected_sentence_info_hash[i]['token']] = 'pluralization_mistake_opposite'
                    @combined_hash[@combined_hash.length] = @correct_info
                    #puts @combined_hash.to_s + ' :pluralization_mistake_opposite 17.01'
                    #puts original_sentence_info_hash[j]['match_id'] + ' :pluralization_mistake 17.02'
                    @mistake_info[original_sentence_info_hash[word_order_key]['token']] = 'pluralization_mistake'
                    @combined_hash[@combined_hash.length] = @mistake_info
                    #puts @combined_hash.to_s + ' :pluralization_mistake 17.02'
                  else
                    #puts corrected_sentence_info_hash[i]['match_id'] + ' :missing_word_mistake 17.1'
                    @correct_info[corrected_sentence_info_hash[i]['token']] = 'missing_word_mistake'
                    @combined_hash[@combined_hash.length] = @correct_info
                    #puts @combined_hash.to_s + ' :missing_word_mistake 17.1'
                    #puts original_sentence_info_hash[j]['match_id'] + ' :unnecessary_word_mistake 17.2'
                    @mistake_info[original_sentence_info_hash[word_order_key]['token']] = 'unnecessary_word_mistake'
                    @combined_hash[@combined_hash.length] = @mistake_info
                    #puts @combined_hash.to_s + ' :unnecessary_word_mistake 17.2'
                  end
                end
                j +=1
              else
                if corrected_sentence_info_hash[i]['token'].gsub(/[[:punct:]]/, '') == ''
                  #puts corrected_sentence_info_hash[i]['match_id'] + ' :punctuation_mistake_mistake 18'
                  @correct_info[corrected_sentence_info_hash[i]['token']] = 'punctuation_mistake'
                  @combined_hash[@combined_hash.length] = @correct_info
                  #puts @combined_hash.to_s + ' :punctuation_mistake_mistake 18'
                else
                  unless j == 0
                    #puts 'Student sentence word: ' + original_sentence_info_hash[j - 1]['token'].to_s
                    concatenated_corrected_string = corrected_sentence_info_hash[i - 1]['token'].to_s + corrected_sentence_info_hash[i]['token'].to_s
                    #puts 'Corrected sentence word: ' + concatenated_corrected_string
                    #puts check_possessive(original_sentence_info_hash[j - 1]['token'], concatenated_corrected_string).to_s
                    if ChatCorrect::Possessive.new(token_a: original_sentence_info_hash[j - 1]['token'], token_b: concatenated_corrected_string).possessive?
                      #puts original_sentence_info_hash[j - 1]['match_id'] + ' :possessive_mistake 19'
                      #puts corrected_sentence_info_hash[i]['match_id'] + ' :possessive_mistake_opposite 19.1'
                      @mistake_info[original_sentence_info_hash[j - 1]['token']] = 'possessive_mistake'
                      @correct_info[concatenated_corrected_string] = 'possessive_mistake_opposite'
                      @combined_hash[@combined_hash.length - 1] = @mistake_info
                      @combined_hash[@combined_hash.length] = @correct_info
                      #puts @combined_hash.to_s + ' :possessive_mistake 19'
                    else
                      #puts corrected_sentence_info_hash[i]['match_id'] + ' :missing_word_mistake 19'
                      @correct_info[corrected_sentence_info_hash[i]['token']] = 'missing_word_mistake'
                      @combined_hash[@combined_hash.length] = @correct_info
                      #puts @combined_hash.to_s + ' :missing_word_mistake 19'
                    end
                  else
                    #puts corrected_sentence_info_hash[i]['match_id'] + ' :missing_word_mistake 19'
                    @correct_info[corrected_sentence_info_hash[i]['token']] = 'missing_word_mistake'
                    @combined_hash[@combined_hash.length] = @correct_info
                    #puts @combined_hash.to_s + ' :missing_word_mistake 19'
                  end
                end
              end
              i +=1
            when original_sentence_info_hash[j]['match_id'].to_s[0] == 's'
              if original_sentence_info_hash[j]['token'].gsub(/[[:punct:]]/, '') == '' || original_sentence_info_hash[j]['token'] == '∯' || original_sentence_info_hash[j]['token'] == '∬' || original_sentence_info_hash[j]['token'] == '∫' || original_sentence_info_hash[j]['token'] == '∮'
                #puts original_sentence_info_hash[j]['match_id'] + ' :punctuation_mistake_mistake 20'
                @mistake_info[original_sentence_info_hash[j]['token']] = 'punctuation_mistake'
                @combined_hash[@combined_hash.length] = @mistake_info
                #puts @combined_hash.to_s + ' :punctuation_mistake_mistake 20'
                @final_matched_array << original_sentence_info_hash[j]['match_id'].to_s
              else
                #puts original_sentence_info_hash[j]['match_id'] + ' :unnecessary_word_mistake 21'
                @mistake_info[original_sentence_info_hash[j]['token']] = 'unnecessary_word_mistake'
                @combined_hash[@combined_hash.length] = @mistake_info
                #puts @combined_hash.to_s + ' :unnecessary_word_mistake 21'
                @final_matched_array << original_sentence_info_hash[j]['match_id'].to_s
              end
              j +=1
            when original_sentence_info_hash[j]['match_id'].to_s[0] == 'd'
              #puts original_sentence_info_hash[j]['match_id'] + ' :duplicate_word_mistake 22'
              @mistake_info[original_sentence_info_hash[j]['token']] = 'duplicate_word_mistake'
              @combined_hash[@combined_hash.length] = @mistake_info
              #puts @combined_hash.to_s + ' :duplicate_word_mistake 22'
              j +=1
          end
        end
      end
      original_sentence_info_hash.each do |k, v|
        if v['match_id'].to_s[0] == 's' && @final_matched_array.include?(v['match_id'].to_s) == false #&& k >= corrected_sentence_info_hash.length
          #puts 'Longer: ' + v['match_id'].to_s
          if v['token'].gsub(/[[:punct:]]/, '') == '' || v['token'] == '∯' || v['token'] == '∬' || v['token'] == '∫' || v['token'] == '∮'
            #puts v['match_id'] + ' :punctuation_mistake 23'
            #puts 'Wrong Info: ' + @mistake_info.to_s
            @mistake_info = Hash.new
            @mistake_info[v['token']] = 'punctuation_mistake'
            #puts 'Wrong Info: ' + @mistake_info.to_s
            @combined_hash[@combined_hash.length] = @mistake_info
            #puts @combined_hash.to_s + ' :punctuation_mistake 23'
            @final_matched_array << v['match_id'].to_s
          else
            #puts v['match_id'] + ' :unnecessary_word_mistake 24'
            @mistake_info = Hash.new
            @mistake_info[v['token']] = 'unnecessary_word_mistake'
            @combined_hash[@combined_hash.length] = @mistake_info
            #puts @combined_hash.to_s + ' :unnecessary_word_mistake 24'
            @final_matched_array << v['match_id'].to_s
          end
        end
      end
      # Final stylistic check (for contractions)
      # Irregular contractions: 'ain't', 'don't', 'won't', 'shan't'
      @combined_hash.each do |k, v|
        #puts 'Layout hash (k): ' + k.to_s
        #puts 'Layout hash (v): ' + v.to_s
        v.each do |k1, v1|
          #puts 'Layout hash (k1): ' + k1.to_s
          #puts 'Layout hash (v1): ' + v1.to_s
          if k1.include?('ƪ') == true && v1.include?('missing_word_mistake') && @combined_hash[k - 1].to_s.include?('unnecessary_word_mistake') && @combined_hash[k - 2].to_s.include?('unnecessary_word_mistake')
            #puts contraction_check(@combined_hash[k - 2].key('unnecessary_word_mistake').to_s, @combined_hash[k - 1].key('unnecessary_word_mistake').to_s, k1.to_s).to_s
            #puts @combined_hash[k - 1].key('unnecessary_word_mistake').to_s
            #puts @combined_hash[k - 2].key('unnecessary_word_mistake').to_s
            if ChatCorrect::Contraction.new(token_a: @combined_hash[k - 2].key('unnecessary_word_mistake').to_s, token_b: @combined_hash[k - 1].key('unnecessary_word_mistake').to_s, contraction: k1.to_s).contraction?
              @combined_hash[k][k1] = 'stylistic_choice_opposite'
              @combined_hash[k - 1][@combined_hash[k - 1].key('unnecessary_word_mistake')] = 'stylistic_choice'
              @combined_hash[k - 2][@combined_hash[k - 2].key('unnecessary_word_mistake')] = 'stylistic_choice'
            end
          end
          if k1.include?('ƪ') == true && v1.include?('missing_word_mistake') && @combined_hash[k + 1].to_s.include?('unnecessary_word_mistake') && @combined_hash[k + 2].to_s.include?('unnecessary_word_mistake')
            #puts contraction_check(@combined_hash[k + 2].key('unnecessary_word_mistake').to_s, @combined_hash[k + 1].key('unnecessary_word_mistake').to_s, k1.to_s).to_s
            #puts @combined_hash[k + 1].key('unnecessary_word_mistake').to_s
            #puts @combined_hash[k + 2].key('unnecessary_word_mistake').to_s
            if ChatCorrect::Contraction.new(token_a: @combined_hash[k + 2].key('unnecessary_word_mistake').to_s, token_b: @combined_hash[k + 1].key('unnecessary_word_mistake').to_s, contraction: k1.to_s).contraction?
              @combined_hash[k][k1] = 'stylistic_choice_opposite'
              @combined_hash[k + 1][@combined_hash[k + 1].key('unnecessary_word_mistake')] = 'stylistic_choice'
              @combined_hash[k + 2][@combined_hash[k + 2].key('unnecessary_word_mistake')] = 'stylistic_choice'
            end
          end
          if k1.include?('ƪ') == true && v1.include?('unnecessary_word_mistake') && @combined_hash[k + 1].to_s.include?('missing_word_mistake') && @combined_hash[k + 2].to_s.include?('missing_word_mistake')
            #puts contraction_check(@combined_hash[k + 1].key('missing_word_mistake').to_s, @combined_hash[k + 2].key('missing_word_mistake').to_s, k1.to_s).to_s
            #puts @combined_hash[k + 1].key('missing_word_mistake').to_s
            #puts @combined_hash[k + 2].key('missing_word_mistake').to_s
            if ChatCorrect::Contraction.new(token_a: @combined_hash[k + 1].key('missing_word_mistake').to_s, token_b: @combined_hash[k + 2].key('missing_word_mistake').to_s,  contraction: k1.to_s).contraction?
              @combined_hash[k][k1] = 'stylistic_choice'
              @combined_hash[k + 1][@combined_hash[k + 1].key('missing_word_mistake')] = 'stylistic_choice_opposite'
              @combined_hash[k + 2][@combined_hash[k + 2].key('missing_word_mistake')] = 'stylistic_choice_opposite'
            end
          end
          if k1.include?('ƪ') == true && v1.include?('unnecessary_word_mistake') && @combined_hash[k - 1].to_s.include?('missing_word_mistake') && @combined_hash[k - 2].to_s.include?('missing_word_mistake')
            #puts contraction_check(@combined_hash[k - 2].key('missing_word_mistake').to_s, @combined_hash[k - 1].key('missing_word_mistake').to_s, k1.to_s).to_s
            #puts @combined_hash[k - 1].key('missing_word_mistake').to_s
            #puts @combined_hash[k - 2].key('missing_word_mistake').to_s
            if ChatCorrect::Contraction.new(token_a: @combined_hash[k - 2].key('missing_word_mistake').to_s, token_b: @combined_hash[k - 1].key('missing_word_mistake').to_s,  contraction: k1.to_s).contraction?
              @combined_hash[k][k1] = 'stylistic_choice'
              @combined_hash[k - 1][@combined_hash[k - 1].key('missing_word_mistake')] = 'stylistic_choice_opposite'
              @combined_hash[k - 2][@combined_hash[k - 2].key('missing_word_mistake')] = 'stylistic_choice_opposite'
            end
          end
          if k1.include?('ƪ') == true && v1.include?('verb_mistake') && @combined_hash[k + 1].to_s.include?('verb_mistake_opposite')
            #puts 'Split sentences k1: ' + k1.gsub(/ƪ/o, "'").split.to_s
            if ChatCorrect::Contraction.new(token_a: @combined_hash[k + 1].key('verb_mistake_opposite').to_s.split[0].to_s, token_b: @combined_hash[k + 1].key('verb_mistake_opposite').to_s.split[1].to_s,  contraction: k1.gsub(/ƪ/o, "'").split[0].to_s.gsub(/'/o, 'ƪ')).contraction?
              @combined_hash[k][k1] = 'stylistic_choice'
              @combined_hash[k + 1][@combined_hash[k + 1].key('verb_mistake_opposite')] = 'stylistic_choice_opposite'
            end
          end
          if k1.include?('ƪ') == true && v1.include?('verb_mistake_opposite') && @combined_hash[k - 1].to_s.include?('verb_mistake')
            #puts 'Split sentences k1: ' + k1.gsub(/ƪ/o, "'").split.to_s
            #puts @combined_hash[k - 1].key('verb_mistake').to_s
            #puts contraction_check(@combined_hash[k - 1].key('verb_mistake').to_s.split[0].to_s, @combined_hash[k - 1].key('verb_mistake').to_s.split[1].to_s, k1.gsub(/ƪ/o, "'").split[0].to_s).to_s
            #puts @combined_hash[k - 1].key('verb_mistake').to_s.split[0].to_s
            #puts @combined_hash[k - 1].key('verb_mistake').to_s.split[1].to_s
            #puts k1.gsub(/ƪ/o, "'").split[0].to_s
            if ChatCorrect::Contraction.new(token_a: @combined_hash[k - 1].key('verb_mistake').to_s.split[0].to_s, token_b: @combined_hash[k - 1].key('verb_mistake').to_s.split[1].to_s,  contraction: k1.gsub(/ƪ/o, "'").split[0].to_s.gsub(/'/o, 'ƪ')).contraction?
              @combined_hash[k][k1] = 'stylistic_choice_opposite'
              @combined_hash[k - 1][@combined_hash[k - 1].key('verb_mistake')] = 'stylistic_choice'
            end
          end
        end
      end
      @combined_hash.to_json
    end

    private

    def update_combined_hash(mistake, original, corrected)
      @mistake_info[original] = "#{mistake}"
      @correct_info[corrected] = "#{mistake}_opposite"
      @combined_hash[@combined_hash.length] = @mistake_info
      @combined_hash[@combined_hash.length] = @correct_info
    end
  end
end
