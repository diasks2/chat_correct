require 'engtagger'

module ChatCorrect
  class Correct
    TYPES_OF_MISTAKES = ['missing_word', 'unnecessary_word', 'spelling', 'verb_tense', 'punctuation', 'word_order', 'capitalization', 'duplicate_word', 'word_choice', 'pluralization', 'possessive', 'stylistic_choice']
    attr_reader :original_sentence, :corrected_sentence
    def initialize(original_sentence:, corrected_sentence:)
      @original_sentence = original_sentence
      @corrected_sentence = corrected_sentence
    end

    def correct
      # puts "OS: #{original_sentence}"
      # puts "CS: #{corrected_sentence}"
      # puts "OST: #{original_sentence_tokenized}"
      # puts "CST: #{corrected_sentence_tokenized}"
      # puts "OSTag: #{original_sentence_tagged}"
      # puts "CSTag: #{corrected_sentence_tagged}"
      # puts "OSTD: #{original_sentence_tokenized_downcased}"
      # puts "CSTD: #{corrected_sentence_tokenized_downcased}"

      # puts "OSI: #{original_sentence_info_hash}"
      # puts "CSI: #{corrected_sentence_info_hash}"
      # puts "**********"
      stage_1_pass
      debug
      # puts "OSI: #{original_sentence_info_hash}"
      # puts "CSI: #{corrected_sentence_info_hash}"
      # puts "End of Stage 1 **********"
      stage_2_pass
      debug
      # puts "OSI: #{original_sentence_info_hash}"
      # puts "CSI: #{corrected_sentence_info_hash}"
      # puts "End of Stage 2 **********"
      stage_3_pass
      debug
      # puts "OSI: #{original_sentence_info_hash}"
      # puts "CSI: #{corrected_sentence_info_hash}"
      # puts "End of Stage 3 **********"
      stage_4_pass
      debug
      stage_5_pass
      debug
      stage_6_pass
      debug
      prev_next_match_check
      debug
      stage_7_pass
      debug
      prev_next_match_check
      debug
      stage_8_pass
      debug
      prev_next_match_check
      debug
      stage_9_pass
      debug
      reverse_symbols(create_final_hash)
    end

    def mistakes
      {}
    end

    def mistake_report
      mistake_report_hash = {}
      TYPES_OF_MISTAKES.each do |mistake|
        mistake_report_hash[mistake] = 0
      end
      mistake_report_hash
    end

    def number_of_mistakes
      if (original_sentence_tokenized - corrected_sentence_tokenized).eql?([])
        0
      end
    end

    private

    def reverse_symbols(txt)
      txt.gsub('∬', '"')
         .gsub('∯', '"')
         .gsub('ƪ', "'")
         .gsub('∫', "'")
         .gsub('∮', "'")
         .gsub('☍', ". ")
         .gsub('☊', ".")
         .gsub('☌', ",")
    end

    def original_sentence_tokenized
      @original_sentence_tokenized ||= ChatCorrect::CombineMultiWordVerbs.new(text: original_sentence).combine
    end

    def corrected_sentence_tokenized
      @corrected_sentence_tokenized ||= ChatCorrect::CombineMultiWordVerbs.new(text: corrected_sentence).combine
    end

    def original_sentence_tagged
      tgr = EngTagger.new
      @original_sentence_tagged ||= tgr.add_tags(original_sentence).split
    end

    def corrected_sentence_tagged
      tgr = EngTagger.new
      @corrected_sentence_tagged ||= tgr.add_tags(corrected_sentence).split
    end

    def original_sentence_tokenized_downcased
      @original_sentence_tokenized_downcased ||= original_sentence_tokenized.map { |token| token.downcase }
    end

    def corrected_sentence_tokenized_downcased
      @corrected_sentence_tokenized_downcased ||= corrected_sentence_tokenized.map { |token| token.downcase }
    end

    def original_sentence_info_hash
      @original_sentence_info_hash ||= create_sentence_info_hash(original_sentence_tokenized, original_sentence_tokenized_downcased, original_sentence_tagged)
    end

    def corrected_sentence_info_hash
      @corrected_sentence_info_hash ||= create_sentence_info_hash(corrected_sentence_tokenized, corrected_sentence_tokenized_downcased, corrected_sentence_tagged)
    end

    def create_sentence_info_hash(sentence_tokenized, sentence_tokenized_downcased, sentence_tagged)
      sentence_hash = {}
      sentence_tokenized.each_with_index do |token, index|
        sentence_info = {}
        sentence_info['token'] = token
        assign_previous_token(sentence_info, index, 1, sentence_tokenized)
        assign_previous_token(sentence_info, index, 2, sentence_tokenized)
        assign_next_token(sentence_info, index, 1, sentence_tokenized)
        assign_next_token(sentence_info, index, 2, sentence_tokenized)
        sentence_info['num_char'] = token.length
        sentence_info['position'] = index
        sentence_info['multiple_words'] = token.include?(' ') ? true : false
        sentence_info['lowercase'] = token.downcase
        sentence_info['match_id'] = 'c' + index.to_s if sentence_tokenized.eql?(corrected_sentence_tokenized)
        sentence_info['pos_tag'] = sentence_tagged[index].to_s.partition('>').first[1..-1]
        sentence_info['punctuation'] = ChatCorrect::Punctuation.new(text: token).is_punctuation?
        sentence_info['duplicates'] = (sentence_tokenized_downcased.count(token.downcase) > 1 ? true : false)
        sentence_info['uid'] = sentence_tokenized.eql?(corrected_sentence_tokenized) ? 'corrected' + index.to_s : 'original' + index.to_s
        sentence_info['matched'] = false
        sentence_info['is_time'] = ChatCorrect::Time.new(text: token).is_time?
        sentence_hash[index] = sentence_info
      end
      sentence_hash
    end

    def assign_previous_token(hash, index, lookup, tokenized_array)
      if index - lookup < 0
        hash["prev_word#{lookup}"] = 'ȸ'
      else
        hash["prev_word#{lookup}"] = tokenized_array[index - lookup]
      end
    end

    def assign_next_token(hash, index, lookup, tokenized_array)
      if (index + lookup) > (tokenized_array.length - 1)
        hash["next_word#{lookup}"] = 'ȹ'
      else
        hash["next_word#{lookup}"] = tokenized_array[index + lookup]
      end
    end

    def prev_next_match_check
      corrected_sentence_info_hash.each do |kc, vc|
        unless vc['matched'] == true
          if kc == 0
            prev_match_vc = 'ȸ'
          else
            prev_match_vc = corrected_sentence_info_hash[kc - 1]['match_id']
          end

          if kc == corrected_sentence_info_hash.length - 1
            next_match_vc = 'ȹ'
          else
            next_match_vc = corrected_sentence_info_hash[kc + 1]['match_id']
          end
          original_sentence_info_hash.each do |ks, vs|
            if ks == 0
              prev_match_vs = 'ȸ'
            else
              prev_match_vs = original_sentence_info_hash[ks - 1]['match_id']
            end
            if ks == original_sentence_info_hash.length - 1
              next_match_vs = 'ȹ'
            else
              next_match_vs = original_sentence_info_hash[ks + 1]['match_id']
            end
            #puts 'KC: ' + kc.to_s
            #puts 'KS: ' + ks.to_s
              #puts 'prev_match_vc: ' + prev_match_vc.to_s
              #puts 'next_match_vc: ' + next_match_vc.to_s
              #puts 'prev_match_vs: ' + prev_match_vs.to_s
              #puts 'next_match_vs: ' + next_match_vs.to_s
            if vs['match_id'].blank?
              if (prev_match_vc == prev_match_vs) && (next_match_vc == next_match_vs)
                original_sentence_info_hash[ks]['match_id'] = vc['match_id']
                corrected_sentence_info_hash[kc]['matched'] = true
              end
            end
          end
        end
      end
    end

    def debug
      # puts "++++++++++++++++++++"
      original_sentence_info_hash.each do |k, v|
        # puts 'Key: ' + k.to_s + '; Word: ' + v['token'].to_s + '; Match ID: ' + v['match_id'].to_s
      end
    end

    def stage_1_pass
      matched_id_array = []
      corrected_sentence_info_hash.each do |kc, vc|
        original_sentence_info_hash.each do |ko, vo|
          if (vc['lowercase'].eql?(vo['lowercase']) ||
             (vc['prev_word1'].eql?(vo['prev_word1']) &&
              vc['next_word1'].eql?(vo['next_word1']) &&
              !vc['is_time'] &&
              !vo['is_time'] &&
              (!ChatCorrect::Punctuation.new(text: vc['prev_word1']).is_punctuation? &&
               !ChatCorrect::Punctuation.new(text: vc['next_word1']).is_punctuation?) &&
              vc['punctuation'].eql?(vo['punctuation']))) &&
            !matched_id_array.include?(vc['match_id'].to_s) &&
            !vo['duplicates'] &&
            !vc['duplicates']

            original_sentence_info_hash[ko]['match_id'] = vc['match_id']
            corrected_sentence_info_hash[kc]['matched'] = true
            matched_id_array << vc['match_id'].to_s
            # puts "Matched ID: #{matched_id_array}"
          end
        end
      end
    end

    def stage_2_pass
      corrected_sentence_info_hash.each do |kc, vc|
        unless vc['matched'] == true
          if kc == 0
            prev_match_vc = 'ȸ'
          else
            prev_match_vc = corrected_sentence_info_hash[kc - 1]['match_id']
          end
          if kc == corrected_sentence_info_hash.length - 1
              next_match_vc = 'ȹ'
            else
              next_match_vc = corrected_sentence_info_hash[kc + 1]['match_id']
            end
            if kc == corrected_sentence_info_hash.length - 1
              next_word_vc = 'ȹ'
            else
              next_word_vc = corrected_sentence_info_hash[kc + 1]['token']
            end
          original_sentence_info_hash.each do |ks, vs|
            if ks == 0
              prev_match_vs = 'ȸ'
            else
              prev_match_vs = original_sentence_info_hash[ks - 1]['match_id']
            end
          if ks == original_sentence_info_hash.length - 1
              next_match_vs = 'ȹ'
            else
              next_match_vs = original_sentence_info_hash[ks + 1]['match_id']
            end
            if ks == original_sentence_info_hash.length - 1
              next_word_vs = 'ȹ'
            else
              next_word_vs = original_sentence_info_hash[ks + 1]['token']
            end
            if vs['match_id'].blank?
              if (prev_match_vc == prev_match_vs) && (next_match_vc == next_match_vs)
                original_sentence_info_hash[ks]['match_id'] = vc['match_id']
                corrected_sentence_info_hash[kc]['matched'] = true
              end
              if (vs['token'] == next_word_vs) && (vs['token'] != next_word_vc)
                original_sentence_info_hash[ks]['match_id'] = 'd' + ks.to_s
              end
            end
          end
        end
      end
    end

    def stage_3_pass
      corrected_sentence_info_hash.each do |kc, vc|
        unless vc['matched'] == true
          original_sentence_info_hash.each do |ks, vs|
            if vs['match_id'].blank?
              if (vc['token'] == vs['token']) && (vc['prev_word1'] == vs['prev_word1'] || vc['next_word1'] == vs['next_word1'])
                unless vc['matched'] == true || vs['prev_word1'] == 'ȸ'
                  original_sentence_info_hash[ks]['match_id'] = vc['match_id']
                  corrected_sentence_info_hash[kc]['matched'] = true
                end
              end
            end
          end
        end
      end
    end

    def stage_4_pass
      corrected_sentence_info_hash.each do |kc, vc|
        unless vc['matched'] == true
          original_sentence_info_hash.each do |ks, vs|
            if vs['match_id'].blank?
              if vc['token'].length > 3 && vs['token'].length > 3 && Levenshtein.distance(vc['token'], vs['token']) < 3
                unless vc['matched'] == true
                  # puts 'Stage 4.1 Executed'
                  # puts 'VC: ' + vc.to_s
                  original_sentence_info_hash[ks]['match_id'] = vc['match_id']
                  corrected_sentence_info_hash[kc]['matched'] = true
                end
              end
            end
          end
        end
      end
    end

    def stage_5_pass
      corrected_sentence_info_hash.each do |kc, vc|
        unless vc['matched'] == true
          original_sentence_info_hash.each do |ks, vs|
            if vs['match_id'].blank?
              if ChatCorrect::Pluralization.new(token_a: vc['token'], token_b: vs['token']).pluralization_error?
                unless vc['matched'] == true
                  #puts 'Stage 4.2 Executed'
                  #puts 'VC: ' + vc.to_s
                  original_sentence_info_hash['match_id'] = vc['match_id']
                  corrected_sentence_info_hash[kc]['matched'] = true
                end
              end
            end
          end
        end
      end
    end

    def stage_6_pass
      corrected_sentence_info_hash.each do |kc, vc|
        unless vc['matched'] == true
          original_sentence_info_hash.each do |ks, vs|
            if vs['match_id'].blank?
              if ChatCorrect::Verb.new(word: vs['token'], pos: vc['pos_tag'], text: vc['token']).verb_error? && (vc['prev_word1'].eql?(vs['prev_word1']) || vc['next_word1'].eql?(vs['next_word1']))
                unless vc['matched'] == true || vs['next_word1'].include?(' ')
                  #puts 'Stage 4.3 Executed'
                  #puts 'VC: ' + vc.to_s
                  original_sentence_info_hash[ks]['match_id'] = vc['match_id']
                  corrected_sentence_info_hash[kc]['matched'] = true
                end
              end
            end
          end
        end
      end
    end

    def stage_7_pass
      corrected_sentence_info_hash.each do |kc, vc|
        unless vc['matched'] == true
          original_sentence_info_hash.each do |ks, vs|
          if vs['match_id'].blank?
            # Distance between position of words is currently set to 5,
            # but this is a SWAG and can be adjusted based on testing.
            # The idea is to stop the algoroithm from matching words like to
            # and the that appear very far apart in the sentence and should not be matched.
            if vc['token'].length > 1 && vs['token'].length > 1 && Levenshtein.distance(vc['token'], vs['token']) < 3 && vs['token'].to_s[0] == vc['token'].to_s[0] && (vs['position'].to_i - vc['position'].to_i).abs < 5
                #puts 'VS Position: ' + vs['position'].to_s
                #puts 'VC Position: ' + vc['position'].to_s
                unless vc['matched'] == true
                  #puts 'Stage 6.1 Executed'
                  #puts 'VC: ' + vc.to_s
                  original_sentence_info_hash[ks]['match_id'] = vc['match_id']
                  corrected_sentence_info_hash[kc]['matched'] = true
                end
              end
            end
          end
        end
      end
    end

    def stage_8_pass
      corrected_sentence_info_hash.each do |kc, vc|
        unless vc['matched'] == true
          if kc == corrected_sentence_info_hash.length - 1
            next_match_vc = 'ȹ'
          else
            next_match_vc = corrected_sentence_info_hash[kc + 1]['match_id']
          end
          original_sentence_info_hash.each do |ks, vs|
            if ks == original_sentence_info_hash.length - 1
              next_match_vs = 'ȹ'
            else
              next_match_vs = original_sentence_info_hash[ks + 1]['match_id']
            end
            if vs['match_id'].blank?
              if vs['multiple_words'] == true && vc['multiple_words'] == true
                unless vc['matched'] == true
                  #puts 'Stage 8.01 Executed'
                  #puts 'VC: ' + vc.to_s
                  original_sentence_info_hash[ks]['match_id'] = vc['match_id']
                  corrected_sentence_info_hash[kc]['matched'] = true
                end
              end
              if next_match_vc == 'ȹ' && next_match_vs == 'ȹ' && vs['token'].gsub(/[[:punct:]]/, '') == '' && vc['token'].gsub(/[[:punct:]]/, '') == ''
                unless vc['matched'] == true
                  #puts 'Stage 8.1 Executed'
                  #puts 'VC: ' + vc.to_s
                  original_sentence_info_hash[ks]['match_id'] = vc['match_id']
                  corrected_sentence_info_hash[kc]['matched'] = true
                end
              end
            end
          end
        end
      end
    end

    def stage_9_pass
      original_sentence_info_hash.each do |k, v|
        if v['match_id'].blank?
          original_sentence_info_hash[k]['match_id'] = 's' + k.to_s
        end
      end
    end

    def create_final_hash
      combined_hash = Hash.new

      final_matched_id_array = Array.new

      j = 0
      i = 0
      while i < corrected_sentence_info_hash.length do
        correct_info = Hash.new
        wrong_info = Hash.new
        if j >= original_sentence_info_hash.length
          if corrected_sentence_info_hash[i]['token'].gsub(/[[:punct:]]/, '') == ''
            #puts corrected_sentence_info_hash[i]['match_id'] + ' :punctuation_mistake 1'
            correct_info[corrected_sentence_info_hash[i]['token']] = 'missing_punctuation_mistake'
            combined_hash[combined_hash.length] = correct_info
            #puts combined_hash.to_s + ' :punctuation_mistake 1'
          else
            #puts corrected_sentence_info_hash[i]['match_id']  + ' :missing_word_mistake 2'
            correct_info[corrected_sentence_info_hash[i]['token']] = 'missing_word_mistake'
            combined_hash[combined_hash.length] = correct_info
            #puts combined_hash.to_s + ' :missing_word_mistake 2'
          end
          i +=1
        else
          case
            when original_sentence_info_hash[j]['match_id'].to_s[0] == 'c' && original_sentence_info_hash[j]['match_id'].to_s[1..original_sentence_info_hash[j]['match_id'].to_s.length] == i.to_s
              case
                when corrected_sentence_info_hash[i]['token'] == original_sentence_info_hash[j]['token']
                  #puts corrected_sentence_info_hash[i]['match_id'] + ' :no_mistake 3'
                  correct_info[corrected_sentence_info_hash[i]['token']] = 'no_mistake'
                  combined_hash[combined_hash.length] = correct_info
                  #puts combined_hash.to_s + ' :no_mistake 3'
                when ChatCorrect::CommonVerbMistake.new(token_a: corrected_sentence_info_hash[i]['token'], token_b: original_sentence_info_hash[j]['token']).exists?
                  #puts original_sentence_info_hash[j]['match_id'] + ' :verb_mistake 4'
                  #puts corrected_sentence_info_hash[i]['match_id'] + ' :verb_mistake_opposite 5'
                  wrong_info[original_sentence_info_hash[j]['token']] = 'verb_mistake'
                  correct_info[corrected_sentence_info_hash[i]['token']] = 'verb_mistake_opposite'
                  combined_hash[combined_hash.length] = wrong_info
                  combined_hash[combined_hash.length] = correct_info
                  #puts combined_hash.to_s + ' :verb_mistake 4'
                when original_sentence_info_hash[j]['multiple_words'] == true || corrected_sentence_info_hash[i]['multiple_words'] == true
                  #puts original_sentence_info_hash[j]['match_id'] + ' :verb_mistake 6'
                  #puts corrected_sentence_info_hash[i]['match_id'] + ' :verb_mistake_opposite 7'
                  wrong_info[original_sentence_info_hash[j]['token']] = 'verb_mistake'
                  correct_info[corrected_sentence_info_hash[i]['token']] = 'verb_mistake_opposite'
                  combined_hash[combined_hash.length] = wrong_info
                  combined_hash[combined_hash.length] = correct_info
                  #puts combined_hash.to_s + ' :verb_mistake 6'
                when ChatCorrect::Verb.new(word: original_sentence_info_hash[j]['token'], pos: corrected_sentence_info_hash[i]['pos_tag'], text: corrected_sentence_info_hash[i]['token']).verb_error?
                  #puts corrected_sentence_info_hash[i]['pos_tag'].to_s
                  #puts original_sentence_info_hash[j]['match_id'] + ' :verb_mistake 8'
                  #puts corrected_sentence_info_hash[i]['match_id'] + ' :verb_mistake_opposite 9'
                  wrong_info[original_sentence_info_hash[j]['token']] = 'verb_mistake'
                  correct_info[corrected_sentence_info_hash[i]['token']] = 'verb_mistake_opposite'
                  combined_hash[combined_hash.length] = wrong_info
                  combined_hash[combined_hash.length] = correct_info
                  #puts combined_hash.to_s + ' :verb_mistake 8'
                when ChatCorrect::Capitalization.new(token_a: corrected_sentence_info_hash[i]['token'], token_b: original_sentence_info_hash[j]['token']).capitalization_error?
                  #puts original_sentence_info_hash[j]['match_id'] + ' :capitalization_mistake 10'
                  #puts corrected_sentence_info_hash[i]['match_id'] + ' :capitalization_mistake_opposite 11'
                  wrong_info[original_sentence_info_hash[j]['token']] = 'capitalization_mistake'
                  correct_info[corrected_sentence_info_hash[i]['token']] = 'capitalization_mistake_opposite'
                  combined_hash[combined_hash.length] = wrong_info
                  combined_hash[combined_hash.length] = correct_info
                  #puts combined_hash.to_s + ' :capitalization_mistake 10'
                when ChatCorrect::Pluralization.new(token_a: corrected_sentence_info_hash[i]['token'], token_b: original_sentence_info_hash[j]['token']).pluralization_error?
                  #puts original_sentence_info_hash[j]['match_id'] + ' :pluralization_mistake 10a'
                  #puts corrected_sentence_info_hash[i]['match_id'] + ' :pluralization_mistake 11a'
                  wrong_info[original_sentence_info_hash[j]['token']] = 'pluralization_mistake'
                  correct_info[corrected_sentence_info_hash[i]['token']] = 'pluralization_mistake_opposite'
                  combined_hash[combined_hash.length] = wrong_info
                  combined_hash[combined_hash.length] = correct_info
                  #puts combined_hash.to_s + ' :pluralization_mistake 10a'
                when ChatCorrect::Spelling.new(token_a: corrected_sentence_info_hash[i]['token'], token_b: original_sentence_info_hash[j]['token']).spelling_error?
                  if  ChatCorrect::PunctuationMasqueradingAsSpellingError.new(token_a: corrected_sentence_info_hash[i]['token'], token_b: original_sentence_info_hash[j]['token']).exists?
                    #puts 'Check Possessive: ' + check_possessive(original_sentence_info_hash[j]['token'], corrected_sentence_info_hash[i]['token']).to_s
                    if ChatCorrect::Possessive.new(token_a: original_sentence_info_hash[j]['token'], token_b: corrected_sentence_info_hash[i]['token']).possessive?
                      #puts original_sentence_info_hash[j]['match_id'] + ' :possessive_mistake 12'
                      #puts corrected_sentence_info_hash[i]['match_id'] + ' :possessive_mistake_opposite 13'
                      wrong_info[original_sentence_info_hash[j]['token']] = 'possessive_mistake'
                      correct_info[corrected_sentence_info_hash[i]['token']] = 'possessive_mistake_opposite'
                      combined_hash[combined_hash.length] = wrong_info
                      combined_hash[combined_hash.length] = correct_info
                      #puts combined_hash.to_s + ' :possessive_mistake 12'
                    else
                      #puts original_sentence_info_hash[j]['match_id'] + ' :punctuation_mistake 12'
                      #puts corrected_sentence_info_hash[i]['match_id'] + ' :punctuation_mistake_opposite 13'
                      wrong_info[original_sentence_info_hash[j]['token']] = 'punctuation_mistake'
                      correct_info[corrected_sentence_info_hash[i]['token']] = 'punctuation_mistake_opposite'
                      combined_hash[combined_hash.length] = wrong_info
                      combined_hash[combined_hash.length] = correct_info
                      #puts combined_hash.to_s + ' :punctuation_mistake 12'
                    end
                  else
                    #puts original_sentence_info_hash[j]['match_id'] + ' :spelling_mistake 12'
                    #puts corrected_sentence_info_hash[i]['match_id'] + ' :spelling_mistake_opposite 13'
                    wrong_info[original_sentence_info_hash[j]['token']] = 'spelling_mistake'
                    correct_info[corrected_sentence_info_hash[i]['token']] = 'spelling_mistake_opposite'
                    combined_hash[combined_hash.length] = wrong_info
                    combined_hash[combined_hash.length] = correct_info
                    #puts combined_hash.to_s + ' :spelling_mistake 12'
                  end
                when corrected_sentence_info_hash[i]['punctuation'] == true
                    #puts 'Student sentence punctuation (true or false): ' + original_sentence_info_hash[j]['punctuation'].to_s
                    #puts 'Student word: ' + original_sentence_info_hash[j]['token'].to_s
                  if original_sentence_info_hash[j]['punctuation'] == true
                    #puts original_sentence_info_hash[j]['match_id'] + ' :punctuation_mistake 14'
                    #puts corrected_sentence_info_hash[i]['match_id'] + ' :punctuation_mistake_opposite 15'
                    wrong_info[original_sentence_info_hash[j]['token']] = 'punctuation_mistake'
                    correct_info[corrected_sentence_info_hash[i]['token']] = 'punctuation_mistake_opposite'
                    combined_hash[combined_hash.length] = wrong_info
                    combined_hash[combined_hash.length] = correct_info
                    #puts combined_hash.to_s + ' :punctuation_mistake 14'
                  else
                    #puts original_sentence_info_hash[j]['match_id'] + ' :unnecessary_word_mistake 14.1'
                    #puts corrected_sentence_info_hash[i]['match_id'] + ' :missing_punctuation_mistake 15.1'
                    wrong_info[original_sentence_info_hash[j]['token']] = 'unnecessary_word_mistake'
                    correct_info[corrected_sentence_info_hash[i]['token']] = 'missing_punctuation_mistake'
                    combined_hash[combined_hash.length] = wrong_info
                    combined_hash[combined_hash.length] = correct_info
                    #puts combined_hash.to_s + ' :unnecessary_word_mistake & missing_punctuation_mistake 14.1 & 15.1'
                  end
                else
                  #puts 'Check Possessive: ' + check_possessive(original_sentence_info_hash[j]['token'], corrected_sentence_info_hash[i]['token']).to_s
                  if ChatCorrect::Possessive.new(token_a: original_sentence_info_hash[j]['token'], token_b: corrected_sentence_info_hash[i]['token']).possessive?
                    #puts original_sentence_info_hash[j]['match_id'] + ' :possessive_mistake 16'
                    #puts corrected_sentence_info_hash[i]['match_id'] + ' :possessive_mistake_opposite 17'
                    wrong_info[original_sentence_info_hash[j]['token']] = 'possessive_mistake'
                    correct_info[corrected_sentence_info_hash[i]['token']] = 'possessive_mistake_opposite'
                    combined_hash[combined_hash.length] = wrong_info
                    combined_hash[combined_hash.length] = correct_info
                    #puts combined_hash.to_s + ' :possessive_mistake 16'
                  else
                    #puts original_sentence_info_hash[j]['match_id'] + ' :word_choice_mistake 16'
                    #puts corrected_sentence_info_hash[i]['match_id'] + ' :word_choice_mistake_opposite 17'
                    wrong_info[original_sentence_info_hash[j]['token']] = 'word_choice_mistake'
                    correct_info[corrected_sentence_info_hash[i]['token']] = 'word_choice_mistake_opposite'
                    combined_hash[combined_hash.length] = wrong_info
                    combined_hash[combined_hash.length] = correct_info
                    #puts combined_hash.to_s + ' :word_choice_mistake 16'
                  end
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
                  correct_info[corrected_sentence_info_hash[i]['token']] = 'word_order_mistake'
                  combined_hash[combined_hash.length] = correct_info
                  #puts combined_hash.to_s + ' :word_order_mistake 17'
                else
                  #puts '17.1 corrected sentence word: ' + corrected_sentence_info_hash[i]['token'].to_s
                  #puts '17.1 student sentence word: ' + original_sentence_info_hash[word_order_key]['token'].to_s
                  #puts '17.1 corrected sentence pos_tag: ' + corrected_sentence_info_hash[i]['pos_tag'].to_s
                  if ChatCorrect::Verb.new(word: corrected_sentence_info_hash[i]['token'], pos: 'vb', text: original_sentence_info_hash[word_order_key]['token']).verb_error?
                    #puts corrected_sentence_info_hash[i]['match_id'] + ' :verb_mistake_opposite 17.001'
                    correct_info[corrected_sentence_info_hash[i]['token']] = 'verb_mistake_opposite'
                    combined_hash[combined_hash.length] = correct_info
                    #puts combined_hash.to_s + ' :verb_mistake_opposite 17.001'
                    #puts original_sentence_info_hash[j]['match_id'] + ' :verb_mistake 17.002'
                    wrong_info[original_sentence_info_hash[word_order_key]['token']] = 'verb_mistake'
                    combined_hash[combined_hash.length] = wrong_info
                    #puts combined_hash.to_s + ' :verb_mistake 17.002'
                  elsif ChatCorrect::Pluralization.new(token_a: corrected_sentence_info_hash[i]['token'], token_b: original_sentence_info_hash[word_order_key]['token']).pluralization_error?
                    #puts corrected_sentence_info_hash[i]['match_id'] + ' :pluralization_mistake_opposite 17.01'
                    correct_info[corrected_sentence_info_hash[i]['token']] = 'pluralization_mistake_opposite'
                    combined_hash[combined_hash.length] = correct_info
                    #puts combined_hash.to_s + ' :pluralization_mistake_opposite 17.01'
                    #puts original_sentence_info_hash[j]['match_id'] + ' :pluralization_mistake 17.02'
                    wrong_info[original_sentence_info_hash[word_order_key]['token']] = 'pluralization_mistake'
                    combined_hash[combined_hash.length] = wrong_info
                    #puts combined_hash.to_s + ' :pluralization_mistake 17.02'
                  else
                    #puts corrected_sentence_info_hash[i]['match_id'] + ' :missing_word_mistake 17.1'
                    correct_info[corrected_sentence_info_hash[i]['token']] = 'missing_word_mistake'
                    combined_hash[combined_hash.length] = correct_info
                    #puts combined_hash.to_s + ' :missing_word_mistake 17.1'
                    #puts original_sentence_info_hash[j]['match_id'] + ' :unnecessary_word_mistake 17.2'
                    wrong_info[original_sentence_info_hash[word_order_key]['token']] = 'unnecessary_word_mistake'
                    combined_hash[combined_hash.length] = wrong_info
                    #puts combined_hash.to_s + ' :unnecessary_word_mistake 17.2'
                  end
                end
                j +=1
              else
                if corrected_sentence_info_hash[i]['token'].gsub(/[[:punct:]]/, '') == ''
                  #puts corrected_sentence_info_hash[i]['match_id'] + ' :punctuation_mistake_mistake 18'
                  correct_info[corrected_sentence_info_hash[i]['token']] = 'punctuation_mistake'
                  combined_hash[combined_hash.length] = correct_info
                  #puts combined_hash.to_s + ' :punctuation_mistake_mistake 18'
                else
                  unless j == 0
                    #puts 'Student sentence word: ' + original_sentence_info_hash[j - 1]['token'].to_s
                    concatenated_corrected_string = corrected_sentence_info_hash[i - 1]['token'].to_s + corrected_sentence_info_hash[i]['token'].to_s
                    #puts 'Corrected sentence word: ' + concatenated_corrected_string
                    #puts check_possessive(original_sentence_info_hash[j - 1]['token'], concatenated_corrected_string).to_s
                    if ChatCorrect::Possessive.new(token_a: original_sentence_info_hash[j - 1]['token'], token_b: concatenated_corrected_string).possessive?
                      #puts original_sentence_info_hash[j - 1]['match_id'] + ' :possessive_mistake 19'
                      #puts corrected_sentence_info_hash[i]['match_id'] + ' :possessive_mistake_opposite 19.1'
                      wrong_info[original_sentence_info_hash[j - 1]['token']] = 'possessive_mistake'
                      correct_info[concatenated_corrected_string] = 'possessive_mistake_opposite'
                      combined_hash[combined_hash.length - 1] = wrong_info
                      combined_hash[combined_hash.length] = correct_info
                      #puts combined_hash.to_s + ' :possessive_mistake 19'
                    else
                      #puts corrected_sentence_info_hash[i]['match_id'] + ' :missing_word_mistake 19'
                      correct_info[corrected_sentence_info_hash[i]['token']] = 'missing_word_mistake'
                      combined_hash[combined_hash.length] = correct_info
                      #puts combined_hash.to_s + ' :missing_word_mistake 19'
                    end
                  else
                    #puts corrected_sentence_info_hash[i]['match_id'] + ' :missing_word_mistake 19'
                    correct_info[corrected_sentence_info_hash[i]['token']] = 'missing_word_mistake'
                    combined_hash[combined_hash.length] = correct_info
                    #puts combined_hash.to_s + ' :missing_word_mistake 19'
                  end
                end
              end
              i +=1
            when original_sentence_info_hash[j]['match_id'].to_s[0] == 's'
              if original_sentence_info_hash[j]['token'].gsub(/[[:punct:]]/, '') == '' || original_sentence_info_hash[j]['token'] == '∯' || original_sentence_info_hash[j]['token'] == '∬' || original_sentence_info_hash[j]['token'] == '∫' || original_sentence_info_hash[j]['token'] == '∮'
                #puts original_sentence_info_hash[j]['match_id'] + ' :punctuation_mistake_mistake 20'
                wrong_info[original_sentence_info_hash[j]['token']] = 'punctuation_mistake'
                combined_hash[combined_hash.length] = wrong_info
                #puts combined_hash.to_s + ' :punctuation_mistake_mistake 20'
                final_matched_id_array << original_sentence_info_hash[j]['match_id'].to_s
              else
                #puts original_sentence_info_hash[j]['match_id'] + ' :unnecessary_word_mistake 21'
                wrong_info[original_sentence_info_hash[j]['token']] = 'unnecessary_word_mistake'
                combined_hash[combined_hash.length] = wrong_info
                #puts combined_hash.to_s + ' :unnecessary_word_mistake 21'
                final_matched_id_array << original_sentence_info_hash[j]['match_id'].to_s
              end
              j +=1
            when original_sentence_info_hash[j]['match_id'].to_s[0] == 'd'
              #puts original_sentence_info_hash[j]['match_id'] + ' :duplicate_word_mistake 22'
              wrong_info[original_sentence_info_hash[j]['token']] = 'duplicate_word_mistake'
              combined_hash[combined_hash.length] = wrong_info
              #puts combined_hash.to_s + ' :duplicate_word_mistake 22'
              j +=1
          end
        end
      end
      original_sentence_info_hash.each do |k, v|
        if v['match_id'].to_s[0] == 's' && final_matched_id_array.include?(v['match_id'].to_s) == false #&& k >= corrected_sentence_info_hash.length
          #puts 'Longer: ' + v['match_id'].to_s
          if v['token'].gsub(/[[:punct:]]/, '') == '' || v['token'] == '∯' || v['token'] == '∬' || v['token'] == '∫' || v['token'] == '∮'
            #puts v['match_id'] + ' :punctuation_mistake 23'
            #puts 'Wrong Info: ' + wrong_info.to_s
            wrong_info = Hash.new
            wrong_info[v['token']] = 'punctuation_mistake'
            #puts 'Wrong Info: ' + wrong_info.to_s
            combined_hash[combined_hash.length] = wrong_info
            #puts combined_hash.to_s + ' :punctuation_mistake 23'
            final_matched_id_array << v['match_id'].to_s
          else
            #puts v['match_id'] + ' :unnecessary_word_mistake 24'
            wrong_info = Hash.new
            wrong_info[v['token']] = 'unnecessary_word_mistake'
            combined_hash[combined_hash.length] = wrong_info
            #puts combined_hash.to_s + ' :unnecessary_word_mistake 24'
            final_matched_id_array << v['match_id'].to_s
          end
        end
      end
      # Final stylistic check (for contractions)
      # Irregular contractions: 'ain't', 'don't', 'won't', 'shan't'
      combined_hash.each do |k, v|
        #puts 'Layout hash (k): ' + k.to_s
        #puts 'Layout hash (v): ' + v.to_s
        v.each do |k1, v1|
          #puts 'Layout hash (k1): ' + k1.to_s
          #puts 'Layout hash (v1): ' + v1.to_s
          if k1.include?('ƪ') == true && v1.include?('missing_word_mistake') && combined_hash[k - 1].to_s.include?('unnecessary_word_mistake') && combined_hash[k - 2].to_s.include?('unnecessary_word_mistake')
            #puts contraction_check(combined_hash[k - 2].key('unnecessary_word_mistake').to_s, combined_hash[k - 1].key('unnecessary_word_mistake').to_s, k1.to_s).to_s
            #puts combined_hash[k - 1].key('unnecessary_word_mistake').to_s
            #puts combined_hash[k - 2].key('unnecessary_word_mistake').to_s
            if ChatCorrect::Contraction.new(token_a: combined_hash[k - 2].key('unnecessary_word_mistake').to_s, token_b: combined_hash[k - 1].key('unnecessary_word_mistake').to_s, contraction: k1.to_s).contraction?
              combined_hash[k][k1] = 'stylistic_choice_opposite'
              combined_hash[k - 1][combined_hash[k - 1].key('unnecessary_word_mistake')] = 'stylistic_choice'
              combined_hash[k - 2][combined_hash[k - 2].key('unnecessary_word_mistake')] = 'stylistic_choice'
            end
          end
          if k1.include?('ƪ') == true && v1.include?('missing_word_mistake') && combined_hash[k + 1].to_s.include?('unnecessary_word_mistake') && combined_hash[k + 2].to_s.include?('unnecessary_word_mistake')
            #puts contraction_check(combined_hash[k + 2].key('unnecessary_word_mistake').to_s, combined_hash[k + 1].key('unnecessary_word_mistake').to_s, k1.to_s).to_s
            #puts combined_hash[k + 1].key('unnecessary_word_mistake').to_s
            #puts combined_hash[k + 2].key('unnecessary_word_mistake').to_s
            if ChatCorrect::Contraction.new(token_a: combined_hash[k + 2].key('unnecessary_word_mistake').to_s, token_b: combined_hash[k + 1].key('unnecessary_word_mistake').to_s, contraction: k1.to_s).contraction?
              combined_hash[k][k1] = 'stylistic_choice_opposite'
              combined_hash[k + 1][combined_hash[k + 1].key('unnecessary_word_mistake')] = 'stylistic_choice'
              combined_hash[k + 2][combined_hash[k + 2].key('unnecessary_word_mistake')] = 'stylistic_choice'
            end
          end
          if k1.include?('ƪ') == true && v1.include?('unnecessary_word_mistake') && combined_hash[k + 1].to_s.include?('missing_word_mistake') && combined_hash[k + 2].to_s.include?('missing_word_mistake')
            #puts contraction_check(combined_hash[k + 1].key('missing_word_mistake').to_s, combined_hash[k + 2].key('missing_word_mistake').to_s, k1.to_s).to_s
            #puts combined_hash[k + 1].key('missing_word_mistake').to_s
            #puts combined_hash[k + 2].key('missing_word_mistake').to_s
            if ChatCorrect::Contraction.new(token_a: combined_hash[k + 1].key('missing_word_mistake').to_s, token_b: combined_hash[k + 2].key('missing_word_mistake').to_s,  contraction: k1.to_s).contraction?
              combined_hash[k][k1] = 'stylistic_choice'
              combined_hash[k + 1][combined_hash[k + 1].key('missing_word_mistake')] = 'stylistic_choice_opposite'
              combined_hash[k + 2][combined_hash[k + 2].key('missing_word_mistake')] = 'stylistic_choice_opposite'
            end
          end
          if k1.include?('ƪ') == true && v1.include?('unnecessary_word_mistake') && combined_hash[k - 1].to_s.include?('missing_word_mistake') && combined_hash[k - 2].to_s.include?('missing_word_mistake')
            #puts contraction_check(combined_hash[k - 2].key('missing_word_mistake').to_s, combined_hash[k - 1].key('missing_word_mistake').to_s, k1.to_s).to_s
            #puts combined_hash[k - 1].key('missing_word_mistake').to_s
            #puts combined_hash[k - 2].key('missing_word_mistake').to_s
            if ChatCorrect::Contraction.new(token_a: combined_hash[k - 2].key('missing_word_mistake').to_s, token_b: combined_hash[k - 1].key('missing_word_mistake').to_s,  contraction: k1.to_s).contraction?
              combined_hash[k][k1] = 'stylistic_choice'
              combined_hash[k - 1][combined_hash[k - 1].key('missing_word_mistake')] = 'stylistic_choice_opposite'
              combined_hash[k - 2][combined_hash[k - 2].key('missing_word_mistake')] = 'stylistic_choice_opposite'
            end
          end
          if k1.include?('ƪ') == true && v1.include?('verb_mistake') && combined_hash[k + 1].to_s.include?('verb_mistake_opposite')
            #puts 'Split sentences k1: ' + k1.gsub(/ƪ/o, "'").split.to_s
            if ChatCorrect::Contraction.new(token_a: combined_hash[k + 1].key('verb_mistake_opposite').to_s.split[0].to_s, token_b: combined_hash[k + 1].key('verb_mistake_opposite').to_s.split[1].to_s,  contraction: k1.gsub(/ƪ/o, "'").split[0].to_s.gsub(/'/o, 'ƪ')).contraction?
              combined_hash[k][k1] = 'stylistic_choice'
              combined_hash[k + 1][combined_hash[k + 1].key('verb_mistake_opposite')] = 'stylistic_choice_opposite'
            end
          end
          if k1.include?('ƪ') == true && v1.include?('verb_mistake_opposite') && combined_hash[k - 1].to_s.include?('verb_mistake')
            #puts 'Split sentences k1: ' + k1.gsub(/ƪ/o, "'").split.to_s
            #puts combined_hash[k - 1].key('verb_mistake').to_s
            #puts contraction_check(combined_hash[k - 1].key('verb_mistake').to_s.split[0].to_s, combined_hash[k - 1].key('verb_mistake').to_s.split[1].to_s, k1.gsub(/ƪ/o, "'").split[0].to_s).to_s
            #puts combined_hash[k - 1].key('verb_mistake').to_s.split[0].to_s
            #puts combined_hash[k - 1].key('verb_mistake').to_s.split[1].to_s
            #puts k1.gsub(/ƪ/o, "'").split[0].to_s
            if ChatCorrect::Contraction.new(token_a: combined_hash[k - 1].key('verb_mistake').to_s.split[0].to_s, token_b: combined_hash[k - 1].key('verb_mistake').to_s.split[1].to_s,  contraction: k1.gsub(/ƪ/o, "'").split[0].to_s.gsub(/'/o, 'ƪ')).contraction?
              combined_hash[k][k1] = 'stylistic_choice_opposite'
              combined_hash[k - 1][combined_hash[k - 1].key('verb_mistake')] = 'stylistic_choice'
            end
          end
        end
      end
      combined_hash.to_json
    end
  end
end