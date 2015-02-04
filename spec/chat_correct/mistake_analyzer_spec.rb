require 'spec_helper'

RSpec.describe ChatCorrect::MistakeAnalyzer do
  context '#no_mistake?' do
    it 'returns true if there is no mistake' do
      original = {"token"=>"shopping", "prev_word1"=>"go", "prev_word2"=>"need", "next_word1"=>"at", "next_word2"=>"this", "num_char"=>8, "position"=>3, "multiple_words"=>false, "lowercase"=>"shopping", "pos_tag"=>"nn", "punctuation"=>false, "duplicates"=>false, "uid"=>"original3", "matched"=>false, "is_time"=>false, "match_id"=>"c4"}
      corrected = {"token"=>"shopping", "prev_word1"=>"go", "prev_word2"=>"to", "next_word1"=>"this", "next_word2"=>"weekend", "num_char"=>8, "position"=>4, "multiple_words"=>false, "lowercase"=>"shopping", "match_id"=>"c4", "pos_tag"=>"nn", "punctuation"=>false, "duplicates"=>false, "uid"=>"corrected4", "matched"=>true, "is_time"=>false}
      cc = ChatCorrect::MistakeAnalyzer.new(original: original, corrected: corrected)
      expect(cc.no_mistake?).to eq(true)
    end

    it 'returns false if there is a mistake' do
      original = {"token"=>"hello", "prev_word1"=>"go", "prev_word2"=>"need", "next_word1"=>"at", "next_word2"=>"this", "num_char"=>8, "position"=>3, "multiple_words"=>false, "lowercase"=>"shopping", "pos_tag"=>"nn", "punctuation"=>false, "duplicates"=>false, "uid"=>"original3", "matched"=>false, "is_time"=>false, "match_id"=>"c4"}
      corrected = {"token"=>"shopping", "prev_word1"=>"go", "prev_word2"=>"to", "next_word1"=>"this", "next_word2"=>"weekend", "num_char"=>8, "position"=>4, "multiple_words"=>false, "lowercase"=>"shopping", "match_id"=>"c4", "pos_tag"=>"nn", "punctuation"=>false, "duplicates"=>false, "uid"=>"corrected4", "matched"=>true, "is_time"=>false}
      cc = ChatCorrect::MistakeAnalyzer.new(original: original, corrected: corrected)
      expect(cc.no_mistake?).to eq(false)
    end
  end

  context '#verb_mistake?' do
    it 'returns true if there is a verb mistake' do
      original = {"token"=>"flied", "prev_word1"=>"I", "prev_word2"=>"ȸ", "next_word1"=>"home", "next_word2"=>"yesterday", "num_char"=>5, "position"=>1, "multiple_words"=>false, "lowercase"=>"flied", "pos_tag"=>"vbd", "punctuation"=>false, "duplicates"=>false, "uid"=>"original1", "matched"=>false, "is_time"=>false, "match_id"=>"c1"}
      corrected = {"token"=>"flew", "prev_word1"=>"I", "prev_word2"=>"ȸ", "next_word1"=>"home", "next_word2"=>"yesterday", "num_char"=>4, "position"=>1, "multiple_words"=>false, "lowercase"=>"flew", "match_id"=>"c1", "pos_tag"=>"vbd", "punctuation"=>false, "duplicates"=>false, "uid"=>"corrected1", "matched"=>true, "is_time"=>false}
      cc = ChatCorrect::MistakeAnalyzer.new(original: original, corrected: corrected)
      expect(cc.verb_mistake?).to eq(true)
    end

    it 'returns false if there is not a verb mistake' do
      original = {"token"=>"!", "prev_word1"=>"misspeellings", "prev_word2"=>"consecutiveee", "next_word1"=>"ȹ", "next_word2"=>"ȹ", "num_char"=>1, "position"=>7, "multiple_words"=>false, "lowercase"=>"!", "pos_tag"=>"pp", "punctuation"=>true, "duplicates"=>false, "uid"=>"original7", "matched"=>false, "is_time"=>false, "match_id"=>"c7"}
      corrected = {"token"=>".", "prev_word1"=>"misspellings", "prev_word2"=>"consecutive", "next_word1"=>"ȹ", "next_word2"=>"ȹ", "num_char"=>1, "position"=>7, "multiple_words"=>false, "lowercase"=>".", "match_id"=>"c7", "pos_tag"=>"pp", "punctuation"=>true, "duplicates"=>false, "uid"=>"corrected7", "matched"=>true, "is_time"=>false}
      cc = ChatCorrect::MistakeAnalyzer.new(original: original, corrected: corrected)
      expect(cc.verb_mistake?).to eq(false)
    end
  end

  context '#capitalization_mistake?' do
    it 'returns true if there is a capitalization mistake' do
      original = {"token"=>"is", "prev_word1"=>"ȸ", "prev_word2"=>"ȸ", "next_word1"=>"the", "next_word2"=>",", "num_char"=>2, "position"=>0, "multiple_words"=>false, "lowercase"=>"is", "pos_tag"=>"vbz", "punctuation"=>false, "duplicates"=>false, "uid"=>"original0", "matched"=>false, "is_time"=>false, "match_id"=>"c0"}
      corrected = {"token"=>"Is", "prev_word1"=>"ȸ", "prev_word2"=>"ȸ", "next_word1"=>"the", "next_word2"=>"punctuation", "num_char"=>2, "position"=>0, "multiple_words"=>false, "lowercase"=>"is", "match_id"=>"c0", "pos_tag"=>"nnp", "punctuation"=>false, "duplicates"=>false, "uid"=>"corrected0", "matched"=>true, "is_time"=>false}
      cc = ChatCorrect::MistakeAnalyzer.new(original: original, corrected: corrected)
      expect(cc.capitalization_mistake?).to eq(true)
    end

    it 'returns false if there is not a captialization mistake' do
      original = {"token"=>"!", "prev_word1"=>"misspeellings", "prev_word2"=>"consecutiveee", "next_word1"=>"ȹ", "next_word2"=>"ȹ", "num_char"=>1, "position"=>7, "multiple_words"=>false, "lowercase"=>"!", "pos_tag"=>"pp", "punctuation"=>true, "duplicates"=>false, "uid"=>"original7", "matched"=>false, "is_time"=>false, "match_id"=>"c7"}
      corrected = {"token"=>".", "prev_word1"=>"misspellings", "prev_word2"=>"consecutive", "next_word1"=>"ȹ", "next_word2"=>"ȹ", "num_char"=>1, "position"=>7, "multiple_words"=>false, "lowercase"=>".", "match_id"=>"c7", "pos_tag"=>"pp", "punctuation"=>true, "duplicates"=>false, "uid"=>"corrected7", "matched"=>true, "is_time"=>false}
      cc = ChatCorrect::MistakeAnalyzer.new(original: original, corrected: corrected)
      expect(cc.capitalization_mistake?).to eq(false)
    end
  end

  context '#punctuation_mistake?' do
    it 'returns true if there is a punctuation mistake' do
      original = {"token"=>"!", "prev_word1"=>"misspeellings", "prev_word2"=>"consecutiveee", "next_word1"=>"ȹ", "next_word2"=>"ȹ", "num_char"=>1, "position"=>7, "multiple_words"=>false, "lowercase"=>"!", "pos_tag"=>"pp", "punctuation"=>true, "duplicates"=>false, "uid"=>"original7", "matched"=>false, "is_time"=>false, "match_id"=>"c7"}
      corrected = {"token"=>".", "prev_word1"=>"misspellings", "prev_word2"=>"consecutive", "next_word1"=>"ȹ", "next_word2"=>"ȹ", "num_char"=>1, "position"=>7, "multiple_words"=>false, "lowercase"=>".", "match_id"=>"c7", "pos_tag"=>"pp", "punctuation"=>true, "duplicates"=>false, "uid"=>"corrected7", "matched"=>true, "is_time"=>false}
      cc = ChatCorrect::MistakeAnalyzer.new(original: original, corrected: corrected)
      expect(cc.punctuation_mistake?).to eq(true)
    end

    it 'returns false if there is not a punctuation mistake' do
      original = {"token"=>"is", "prev_word1"=>"ȸ", "prev_word2"=>"ȸ", "next_word1"=>"the", "next_word2"=>",", "num_char"=>2, "position"=>0, "multiple_words"=>false, "lowercase"=>"is", "pos_tag"=>"vbz", "punctuation"=>false, "duplicates"=>false, "uid"=>"original0", "matched"=>false, "is_time"=>false, "match_id"=>"c0"}
      corrected = {"token"=>"Is", "prev_word1"=>"ȸ", "prev_word2"=>"ȸ", "next_word1"=>"the", "next_word2"=>"punctuation", "num_char"=>2, "position"=>0, "multiple_words"=>false, "lowercase"=>"is", "match_id"=>"c0", "pos_tag"=>"nnp", "punctuation"=>false, "duplicates"=>false, "uid"=>"corrected0", "matched"=>true, "is_time"=>false}
      cc = ChatCorrect::MistakeAnalyzer.new(original: original, corrected: corrected)
      expect(cc.punctuation_mistake?).to eq(false)
    end
  end

  context '#unnecessary_word_missing_punctuation_mistake?' do
    it 'returns true if there is an unnecessary word / missing punctuation mistake' do
      original = {"token"=>"when", "prev_word1"=>"Actually", "prev_word2"=>"ȸ", "next_word1"=>"I", "next_word2"=>"attended", "num_char"=>4, "position"=>1, "multiple_words"=>false, "lowercase"=>"when", "pos_tag"=>"wrb", "punctuation"=>false, "duplicates"=>false, "uid"=>"original1", "matched"=>false, "is_time"=>false, "match_id"=>"c1"}
      corrected = {"token"=>",", "prev_word1"=>"Actually", "prev_word2"=>"ȸ", "next_word1"=>"I", "next_word2"=>"attended", "num_char"=>1, "position"=>1, "multiple_words"=>false, "lowercase"=>",", "match_id"=>"c1", "pos_tag"=>"ppc", "punctuation"=>true, "duplicates"=>false, "uid"=>"corrected1", "matched"=>true, "is_time"=>false}
      cc = ChatCorrect::MistakeAnalyzer.new(original: original, corrected: corrected)
      expect(cc.unnecessary_word_missing_punctuation_mistake?).to eq(true)
    end

    it 'returns false if there is not an unnecessary word / missing punctuation mistake' do
      original = {"token"=>"is", "prev_word1"=>"ȸ", "prev_word2"=>"ȸ", "next_word1"=>"the", "next_word2"=>",", "num_char"=>2, "position"=>0, "multiple_words"=>false, "lowercase"=>"is", "pos_tag"=>"vbz", "punctuation"=>false, "duplicates"=>false, "uid"=>"original0", "matched"=>false, "is_time"=>false, "match_id"=>"c0"}
      corrected = {"token"=>"Is", "prev_word1"=>"ȸ", "prev_word2"=>"ȸ", "next_word1"=>"the", "next_word2"=>"punctuation", "num_char"=>2, "position"=>0, "multiple_words"=>false, "lowercase"=>"is", "match_id"=>"c0", "pos_tag"=>"nnp", "punctuation"=>false, "duplicates"=>false, "uid"=>"corrected0", "matched"=>true, "is_time"=>false}
      cc = ChatCorrect::MistakeAnalyzer.new(original: original, corrected: corrected)
      expect(cc.unnecessary_word_missing_punctuation_mistake?).to eq(false)
    end
  end

  context '#spelling_mistake?' do
    it 'returns true if there is a spelling mistake' do
      original = {"token"=>"puncttuation", "prev_word1"=>",", "prev_word2"=>"the", "next_word1"=>"are", "next_word2"=>"wrong", "num_char"=>12, "position"=>3, "multiple_words"=>false, "lowercase"=>"puncttuation", "pos_tag"=>"nn", "punctuation"=>false, "duplicates"=>false, "uid"=>"original3", "matched"=>false, "is_time"=>false, "match_id"=>"c2"}
      corrected = {"token"=>"punctuation", "prev_word1"=>"the", "prev_word2"=>"Is", "next_word1"=>"wrong", "next_word2"=>"?", "num_char"=>11, "position"=>2, "multiple_words"=>false, "lowercase"=>"punctuation", "match_id"=>"c2", "pos_tag"=>"nn", "punctuation"=>false, "duplicates"=>false, "uid"=>"corrected2", "matched"=>true, "is_time"=>false}
      cc = ChatCorrect::MistakeAnalyzer.new(original: original, corrected: corrected)
      expect(cc.spelling_mistake?).to eq(true)
    end

    it 'returns false if there is not a spelling mistake' do
      original = {"token"=>"is", "prev_word1"=>"ȸ", "prev_word2"=>"ȸ", "next_word1"=>"the", "next_word2"=>",", "num_char"=>2, "position"=>0, "multiple_words"=>false, "lowercase"=>"is", "pos_tag"=>"vbz", "punctuation"=>false, "duplicates"=>false, "uid"=>"original0", "matched"=>false, "is_time"=>false, "match_id"=>"c0"}
      corrected = {"token"=>"Is", "prev_word1"=>"ȸ", "prev_word2"=>"ȸ", "next_word1"=>"the", "next_word2"=>"punctuation", "num_char"=>2, "position"=>0, "multiple_words"=>false, "lowercase"=>"is", "match_id"=>"c0", "pos_tag"=>"nnp", "punctuation"=>false, "duplicates"=>false, "uid"=>"corrected0", "matched"=>true, "is_time"=>false}
      cc = ChatCorrect::MistakeAnalyzer.new(original: original, corrected: corrected)
      expect(cc.spelling_mistake?).to eq(false)
    end
  end
end
