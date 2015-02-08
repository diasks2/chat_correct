module ChatCorrect
  class Correct
    TYPES_OF_MISTAKES = ['missing_word', 'unnecessary_word', 'spelling', 'verb', 'punctuation', 'word_order', 'capitalization', 'duplicate_word', 'word_choice', 'pluralization', 'possessive', 'stylistic_choice']
    attr_reader :original_sentence, :corrected_sentence, :tgr
    def initialize(original_sentence:, corrected_sentence:)
      @original_sentence = original_sentence
      @corrected_sentence = corrected_sentence
      @tgr = EngTagger.new
      Linguistics.use(:en)
    end

    def correct
      raise "You must include an Original Sentence" if original_sentence.nil? || original_sentence.eql?('')
      raise "You must include a Corrected Sentence" if corrected_sentence.nil? || corrected_sentence.eql?('')
      analyze
    end

    def mistakes
      raise "You must include an Original Sentence" if original_sentence.nil? || original_sentence.eql?('')
      raise "You must include a Corrected Sentence" if corrected_sentence.nil? || corrected_sentence.eql?('')
      mistakes_hash = {}
      analyze.each do |key, value|
        next if (!value['type'].split('_')[-1].eql?('mistake') && !value['type'].split('_')[0].eql?('missing')) || value['type'].split('_')[0].eql?('no')
        mistakes_hash = build_mistakes_hash(mistakes_hash, key, value)
      end
      mistakes_hash
    end

    def mistake_report
      raise "You must include an Original Sentence" if original_sentence.nil? || original_sentence.eql?('')
      raise "You must include a Corrected Sentence" if corrected_sentence.nil? || corrected_sentence.eql?('')
      mistake_report_hash = {}
      TYPES_OF_MISTAKES.each do |mistake|
        counter = 0
        mistakes.each do |key, value|
          counter += 1 if value['error_type'].eql?(mistake) || value['error_type'].split('_')[1].eql?(mistake)
        end
        mistake_report_hash[mistake] = counter
      end
      mistake_report_hash
    end

    def number_of_mistakes
      raise "You must include an Original Sentence" if original_sentence.nil? || original_sentence.eql?('')
      raise "You must include a Corrected Sentence" if corrected_sentence.nil? || corrected_sentence.eql?('')
      mistakes.length
    end

    private

    def analyze
      @analyze ||= iterate_stages
    end

    def iterate_stages
      stage_1
      # debug
      stage_2
      # debug
      iterate_sentences('stage_3')
      # debug
      iterate_sentences('stage_4')
      # debug
      iterate_sentences('stage_5')
      # debug
      iterate_sentences('stage_6')
      # debug
      iterate_sentences('stage_7')
      # debug
      stage_8
      # debug
      prev_next_match_check
      # debug
      stage_9
      # debug
      correction_hash = ChatCorrect::CorrectionsHash.new(original_sentence_info_hash: original_sentence_info_hash, corrected_sentence_info_hash: corrected_sentence_info_hash).create
      build_corrections_hash(correction_hash)
    end

    def update_interim_hash_with_error(interim_hash, value)
      if value['type'].split('_').length > 2
        if value['type'].split('_')[1].eql?('punctuation')
          interim_hash['error_type'] = 'punctuation'
        else
          interim_hash['error_type'] = value['type'].split('_')[0] + '_' + value['type'].split('_')[1]
        end
      else
        interim_hash['error_type'] = value['type'].split('_')[0]
      end
      interim_hash
    end

    def update_interim_hash_with_correction(interim_hash, key)
      if correct[key]['type'].split('_')[1].eql?('order')
        interim_hash['correction'] = 'N/A'
      elsif correct[key + 1]['type'].split('_')[0].eql?(correct[key]['type'].split('_')[0])
        interim_hash['correction'] = correct[key + 1]['token']
      else
        interim_hash['correction'] = ''
      end
      interim_hash
    end

    def build_mistakes_hash(mistakes_hash, key, value)
      interim_hash = {}
      interim_hash['position'] = key
      interim_hash = update_interim_hash_with_error(interim_hash, value)
      if value['type'].split('_')[1].eql?('order')
        if mistakes_hash.length.eql?(0) || mistakes_hash[0]['error_type'].eql?('unnecessary_word') || mistakes_hash[0]['error_type'].eql?('word_order')
          interim_hash['mistake'] = reverse_symbols(original_sentence_info_hash[key]['token'])
        else
          interim_hash['mistake'] = reverse_symbols(original_sentence_info_hash[key - 1]['token'])
        end
      elsif value['type'].split('_').length > 2 && value['type'].split('_')[1].eql?('punctuation')
        interim_hash['mistake'] = ''
      else
        interim_hash['mistake'] = value['token']
      end
      if correct[key + 1].blank? && value['type'].split('_')[1].eql?('order')
        interim_hash['correction'] = 'N/A'
      else
        interim_hash = update_interim_hash_with_correction(interim_hash, key) unless correct[key + 1].blank?
      end
      mistakes_hash[mistakes_hash.length] = interim_hash
      mistakes_hash
    end

    def build_corrections_hash(correction_hash)
      final_hash = {}
      correction_hash.each do |k, v|
        interim_hash = {}
        interim_hash['token'] = reverse_symbols(v.keys[0])
        interim_hash['type'] = v.values[0]
        final_hash[k] = interim_hash
      end
      final_hash
    end

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
      @original_sentence_tokenized ||= ChatCorrect::CombineMultiWordVerbs.new(text: original_sentence, tgr: tgr).combine
    end

    def corrected_sentence_tokenized
      @corrected_sentence_tokenized ||= ChatCorrect::CombineMultiWordVerbs.new(text: corrected_sentence, tgr: tgr).combine
    end

    def original_sentence_tagged
      @original_sentence_tagged ||= tgr.add_tags(original_sentence).split
    end

    def corrected_sentence_tagged
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

    def write_match_to_info_hash(ks, kc, vc)
      original_sentence_info_hash[ks]['match_id'] = vc['match_id']
      corrected_sentence_info_hash[kc]['matched'] = true
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
        if !vc['matched']
          prev_match_vc = set_previous_match(kc, corrected_sentence_info_hash)
          next_match_vc = set_next_match(kc, corrected_sentence_info_hash)
          original_sentence_info_hash.each do |ks, vs|
            prev_match_vs = set_previous_match(ks, original_sentence_info_hash)
            next_match_vs = set_next_match(ks, original_sentence_info_hash)
            next if vs['match_id']
            next unless prev_match_vc.eql?(prev_match_vs) && next_match_vc.eql?(next_match_vs)
            original_sentence_info_hash[ks]['match_id'] = vc['match_id']
            corrected_sentence_info_hash[kc]['matched'] = true
          end
        end
      end
    end

    def set_previous_match(key, hash)
      if key.eql?(0)
        'ȸ'
      else
        hash[key - 1]['match_id']
      end
    end

    def set_next_match(key, hash)
      if key.eql?(hash.length - 1)
        'ȹ'
      else
        hash[key + 1]['match_id']
      end
    end

    def debug
      # puts "++++++++++++++++++++"
      # original_sentence_info_hash.each do |k, v|
        # puts 'Key: ' + k.to_s + '; Word: ' + v['token'].to_s + '; Match ID: ' + v['match_id'].to_s
      # end
    end

    def stage_1
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
          end
        end
      end
    end

    def stage_2
      corrected_sentence_info_hash.each do |kc, vc|
        if !vc['matched']
          prev_match_vc = set_previous_match(kc, corrected_sentence_info_hash)
            next_match_vc = set_next_match(kc, corrected_sentence_info_hash)
            if kc.eql?(corrected_sentence_info_hash.length - 1)
              next_word_vc = 'ȹ'
            else
              next_word_vc = corrected_sentence_info_hash[kc + 1]['token']
            end
          original_sentence_info_hash.each do |ks, vs|
            prev_match_vs = set_previous_match(ks, original_sentence_info_hash)
            next_match_vs = set_next_match(ks, original_sentence_info_hash)
            if ks.eql?(original_sentence_info_hash.length - 1)
              next_word_vs = 'ȹ'
            else
              next_word_vs = original_sentence_info_hash[ks + 1]['token']
            end
            next if vs['match_id']
            if prev_match_vc.eql?(prev_match_vs) && next_match_vc.eql?(next_match_vs)
              original_sentence_info_hash[ks]['match_id'] = vc['match_id']
              corrected_sentence_info_hash[kc]['matched'] = true
            end
            next unless vs['token'].eql?(next_word_vs) && vs['token'] != next_word_vc
            original_sentence_info_hash[ks]['match_id'] = 'd' + ks.to_s
          end
        end
      end
    end

    def iterate_sentences(inner_method)
      corrected_sentence_info_hash.each do |kc, vc|
        next if vc['matched']
        original_sentence_info_hash.each do |ks, vs|
          next if !vs['match_id'].to_s.strip.empty?
          send("#{inner_method}", kc, vc, ks, vs)
        end
      end
    end

    def stage_3(kc, vc, ks, vs)
      return if vc['token'] != vs['token'] ||
      (vc['prev_word1'] != vs['prev_word1'] && vc['next_word1'] != vs['next_word1']) ||
      vc['matched'] || vs['prev_word1'].eql?('ȸ')
        write_match_to_info_hash(ks, kc, vc)
    end

    def stage_4(kc, vc, ks, vs)
      return if vc['token'].length < 4 || vs['token'].length < 4 ||
      Text::Levenshtein.distance(vc['token'], vs['token']) > 2 || vc['matched']
        write_match_to_info_hash(ks, kc, vc)
    end

    def stage_5(kc, vc, ks, vs)
      return if !ChatCorrect::Pluralization.new(token_a: vc['token'], token_b: vs['token']).pluralization_error? ||
      vc['matched']
        write_match_to_info_hash(ks, kc, vc)
    end

    def stage_6(kc, vc, ks, vs)
      return if !ChatCorrect::Verb.new(word: vs['token'], pos: vc['pos_tag'], text: vc['token']).verb_error? ||
      (vc['prev_word1'] != vs['prev_word1'] && vc['next_word1'] != vs['next_word1']) ||
      vc['matched'] || vs['next_word1'].include?(' ')
        write_match_to_info_hash(ks, kc, vc)
    end

    def stage_7(kc, vc, ks, vs)
      # Distance between position of words is currently hardcoded to 5,
      # but this is a SWAG and can be adjusted based on testing.
      # The idea is to stop the algorithm from matching words like 'to'
      # and 'the' that appear very far apart in the sentence and should not be matched.
      return if vc['token'].length < 2 ||
      vs['token'].length < 2 ||
      Text::Levenshtein.distance(vc['token'], vs['token']) > 2 ||
      vs['token'].to_s[0] != vc['token'].to_s[0] ||
      (vs['position'].to_i - vc['position'].to_i).abs > 4 ||
      vc['matched']
        write_match_to_info_hash(ks, kc, vc)
    end

    def stage_8
      corrected_sentence_info_hash.each do |kc, vc|
        if !vc['matched']
          next_match_vc = set_next_match(kc, corrected_sentence_info_hash)
          original_sentence_info_hash.each do |ks, vs|
            next_match_vs = set_next_match(ks, original_sentence_info_hash)
            next if vs['match_id']
            write_match_to_info_hash(ks, kc, vc) if vs['multiple_words'] && vc['multiple_words'] && !vc['matched']
            write_match_to_info_hash(ks, kc, vc) if next_match_vc.eql?('ȹ') && next_match_vs.eql?('ȹ') && vs['token'].gsub(/[[:punct:]]/, '').eql?('') && vc['token'].gsub(/[[:punct:]]/, '').eql?('') && !vc['matched']
          end
        end
      end
    end

    def stage_9
      original_sentence_info_hash.each do |k, v|
        next if v['match_id']
        original_sentence_info_hash[k]['match_id'] = 's' + k.to_s
      end
    end
  end
end