require 'spec_helper'

RSpec.describe ChatCorrect::Correct do
  context "example correction #001 (no mistakes)" do
    before do
      original_sentence = 'There are no mistakes here.'
      corrected_sentence = 'There are no mistakes here.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0 => {'token' => 'There', 'type' => 'no_mistake'}, 1 => {'token' => 'are', 'type' => 'no_mistake'},  2 => {'token' => 'no', 'type' => 'no_mistake'},  3 => {'token' => 'mistakes', 'type' => 'no_mistake'}, 4 => {'token' => 'here', 'type' => 'no_mistake'}, 5 => {'token' => '.', 'type' => 'no_mistake'}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(0)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({'missing_word' => 0, 'unnecessary_word' => 0, 'spelling' => 0, 'verb' => 0, 'punctuation' => 0, 'word_order' => 0, 'capitalization' => 0, 'duplicate_word' => 0, 'word_choice' => 0, 'pluralization' => 0, 'possessive' => 0, 'stylistic_choice' => 0})
    end
  end

  context "example correction #002" do
    before do
      original_sentence = 'is the, puncttuation are wrong.'
      corrected_sentence = 'Is the punctuation wrong?'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0 => {'token' => 'is', 'type' => 'capitalization_mistake'}, 1 => {'token' => 'Is', 'type' => 'capitalization_correction'},  2 => {'token' => 'the', 'type' => 'no_mistake'},  3 => {'token' => ',', 'type' => 'punctuation_mistake'}, 4 => {'token' => 'puncttuation', 'type' => 'spelling_mistake'}, 5 => {'token' => 'punctuation', 'type' => 'spelling_correction'}, 6 => {'token' => 'are', 'type' => 'unnecessary_word_mistake'},  7 => {'token' => 'wrong', 'type' => 'no_mistake'},  8 => {'token' => '.', 'type' => 'punctuation_mistake'},  9 => {'token' => '?', 'type' => 'punctuation_correction'}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0 => {'position' => 0, 'error_type' => 'capitalization', 'mistake' => 'is', 'correction' => 'Is'}, 1 => {'position' => 3, 'error_type' => 'punctuation', 'mistake' => ',', 'correction' => ''}, 2 => {'position' => 4, 'error_type' => 'spelling', 'mistake' => 'puncttuation', 'correction' => 'punctuation'},  3 => {'position' => 6, 'error_type' => 'unnecessary_word', 'mistake' => 'are', 'correction' => ''},  4 => {'position' => 8, 'error_type' => 'punctuation', 'mistake' => '.', 'correction' => '?'}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(5)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({'missing_word' => 0, 'unnecessary_word' => 1, 'spelling' => 1, 'verb' => 0, 'punctuation' => 2, 'word_order' => 0, 'capitalization' => 1, 'duplicate_word' => 0, 'word_choice' => 0, 'pluralization' => 0, 'possessive' => 0, 'stylistic_choice' => 0 })
    end
  end

  context "example correction #003" do
    before do
      original_sentence = 'I need go shopping at this weekend.'
      corrected_sentence = 'I need to go shopping this weekend.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"I", "type"=>"no_mistake"}, 1=>{"token"=>"need", "type"=>"no_mistake"}, 2=>{"token"=>"to", "type"=>"missing_word_mistake"}, 3=>{"token"=>"go", "type"=>"no_mistake"}, 4=>{"token"=>"shopping", "type"=>"no_mistake"}, 5=>{"token"=>"at", "type"=>"unnecessary_word_mistake"}, 6=>{"token"=>"this", "type"=>"no_mistake"}, 7=>{"token"=>"weekend", "type"=>"no_mistake"}, 8=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>2, "error_type"=>"missing_word", "mistake"=>"to", "correction"=>""}, 1=>{"position"=>5, "error_type"=>"unnecessary_word", "mistake"=>"at", "correction"=>""}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(2)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>1, "unnecessary_word"=>1, "spelling"=>0, "verb"=>0, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #004" do
    before do
      original_sentence = 'I go trip last month.'
      corrected_sentence = 'I went on a trip last month.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"I", "type"=>"no_mistake"}, 1=>{"token"=>"go", "type"=>"verb_mistake"}, 2=>{"token"=>"went", "type"=>"verb_correction"}, 3=>{"token"=>"on", "type"=>"missing_word_mistake"}, 4=>{"token"=>"a", "type"=>"missing_word_mistake"}, 5=>{"token"=>"trip", "type"=>"no_mistake"}, 6=>{"token"=>"last", "type"=>"no_mistake"}, 7=>{"token"=>"month", "type"=>"no_mistake"}, 8=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>1, "error_type"=>"verb", "mistake"=>"go", "correction"=>"went"}, 1=>{"position"=>3, "error_type"=>"missing_word", "mistake"=>"on", "correction"=>"a"}, 2=>{"position"=>4, "error_type"=>"missing_word", "mistake"=>"a", "correction"=>""}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(3)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>2, "unnecessary_word"=>0, "spelling"=>0, "verb"=>1, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #005" do
    before do
      original_sentence = 'This is an exclamation.'
      corrected_sentence = 'This is an exclamation!'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"This", "type"=>"no_mistake"}, 1=>{"token"=>"is", "type"=>"no_mistake"}, 2=>{"token"=>"an", "type"=>"no_mistake"}, 3=>{"token"=>"exclamation", "type"=>"no_mistake"}, 4=>{"token"=>".", "type"=>"punctuation_mistake"}, 5=>{"token"=>"!", "type"=>"punctuation_correction"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>4, "error_type"=>"punctuation", "mistake"=>".", "correction"=>"!"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(1)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>0, "punctuation"=>1, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #006" do
    before do
      original_sentence = 'what am i thinking!'
      corrected_sentence = 'What was I thinking?'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"what", "type"=>"capitalization_mistake"}, 1=>{"token"=>"What", "type"=>"capitalization_correction"}, 2=>{"token"=>"am", "type"=>"verb_mistake"}, 3=>{"token"=>"was", "type"=>"verb_correction"}, 4=>{"token"=>"i", "type"=>"capitalization_mistake"}, 5=>{"token"=>"I", "type"=>"capitalization_correction"}, 6=>{"token"=>"thinking", "type"=>"no_mistake"}, 7=>{"token"=>"!", "type"=>"punctuation_mistake"}, 8=>{"token"=>"?", "type"=>"punctuation_correction"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>0, "error_type"=>"capitalization", "mistake"=>"what", "correction"=>"What"}, 1=>{"position"=>2, "error_type"=>"verb", "mistake"=>"am", "correction"=>"was"}, 2=>{"position"=>4, "error_type"=>"capitalization", "mistake"=>"i", "correction"=>"I"}, 3=>{"position"=>7, "error_type"=>"punctuation", "mistake"=>"!", "correction"=>"?"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(4)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>1, "punctuation"=>1, "word_order"=>0, "capitalization"=>2, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #007" do
    before do
      original_sentence = 'There arre lotts of misspeellings.'
      corrected_sentence = 'There are a lot of misspellings.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"There", "type"=>"no_mistake"}, 1=>{"token"=>"arre", "type"=>"spelling_mistake"}, 2=>{"token"=>"are", "type"=>"spelling_correction"}, 3=>{"token"=>"a", "type"=>"missing_word_mistake"}, 4=>{"token"=>"lotts", "type"=>"spelling_mistake"}, 5=>{"token"=>"lot", "type"=>"spelling_correction"}, 6=>{"token"=>"of", "type"=>"no_mistake"}, 7=>{"token"=>"misspeellings", "type"=>"spelling_mistake"}, 8=>{"token"=>"misspellings", "type"=>"spelling_correction"}, 9=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>1, "error_type"=>"spelling", "mistake"=>"arre", "correction"=>"are"}, 1=>{"position"=>3, "error_type"=>"missing_word", "mistake"=>"a", "correction"=>""}, 2=>{"position"=>4, "error_type"=>"spelling", "mistake"=>"lotts", "correction"=>"lot"}, 3=>{"position"=>7, "error_type"=>"spelling", "mistake"=>"misspeellings", "correction"=>"misspellings"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(4)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>1, "unnecessary_word"=>0, "spelling"=>3, "verb"=>0, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #008" do
    before do
      original_sentence = 'There arre lotts, off consecutiveee misspeellings!'
      corrected_sentence = 'There are a lot of consecutive misspellings.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"There", "type"=>"no_mistake"}, 1=>{"token"=>"arre", "type"=>"spelling_mistake"}, 2=>{"token"=>"are", "type"=>"spelling_correction"}, 3=>{"token"=>"a", "type"=>"missing_word_mistake"}, 4=>{"token"=>"lotts", "type"=>"spelling_mistake"}, 5=>{"token"=>"lot", "type"=>"spelling_correction"}, 6=>{"token"=>",", "type"=>"punctuation_mistake"}, 7=>{"token"=>"off", "type"=>"spelling_mistake"}, 8=>{"token"=>"of", "type"=>"spelling_correction"}, 9=>{"token"=>"consecutiveee", "type"=>"spelling_mistake"}, 10=>{"token"=>"consecutive", "type"=>"spelling_correction"}, 11=>{"token"=>"misspeellings", "type"=>"spelling_mistake"}, 12=>{"token"=>"misspellings", "type"=>"spelling_correction"}, 13=>{"token"=>"!", "type"=>"punctuation_mistake"}, 14=>{"token"=>".", "type"=>"punctuation_correction"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>1, "error_type"=>"spelling", "mistake"=>"arre", "correction"=>"are"}, 1=>{"position"=>3, "error_type"=>"missing_word", "mistake"=>"a", "correction"=>""}, 2=>{"position"=>4, "error_type"=>"spelling", "mistake"=>"lotts", "correction"=>"lot"}, 3=>{"position"=>6, "error_type"=>"punctuation", "mistake"=>",", "correction"=>""}, 4=>{"position"=>7, "error_type"=>"spelling", "mistake"=>"off", "correction"=>"of"}, 5=>{"position"=>9, "error_type"=>"spelling", "mistake"=>"consecutiveee", "correction"=>"consecutive"}, 6=>{"position"=>11, "error_type"=>"spelling", "mistake"=>"misspeellings", "correction"=>"misspellings"}, 7=>{"position"=>13, "error_type"=>"punctuation", "mistake"=>"!", "correction"=>"."}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(8)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>1, "unnecessary_word"=>0, "spelling"=>5, "verb"=>0, "punctuation"=>2, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #009" do
    before do
      original_sentence = 'This is a double double double word check.'
      corrected_sentence = 'This is a double word check.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"This", "type"=>"no_mistake"}, 1=>{"token"=>"is", "type"=>"no_mistake"}, 2=>{"token"=>"a", "type"=>"no_mistake"}, 3=>{"token"=>"double", "type"=>"duplicate_word_mistake"}, 4=>{"token"=>"double", "type"=>"duplicate_word_mistake"}, 5=>{"token"=>"double", "type"=>"no_mistake"}, 6=>{"token"=>"word", "type"=>"no_mistake"}, 7=>{"token"=>"check", "type"=>"no_mistake"}, 8=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>3, "error_type"=>"duplicate_word", "mistake"=>"double", "correction"=>"double"}, 1=>{"position"=>4, "error_type"=>"duplicate_word", "mistake"=>"double", "correction"=>""}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(2)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>0, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>2, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #010" do
    before do
      original_sentence = 'This is and this and this is a correct double word check!'
      corrected_sentence = 'This is and this and this is a correct double word check.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"This", "type"=>"no_mistake"}, 1=>{"token"=>"is", "type"=>"no_mistake"}, 2=>{"token"=>"and", "type"=>"no_mistake"}, 3=>{"token"=>"this", "type"=>"no_mistake"}, 4=>{"token"=>"and", "type"=>"no_mistake"}, 5=>{"token"=>"this", "type"=>"no_mistake"}, 6=>{"token"=>"is", "type"=>"no_mistake"}, 7=>{"token"=>"a", "type"=>"no_mistake"}, 8=>{"token"=>"correct", "type"=>"no_mistake"}, 9=>{"token"=>"double", "type"=>"no_mistake"}, 10=>{"token"=>"word", "type"=>"no_mistake"}, 11=>{"token"=>"check", "type"=>"no_mistake"}, 12=>{"token"=>"!", "type"=>"punctuation_mistake"}, 13=>{"token"=>".", "type"=>"punctuation_correction"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>12, "error_type"=>"punctuation", "mistake"=>"!", "correction"=>"."}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(1)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>0, "punctuation"=>1, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #011" do
    before do
      original_sentence = 'He said, "Shhe is a crazy girl".'
      corrected_sentence = 'He said, "She is a crazy girl."'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"He", "type"=>"no_mistake"}, 1=>{"token"=>"said", "type"=>"no_mistake"}, 2=>{"token"=>",", "type"=>"no_mistake"}, 3=>{"token"=>"\"", "type"=>"no_mistake"}, 4=>{"token"=>"Shhe", "type"=>"spelling_mistake"}, 5=>{"token"=>"She", "type"=>"spelling_correction"}, 6=>{"token"=>"is", "type"=>"no_mistake"}, 7=>{"token"=>"a", "type"=>"no_mistake"}, 8=>{"token"=>"crazy", "type"=>"no_mistake"}, 9=>{"token"=>"girl", "type"=>"no_mistake"}, 10=>{"token"=>".", "type"=>"word_order_mistake"}, 11=>{"token"=>"\"", "type"=>"word_order_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>4, "error_type"=>"spelling", "mistake"=>"Shhe", "correction"=>"She"}, 1=>{"position"=>10, "error_type"=>"word_order", "mistake"=>"\"", "correction"=>"N/A"}, 2=>{"position"=>11, "error_type"=>"word_order", "mistake"=>".", "correction"=>"N/A"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(3)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>1, "verb"=>0, "punctuation"=>0, "word_order"=>2, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #012" do
    before do
      original_sentence = 'Test the order word.'
      corrected_sentence = 'Test the word order.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"Test", "type"=>"no_mistake"}, 1=>{"token"=>"the", "type"=>"no_mistake"}, 2=>{"token"=>"word", "type"=>"word_order_mistake"}, 3=>{"token"=>"order", "type"=>"word_order_mistake"}, 4=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>2, "error_type"=>"word_order", "mistake"=>"order", "correction"=>"N/A"}, 1=>{"position"=>3, "error_type"=>"word_order", "mistake"=>"word", "correction"=>"N/A"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(2)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>0, "punctuation"=>0, "word_order"=>2, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #013" do
    before do
      original_sentence = 'This is a double double double double word check.'
      corrected_sentence = 'This is a double word check.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"This", "type"=>"no_mistake"}, 1=>{"token"=>"is", "type"=>"no_mistake"}, 2=>{"token"=>"a", "type"=>"no_mistake"}, 3=>{"token"=>"double", "type"=>"duplicate_word_mistake"}, 4=>{"token"=>"double", "type"=>"duplicate_word_mistake"}, 5=>{"token"=>"double", "type"=>"duplicate_word_mistake"}, 6=>{"token"=>"double", "type"=>"no_mistake"}, 7=>{"token"=>"word", "type"=>"no_mistake"}, 8=>{"token"=>"check", "type"=>"no_mistake"}, 9=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>3, "error_type"=>"duplicate_word", "mistake"=>"double", "correction"=>"double"}, 1=>{"position"=>4, "error_type"=>"duplicate_word", "mistake"=>"double", "correction"=>"double"}, 2=>{"position"=>5, "error_type"=>"duplicate_word", "mistake"=>"double", "correction"=>""}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(3)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>0, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>3, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #014" do
    before do
      original_sentence = 'I call my mom tomorrow.'
      corrected_sentence = 'I will call my mom tomorrow.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"I", "type"=>"no_mistake"}, 1=>{"token"=>"call", "type"=>"verb_mistake"}, 2=>{"token"=>"will call", "type"=>"verb_correction"}, 3=>{"token"=>"my", "type"=>"no_mistake"}, 4=>{"token"=>"mom", "type"=>"no_mistake"}, 5=>{"token"=>"tomorrow", "type"=>"no_mistake"}, 6=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>1, "error_type"=>"verb", "mistake"=>"call", "correction"=>"will call"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(1)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>1, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #015" do
    before do
      original_sentence = 'I flied home yesterday.'
      corrected_sentence = 'I flew home yesterday.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"I", "type"=>"no_mistake"}, 1=>{"token"=>"flied", "type"=>"verb_mistake"}, 2=>{"token"=>"flew", "type"=>"verb_correction"}, 3=>{"token"=>"home", "type"=>"no_mistake"}, 4=>{"token"=>"yesterday", "type"=>"no_mistake"}, 5=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>1, "error_type"=>"verb", "mistake"=>"flied", "correction"=>"flew"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(1)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>1, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #016" do
    before do
      original_sentence = "This shouldn't be use to test contractions, but couln't it?"
      corrected_sentence = "This shouldn't be used to test contractions, but couldn't it?"
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"This", "type"=>"no_mistake"}, 1=>{"token"=>"shouldn't", "type"=>"no_mistake"}, 2=>{"token"=>"be", "type"=>"no_mistake"}, 3=>{"token"=>"use", "type"=>"verb_mistake"}, 4=>{"token"=>"used", "type"=>"verb_correction"}, 5=>{"token"=>"to", "type"=>"no_mistake"}, 6=>{"token"=>"test", "type"=>"no_mistake"}, 7=>{"token"=>"contractions", "type"=>"no_mistake"}, 8=>{"token"=>",", "type"=>"no_mistake"}, 9=>{"token"=>"but", "type"=>"no_mistake"}, 10=>{"token"=>"couln't", "type"=>"spelling_mistake"}, 11=>{"token"=>"couldn't", "type"=>"spelling_correction"}, 12=>{"token"=>"it", "type"=>"no_mistake"}, 13=>{"token"=>"?", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>3, "error_type"=>"verb", "mistake"=>"use", "correction"=>"used"}, 1=>{"position"=>10, "error_type"=>"spelling", "mistake"=>"couln't", "correction"=>"couldn't"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(2)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>1, "verb"=>1, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #017" do
    before do
      original_sentence = "This is to test, 'single quotes'."
      corrected_sentence = "This is to test, 'Single quotes.'"
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"This", "type"=>"no_mistake"}, 1=>{"token"=>"is", "type"=>"no_mistake"}, 2=>{"token"=>"to", "type"=>"no_mistake"}, 3=>{"token"=>"test", "type"=>"no_mistake"}, 4=>{"token"=>",", "type"=>"no_mistake"}, 5=>{"token"=>"'", "type"=>"no_mistake"}, 6=>{"token"=>"single", "type"=>"capitalization_mistake"}, 7=>{"token"=>"Single", "type"=>"capitalization_correction"}, 8=>{"token"=>"quotes", "type"=>"no_mistake"}, 9=>{"token"=>".", "type"=>"word_order_mistake"}, 10=>{"token"=>"'", "type"=>"word_order_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>6, "error_type"=>"capitalization", "mistake"=>"single", "correction"=>"Single"}, 1=>{"position"=>9, "error_type"=>"word_order", "mistake"=>"'", "correction"=>"N/A"}, 2=>{"position"=>10, "error_type"=>"word_order", "mistake"=>".", "correction"=>"N/A"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(3)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>0, "punctuation"=>0, "word_order"=>2, "capitalization"=>1, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #018" do
    before do
      original_sentence = 'This is to test quotations "again"'
      corrected_sentence = 'This is to test quotations again'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"This", "type"=>"no_mistake"}, 1=>{"token"=>"is", "type"=>"no_mistake"}, 2=>{"token"=>"to", "type"=>"no_mistake"}, 3=>{"token"=>"test", "type"=>"no_mistake"}, 4=>{"token"=>"quotations", "type"=>"no_mistake"}, 5=>{"token"=>"\"", "type"=>"punctuation_mistake"}, 6=>{"token"=>"again", "type"=>"no_mistake"}, 7=>{"token"=>"\"", "type"=>"punctuation_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>5, "error_type"=>"punctuation", "mistake"=>"\"", "correction"=>""}, 1=>{"position"=>7, "error_type"=>"punctuation", "mistake"=>"\""}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(2)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>0, "punctuation"=>2, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #019" do
    before do
      original_sentence = 'I will call my mom yesterday.'
      corrected_sentence = 'I called my mom yesterday.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"I", "type"=>"no_mistake"}, 1=>{"token"=>"will call", "type"=>"verb_mistake"}, 2=>{"token"=>"called", "type"=>"verb_correction"}, 3=>{"token"=>"my", "type"=>"no_mistake"}, 4=>{"token"=>"mom", "type"=>"no_mistake"}, 5=>{"token"=>"yesterday", "type"=>"no_mistake"}, 6=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>1, "error_type"=>"verb", "mistake"=>"will call", "correction"=>"called"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(1)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>1, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #020" do
    before do
      original_sentence = 'Test run the order word with anotther mistake.'
      corrected_sentence = 'Test the word order with another simple mistake.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"Test", "type"=>"no_mistake"}, 1=>{"token"=>"run", "type"=>"unnecessary_word_mistake"}, 2=>{"token"=>"the", "type"=>"no_mistake"}, 3=>{"token"=>"word", "type"=>"word_order_mistake"}, 4=>{"token"=>"order", "type"=>"word_order_mistake"}, 5=>{"token"=>"with", "type"=>"no_mistake"}, 6=>{"token"=>"anotther", "type"=>"spelling_mistake"}, 7=>{"token"=>"another", "type"=>"spelling_correction"}, 8=>{"token"=>"simple", "type"=>"missing_word_mistake"}, 9=>{"token"=>"mistake", "type"=>"no_mistake"}, 10=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>1, "error_type"=>"unnecessary_word", "mistake"=>"run", "correction"=>""}, 1=>{"position"=>3, "error_type"=>"word_order", "mistake"=>"order", "correction"=>"N/A"}, 2=>{"position"=>4, "error_type"=>"word_order", "mistake"=>"word", "correction"=>"N/A"}, 3=>{"position"=>6, "error_type"=>"spelling", "mistake"=>"anotther", "correction"=>"another"}, 4=>{"position"=>8, "error_type"=>"missing_word", "mistake"=>"simple", "correction"=>""}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(5)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>1, "unnecessary_word"=>1, "spelling"=>1, "verb"=>0, "punctuation"=>0, "word_order"=>2, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #021" do
    before do
      original_sentence = 'This is to test quotations "again".'
      corrected_sentence = 'This is to test quotations again.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"This", "type"=>"no_mistake"}, 1=>{"token"=>"is", "type"=>"no_mistake"}, 2=>{"token"=>"to", "type"=>"no_mistake"}, 3=>{"token"=>"test", "type"=>"no_mistake"}, 4=>{"token"=>"quotations", "type"=>"no_mistake"}, 5=>{"token"=>"\"", "type"=>"punctuation_mistake"}, 6=>{"token"=>"again", "type"=>"no_mistake"}, 7=>{"token"=>"\"", "type"=>"punctuation_mistake"}, 8=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>5, "error_type"=>"punctuation", "mistake"=>"\"", "correction"=>""}, 1=>{"position"=>7, "error_type"=>"punctuation", "mistake"=>"\"", "correction"=>""}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(2)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>0, "punctuation"=>2, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #022" do
    before do
      original_sentence = 'This is to test quotations "again"'
      corrected_sentence = 'This is to test quotations again.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"This", "type"=>"no_mistake"}, 1=>{"token"=>"is", "type"=>"no_mistake"}, 2=>{"token"=>"to", "type"=>"no_mistake"}, 3=>{"token"=>"test", "type"=>"no_mistake"}, 4=>{"token"=>"quotations", "type"=>"no_mistake"}, 5=>{"token"=>"\"", "type"=>"punctuation_mistake"}, 6=>{"token"=>"again", "type"=>"no_mistake"}, 7=>{"token"=>"\"", "type"=>"punctuation_mistake"}, 8=>{"token"=>".", "type"=>"punctuation_correction"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>5, "error_type"=>"punctuation", "mistake"=>"\"", "correction"=>""}, 1=>{"position"=>7, "error_type"=>"punctuation", "mistake"=>"\"", "correction"=>"."}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(2)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>0, "punctuation"=>2, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #023" do
    before do
      original_sentence = "He didn't realize that he should had changed the locks."
      corrected_sentence = "He hadn't realized that he should have changed the locks."
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"He", "type"=>"no_mistake"}, 1=>{"token"=>"didn't realize", "type"=>"verb_mistake"}, 2=>{"token"=>"hadn't realized", "type"=>"verb_correction"}, 3=>{"token"=>"that", "type"=>"no_mistake"}, 4=>{"token"=>"he", "type"=>"no_mistake"}, 5=>{"token"=>"should", "type"=>"no_mistake"}, 6=>{"token"=>"had changed", "type"=>"verb_mistake"}, 7=>{"token"=>"have changed", "type"=>"verb_correction"}, 8=>{"token"=>"the", "type"=>"no_mistake"}, 9=>{"token"=>"locks", "type"=>"no_mistake"}, 10=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>1, "error_type"=>"verb", "mistake"=>"didn't realize", "correction"=>"hadn't realized"}, 1=>{"position"=>6, "error_type"=>"verb", "mistake"=>"had changed", "correction"=>"have changed"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(2)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>2, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #024" do
    before do
      original_sentence = 'I will call my mom yesterday if I had time.'
      corrected_sentence = 'I would have called my mom yesterday if I had had time.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"I", "type"=>"no_mistake"}, 1=>{"token"=>"will call", "type"=>"verb_mistake"}, 2=>{"token"=>"would have called", "type"=>"verb_correction"}, 3=>{"token"=>"my", "type"=>"no_mistake"}, 4=>{"token"=>"mom", "type"=>"no_mistake"}, 5=>{"token"=>"yesterday", "type"=>"no_mistake"}, 6=>{"token"=>"if", "type"=>"no_mistake"}, 7=>{"token"=>"I", "type"=>"no_mistake"}, 8=>{"token"=>"had", "type"=>"no_mistake"}, 9=>{"token"=>"had", "type"=>"missing_word_mistake"}, 10=>{"token"=>"time", "type"=>"no_mistake"}, 11=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>1, "error_type"=>"verb", "mistake"=>"will call", "correction"=>"would have called"}, 1=>{"position"=>9, "error_type"=>"missing_word", "mistake"=>"had", "correction"=>""}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(2)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>1, "unnecessary_word"=>0, "spelling"=>0, "verb"=>1, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #025" do
    before do
      original_sentence = 'I call my mom yesterday.'
      corrected_sentence = 'I would have called my mom yesterday.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"I", "type"=>"no_mistake"}, 1=>{"token"=>"call", "type"=>"verb_mistake"}, 2=>{"token"=>"would have called", "type"=>"verb_correction"}, 3=>{"token"=>"my", "type"=>"no_mistake"}, 4=>{"token"=>"mom", "type"=>"no_mistake"}, 5=>{"token"=>"yesterday", "type"=>"no_mistake"}, 6=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>1, "error_type"=>"verb", "mistake"=>"call", "correction"=>"would have called"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(1)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>1, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #026" do
    before do
      original_sentence = 'I singed at the karaoke bar.'
      corrected_sentence = 'I sang at the karaoke bar.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"I", "type"=>"no_mistake"}, 1=>{"token"=>"singed", "type"=>"verb_mistake"}, 2=>{"token"=>"sang", "type"=>"verb_correction"}, 3=>{"token"=>"at", "type"=>"no_mistake"}, 4=>{"token"=>"the", "type"=>"no_mistake"}, 5=>{"token"=>"karaoke", "type"=>"no_mistake"}, 6=>{"token"=>"bar", "type"=>"no_mistake"}, 7=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>1, "error_type"=>"verb", "mistake"=>"singed", "correction"=>"sang"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(1)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>1, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #027" do
    before do
      original_sentence = 'I flied to California and go to zoo.'
      corrected_sentence = 'I flew to California and went to the zoo.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"I", "type"=>"no_mistake"}, 1=>{"token"=>"flied", "type"=>"verb_mistake"}, 2=>{"token"=>"flew", "type"=>"verb_correction"}, 3=>{"token"=>"to", "type"=>"no_mistake"}, 4=>{"token"=>"California", "type"=>"no_mistake"}, 5=>{"token"=>"and", "type"=>"no_mistake"}, 6=>{"token"=>"go", "type"=>"verb_mistake"}, 7=>{"token"=>"went", "type"=>"verb_correction"}, 8=>{"token"=>"to", "type"=>"no_mistake"}, 9=>{"token"=>"the", "type"=>"missing_word_mistake"}, 10=>{"token"=>"zoo", "type"=>"no_mistake"}, 11=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>1, "error_type"=>"verb", "mistake"=>"flied", "correction"=>"flew"}, 1=>{"position"=>6, "error_type"=>"verb", "mistake"=>"go", "correction"=>"went"}, 2=>{"position"=>9, "error_type"=>"missing_word", "mistake"=>"the", "correction"=>""}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(3)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>1, "unnecessary_word"=>0, "spelling"=>0, "verb"=>2, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #028" do
    before do
      original_sentence = 'This is a double double double double double word check.'
      corrected_sentence = 'This is a double word check.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"This", "type"=>"no_mistake"}, 1=>{"token"=>"is", "type"=>"no_mistake"}, 2=>{"token"=>"a", "type"=>"no_mistake"}, 3=>{"token"=>"double", "type"=>"duplicate_word_mistake"}, 4=>{"token"=>"double", "type"=>"duplicate_word_mistake"}, 5=>{"token"=>"double", "type"=>"duplicate_word_mistake"}, 6=>{"token"=>"double", "type"=>"duplicate_word_mistake"}, 7=>{"token"=>"double", "type"=>"no_mistake"}, 8=>{"token"=>"word", "type"=>"no_mistake"}, 9=>{"token"=>"check", "type"=>"no_mistake"}, 10=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>3, "error_type"=>"duplicate_word", "mistake"=>"double", "correction"=>"double"}, 1=>{"position"=>4, "error_type"=>"duplicate_word", "mistake"=>"double", "correction"=>"double"}, 2=>{"position"=>5, "error_type"=>"duplicate_word", "mistake"=>"double", "correction"=>"double"}, 3=>{"position"=>6, "error_type"=>"duplicate_word", "mistake"=>"double", "correction"=>""}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(4)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>0, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>4, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #029" do
    before do
      original_sentence = 'This is a double double double double double double word check.'
      corrected_sentence = 'This is a double word check.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"This", "type"=>"no_mistake"}, 1=>{"token"=>"is", "type"=>"no_mistake"}, 2=>{"token"=>"a", "type"=>"no_mistake"}, 3=>{"token"=>"double", "type"=>"duplicate_word_mistake"}, 4=>{"token"=>"double", "type"=>"duplicate_word_mistake"}, 5=>{"token"=>"double", "type"=>"duplicate_word_mistake"}, 6=>{"token"=>"double", "type"=>"duplicate_word_mistake"}, 7=>{"token"=>"double", "type"=>"duplicate_word_mistake"}, 8=>{"token"=>"double", "type"=>"no_mistake"}, 9=>{"token"=>"word", "type"=>"no_mistake"}, 10=>{"token"=>"check", "type"=>"no_mistake"}, 11=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>3, "error_type"=>"duplicate_word", "mistake"=>"double", "correction"=>"double"}, 1=>{"position"=>4, "error_type"=>"duplicate_word", "mistake"=>"double", "correction"=>"double"}, 2=>{"position"=>5, "error_type"=>"duplicate_word", "mistake"=>"double", "correction"=>"double"}, 3=>{"position"=>6, "error_type"=>"duplicate_word", "mistake"=>"double", "correction"=>"double"}, 4=>{"position"=>7, "error_type"=>"duplicate_word", "mistake"=>"double", "correction"=>""}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(5)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>0, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>5, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #030" do
    before do
      original_sentence = 'If my school were located in Tokyo, situation would have quite changed.'
      corrected_sentence = 'If my school were located in Tokyo, the situation would have been quite different.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"If", "type"=>"no_mistake"}, 1=>{"token"=>"my", "type"=>"no_mistake"}, 2=>{"token"=>"school", "type"=>"no_mistake"}, 3=>{"token"=>"were located", "type"=>"no_mistake"}, 4=>{"token"=>"in", "type"=>"no_mistake"}, 5=>{"token"=>"Tokyo", "type"=>"no_mistake"}, 6=>{"token"=>",", "type"=>"no_mistake"}, 7=>{"token"=>"the", "type"=>"missing_word_mistake"}, 8=>{"token"=>"situation", "type"=>"no_mistake"}, 9=>{"token"=>"would have", "type"=>"verb_mistake"}, 10=>{"token"=>"would have been", "type"=>"verb_correction"}, 11=>{"token"=>"quite", "type"=>"no_mistake"}, 12=>{"token"=>"changed", "type"=>"word_choice_mistake"}, 13=>{"token"=>"different", "type"=>"word_choice_correction"}, 14=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>7, "error_type"=>"missing_word", "mistake"=>"the", "correction"=>""}, 1=>{"position"=>9, "error_type"=>"verb", "mistake"=>"would have", "correction"=>"would have been"}, 2=>{"position"=>12, "error_type"=>"word_choice", "mistake"=>"changed", "correction"=>"different"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(3)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>1, "unnecessary_word"=>0, "spelling"=>0, "verb"=>1, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>1, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #031" do
    before do
      original_sentence = 'However, I think a success in life comes from careful planning when it is a usual situation.'
      corrected_sentence = 'However, under normal circumstances, I think success in life comes from careful planning.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"However", "type"=>"no_mistake"}, 1=>{"token"=>",", "type"=>"no_mistake"}, 2=>{"token"=>"under", "type"=>"missing_word_mistake"}, 3=>{"token"=>"normal", "type"=>"missing_word_mistake"}, 4=>{"token"=>"circumstances", "type"=>"missing_word_mistake"}, 5=>{"token"=>",", "type"=>"punctuation_mistake"}, 6=>{"token"=>"I", "type"=>"no_mistake"}, 7=>{"token"=>"think", "type"=>"no_mistake"}, 8=>{"token"=>"a", "type"=>"unnecessary_word_mistake"}, 9=>{"token"=>"success", "type"=>"no_mistake"}, 10=>{"token"=>"in", "type"=>"no_mistake"}, 11=>{"token"=>"life", "type"=>"no_mistake"}, 12=>{"token"=>"comes", "type"=>"no_mistake"}, 13=>{"token"=>"from", "type"=>"no_mistake"}, 14=>{"token"=>"careful", "type"=>"no_mistake"}, 15=>{"token"=>"planning", "type"=>"no_mistake"}, 16=>{"token"=>"when", "type"=>"unnecessary_word_mistake"}, 17=>{"token"=>"it", "type"=>"unnecessary_word_mistake"}, 18=>{"token"=>"is", "type"=>"unnecessary_word_mistake"}, 19=>{"token"=>"a", "type"=>"unnecessary_word_mistake"}, 20=>{"token"=>"usual", "type"=>"unnecessary_word_mistake"}, 21=>{"token"=>"situation", "type"=>"unnecessary_word_mistake"}, 22=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>2, "error_type"=>"missing_word", "mistake"=>"under", "correction"=>"normal"}, 1=>{"position"=>3, "error_type"=>"missing_word", "mistake"=>"normal", "correction"=>"circumstances"}, 2=>{"position"=>4, "error_type"=>"missing_word", "mistake"=>"circumstances", "correction"=>""}, 3=>{"position"=>5, "error_type"=>"punctuation", "mistake"=>",", "correction"=>""}, 4=>{"position"=>8, "error_type"=>"unnecessary_word", "mistake"=>"a", "correction"=>""}, 5=>{"position"=>16, "error_type"=>"unnecessary_word", "mistake"=>"when", "correction"=>"it"}, 6=>{"position"=>17, "error_type"=>"unnecessary_word", "mistake"=>"it", "correction"=>"is"}, 7=>{"position"=>18, "error_type"=>"unnecessary_word", "mistake"=>"is", "correction"=>"a"}, 8=>{"position"=>19, "error_type"=>"unnecessary_word", "mistake"=>"a", "correction"=>"usual"}, 9=>{"position"=>20, "error_type"=>"unnecessary_word", "mistake"=>"usual", "correction"=>"situation"}, 10=>{"position"=>21, "error_type"=>"unnecessary_word", "mistake"=>"situation", "correction"=>""}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(11)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>3, "unnecessary_word"=>7, "spelling"=>0, "verb"=>0, "punctuation"=>1, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #032" do
    before do
      original_sentence = 'He is super rad.'
      corrected_sentence = 'He is super cool!'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"He", "type"=>"no_mistake"}, 1=>{"token"=>"is", "type"=>"no_mistake"}, 2=>{"token"=>"super", "type"=>"no_mistake"}, 3=>{"token"=>"rad", "type"=>"word_choice_mistake"}, 4=>{"token"=>"cool", "type"=>"word_choice_correction"}, 5=>{"token"=>".", "type"=>"punctuation_mistake"}, 6=>{"token"=>"!", "type"=>"punctuation_correction"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>3, "error_type"=>"word_choice", "mistake"=>"rad", "correction"=>"cool"}, 1=>{"position"=>5, "error_type"=>"punctuation", "mistake"=>".", "correction"=>"!"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(2)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>0, "punctuation"=>1, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>1, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #033" do
    before do
      original_sentence = 'I was not going to the party.'
      corrected_sentence = 'I did not go to the party.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"I", "type"=>"no_mistake"}, 1=>{"token"=>"was not going", "type"=>"verb_mistake"}, 2=>{"token"=>"did not go", "type"=>"verb_correction"}, 3=>{"token"=>"to", "type"=>"no_mistake"}, 4=>{"token"=>"the", "type"=>"no_mistake"}, 5=>{"token"=>"party", "type"=>"no_mistake"}, 6=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>1, "error_type"=>"verb", "mistake"=>"was not going", "correction"=>"did not go"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(1)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>1, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #034" do
    before do
      original_sentence = 'I had experiences to support my opinion which a success in life comes from careful planning.'
      corrected_sentence = 'I had experiences which support my opinion that success in life comes from careful planning.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"I", "type"=>"no_mistake"}, 1=>{"token"=>"had", "type"=>"no_mistake"}, 2=>{"token"=>"experiences", "type"=>"no_mistake"}, 3=>{"token"=>"to", "type"=>"word_choice_mistake"}, 4=>{"token"=>"which", "type"=>"word_choice_correction"}, 5=>{"token"=>"support", "type"=>"no_mistake"}, 6=>{"token"=>"my", "type"=>"no_mistake"}, 7=>{"token"=>"opinion", "type"=>"no_mistake"}, 8=>{"token"=>"which", "type"=>"unnecessary_word_mistake"}, 9=>{"token"=>"a", "type"=>"unnecessary_word_mistake"}, 10=>{"token"=>"that", "type"=>"missing_word_mistake"}, 11=>{"token"=>"success", "type"=>"no_mistake"}, 12=>{"token"=>"in", "type"=>"no_mistake"}, 13=>{"token"=>"life", "type"=>"no_mistake"}, 14=>{"token"=>"comes", "type"=>"no_mistake"}, 15=>{"token"=>"from", "type"=>"no_mistake"}, 16=>{"token"=>"careful", "type"=>"no_mistake"}, 17=>{"token"=>"planning", "type"=>"no_mistake"}, 18=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>3, "error_type"=>"word_choice", "mistake"=>"to", "correction"=>"which"}, 1=>{"position"=>8, "error_type"=>"unnecessary_word", "mistake"=>"which", "correction"=>"a"}, 2=>{"position"=>9, "error_type"=>"unnecessary_word", "mistake"=>"a", "correction"=>""}, 3=>{"position"=>10, "error_type"=>"missing_word", "mistake"=>"that", "correction"=>""}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(4)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>1, "unnecessary_word"=>2, "spelling"=>0, "verb"=>0, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>1, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #035" do
    before do
      original_sentence = 'She have a good day yesterday.'
      corrected_sentence = 'hello world'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"She", "type"=>"unnecessary_word_mistake"}, 1=>{"token"=>"have", "type"=>"unnecessary_word_mistake"}, 2=>{"token"=>"a", "type"=>"unnecessary_word_mistake"}, 3=>{"token"=>"good", "type"=>"unnecessary_word_mistake"}, 4=>{"token"=>"day", "type"=>"unnecessary_word_mistake"}, 5=>{"token"=>"yesterday", "type"=>"unnecessary_word_mistake"}, 6=>{"token"=>".", "type"=>"punctuation_mistake"}, 7=>{"token"=>"hello", "type"=>"missing_word_mistake"}, 8=>{"token"=>"world", "type"=>"missing_word_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>0, "error_type"=>"unnecessary_word", "mistake"=>"She", "correction"=>"have"}, 1=>{"position"=>1, "error_type"=>"unnecessary_word", "mistake"=>"have", "correction"=>"a"}, 2=>{"position"=>2, "error_type"=>"unnecessary_word", "mistake"=>"a", "correction"=>"good"}, 3=>{"position"=>3, "error_type"=>"unnecessary_word", "mistake"=>"good", "correction"=>"day"}, 4=>{"position"=>4, "error_type"=>"unnecessary_word", "mistake"=>"day", "correction"=>"yesterday"}, 5=>{"position"=>5, "error_type"=>"unnecessary_word", "mistake"=>"yesterday", "correction"=>""}, 6=>{"position"=>6, "error_type"=>"punctuation", "mistake"=>".", "correction"=>""}, 7=>{"position"=>7, "error_type"=>"missing_word", "mistake"=>"hello", "correction"=>"world"}, 8=>{"position"=>8, "error_type"=>"missing_word", "mistake"=>"world"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(9)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>2, "unnecessary_word"=>6, "spelling"=>0, "verb"=>0, "punctuation"=>1, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #036" do
    before do
      original_sentence = 'If my school were located in Tokyo, situation would have quite changed.'
      corrected_sentence = 'If my school had been located in Tokyo, the situation would have been quite different.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"If", "type"=>"no_mistake"}, 1=>{"token"=>"my", "type"=>"no_mistake"}, 2=>{"token"=>"school", "type"=>"no_mistake"}, 3=>{"token"=>"were located", "type"=>"verb_mistake"}, 4=>{"token"=>"had been located", "type"=>"verb_correction"}, 5=>{"token"=>"in", "type"=>"no_mistake"}, 6=>{"token"=>"Tokyo", "type"=>"no_mistake"}, 7=>{"token"=>",", "type"=>"no_mistake"}, 8=>{"token"=>"the", "type"=>"missing_word_mistake"}, 9=>{"token"=>"situation", "type"=>"no_mistake"}, 10=>{"token"=>"would have", "type"=>"verb_mistake"}, 11=>{"token"=>"would have been", "type"=>"verb_correction"}, 12=>{"token"=>"quite", "type"=>"no_mistake"}, 13=>{"token"=>"changed", "type"=>"word_choice_mistake"}, 14=>{"token"=>"different", "type"=>"word_choice_correction"}, 15=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>3, "error_type"=>"verb", "mistake"=>"were located", "correction"=>"had been located"}, 1=>{"position"=>8, "error_type"=>"missing_word", "mistake"=>"the", "correction"=>""}, 2=>{"position"=>10, "error_type"=>"verb", "mistake"=>"would have", "correction"=>"would have been"}, 3=>{"position"=>13, "error_type"=>"word_choice", "mistake"=>"changed", "correction"=>"different"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(4)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>1, "unnecessary_word"=>0, "spelling"=>0, "verb"=>2, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>1, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #037" do
    before do
      original_sentence = 'I have three child'
      corrected_sentence = 'I have three children.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"I", "type"=>"no_mistake"}, 1=>{"token"=>"have", "type"=>"no_mistake"}, 2=>{"token"=>"three", "type"=>"no_mistake"}, 3=>{"token"=>"child", "type"=>"pluralization_mistake"}, 4=>{"token"=>"children", "type"=>"pluralization_correction"}, 5=>{"token"=>".", "type"=>"missing_punctuation_correction"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>3, "error_type"=>"pluralization", "mistake"=>"child", "correction"=>"children"}, 1=>{"position"=>5, "error_type"=>"punctuation", "mistake"=>""}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(2)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>0, "punctuation"=>1, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>1, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #038" do
    before do
      original_sentence = 'is the bag your'
      corrected_sentence = 'Is the bag yours?'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"is", "type"=>"capitalization_mistake"}, 1=>{"token"=>"Is", "type"=>"capitalization_correction"}, 2=>{"token"=>"the", "type"=>"no_mistake"}, 3=>{"token"=>"bag", "type"=>"no_mistake"}, 4=>{"token"=>"your", "type"=>"pluralization_mistake"}, 5=>{"token"=>"yours", "type"=>"pluralization_correction"}, 6=>{"token"=>"?", "type"=>"missing_punctuation_correction"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>0, "error_type"=>"capitalization", "mistake"=>"is", "correction"=>"Is"}, 1=>{"position"=>4, "error_type"=>"pluralization", "mistake"=>"your", "correction"=>"yours"}, 2=>{"position"=>6, "error_type"=>"punctuation", "mistake"=>""}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(3)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>0, "punctuation"=>1, "word_order"=>0, "capitalization"=>1, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>1, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #039" do
    before do
      original_sentence = 'Is the bag your'
      corrected_sentence = 'Is this your bag?'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"Is", "type"=>"no_mistake"}, 1=>{"token"=>"the", "type"=>"word_choice_mistake"}, 2=>{"token"=>"this", "type"=>"word_choice_correction"}, 3=>{"token"=>"your", "type"=>"word_order_mistake"}, 4=>{"token"=>"bag", "type"=>"word_order_mistake"}, 5=>{"token"=>"?", "type"=>"missing_punctuation_correction"}})
    end

    it 'Reports the mistakes' do
      expect(@cc.mistakes).to eq({0=>{"position"=>1, "error_type"=>"word_choice", "mistake"=>"the", "correction"=>"this"}, 1=>{"position"=>3, "error_type"=>"word_order", "mistake"=>"bag", "correction"=>"N/A"}, 2=>{"position"=>4, "error_type"=>"word_order", "mistake"=>"your", "correction"=>"N/A"}, 3=>{"position"=>5, "error_type"=>"punctuation", "mistake"=>""}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(4)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>0, "punctuation"=>1, "word_order"=>2, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>1, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #040" do
    before do
      original_sentence = 'He doesnt wear a tie.'
      corrected_sentence = "He doesn't wear a tie."
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"He", "type"=>"no_mistake"}, 1=>{"token"=>"doesnt", "type"=>"punctuation_mistake"}, 2=>{"token"=>"doesn't", "type"=>"punctuation_correction"}, 3=>{"token"=>"wear", "type"=>"no_mistake"}, 4=>{"token"=>"a", "type"=>"no_mistake"}, 5=>{"token"=>"tie", "type"=>"no_mistake"}, 6=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(1)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>0, "unnecessary_word"=>0, "spelling"=>0, "verb"=>0, "punctuation"=>1, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>0, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  context "example correction #041" do
    before do
      original_sentence = 'Rather than the TV, I feel the appearance of internet to be more interrupt our communication.'
      corrected_sentence = 'More than TV, I feel the appearance of internet to be more likely to interrupt our communication.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"Rather", "type"=>"word_choice_mistake"}, 1=>{"token"=>"More", "type"=>"word_choice_correction"}, 2=>{"token"=>"than", "type"=>"no_mistake"}, 3=>{"token"=>"the", "type"=>"unnecessary_word_mistake"}, 4=>{"token"=>"TV", "type"=>"no_mistake"}, 5=>{"token"=>",", "type"=>"no_mistake"}, 6=>{"token"=>"I", "type"=>"no_mistake"}, 7=>{"token"=>"feel", "type"=>"no_mistake"}, 8=>{"token"=>"the", "type"=>"no_mistake"}, 9=>{"token"=>"appearance", "type"=>"no_mistake"}, 10=>{"token"=>"of", "type"=>"no_mistake"}, 11=>{"token"=>"internet", "type"=>"no_mistake"}, 12=>{"token"=>"to", "type"=>"no_mistake"}, 13=>{"token"=>"be", "type"=>"no_mistake"}, 14=>{"token"=>"more", "type"=>"no_mistake"}, 15=>{"token"=>"likely", "type"=>"missing_word_mistake"}, 16=>{"token"=>"to", "type"=>"missing_word_mistake"}, 17=>{"token"=>"interrupt", "type"=>"no_mistake"}, 18=>{"token"=>"our", "type"=>"no_mistake"}, 19=>{"token"=>"communication", "type"=>"no_mistake"}, 20=>{"token"=>".", "type"=>"no_mistake"}})
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq(4)
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq({"missing_word"=>2, "unnecessary_word"=>1, "spelling"=>0, "verb"=>0, "punctuation"=>0, "word_order"=>0, "capitalization"=>0, "duplicate_word"=>0, "word_choice"=>1, "pluralization"=>0, "possessive"=>0, "stylistic_choice"=>0})
    end
  end

  # context "example correction #042" do
  #   before do
  #     original_sentence = 'On the other point, we have seldom watched a TV recently than in the past.'
  #     corrected_sentence = 'On the other hand, we seldom watch TV compared to the past.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

    # it 'Annotates the corrections' do
      # #expect(@cc.correct).to eq('')
      # Might want to look into fixing the algo to handle the case of split have + SOME_WORD + verb in the future
      # expect(@cc.correct).to eq("{\"0\":{\"On\":\"no_mistake\"},\"1\":{\"the\":\"no_mistake\"},\"2\":{\"other\":\"no_mistake\"},\"3\":{\"point\":\"word_choice_mistake\"},\"4\":{\"hand\":\"word_choice_mistake_correction\"},\"5\":{\",\":\"no_mistake\"},\"6\":{\"we\":\"no_mistake\"},\"7\":{\"have\":\"unnecessary_word_mistake\"},\"8\":{\"seldom\":\"no_mistake\"},\"9\":{\"watched\":\"verb_mistake\"},\"10\":{\"watch\":\"verb_mistake_correction\"},\"11\":{\"a\":\"unnecessary_word_mistake\"},\"12\":{\"TV\":\"no_mistake\"},\"13\":{\"recently\":\"unnecessary_word_mistake\"},\"14\":{\"than\":\"unnecessary_word_mistake\"},\"15\":{\"in\":\"unnecessary_word_mistake\"},\"16\":{\"compared\":\"missing_word_mistake\"},\"17\":{\"to\":\"missing_word_mistake\"},\"18\":{\"the\":\"no_mistake\"},\"19\":{\"past\":\"no_mistake\"},\"20\":{\".\":\"no_mistake\"}}")
    # end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  # end

  context "example correction #043" do
    before do
      original_sentence = 'That is the why not only we can get information from TV, but also we can get information from the internet nowadays.'
      corrected_sentence = 'That is the reason why not only we can get information from TV, but also we can get information from the internet nowadays.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"That", "type"=>"no_mistake"}, 1=>{"token"=>"is", "type"=>"no_mistake"}, 2=>{"token"=>"the", "type"=>"no_mistake"}, 3=>{"token"=>"reason", "type"=>"missing_word_mistake"}, 4=>{"token"=>"why", "type"=>"no_mistake"}, 5=>{"token"=>"not", "type"=>"no_mistake"}, 6=>{"token"=>"only", "type"=>"no_mistake"}, 7=>{"token"=>"we", "type"=>"no_mistake"}, 8=>{"token"=>"can", "type"=>"no_mistake"}, 9=>{"token"=>"get", "type"=>"no_mistake"}, 10=>{"token"=>"information", "type"=>"no_mistake"}, 11=>{"token"=>"from", "type"=>"no_mistake"}, 12=>{"token"=>"TV", "type"=>"no_mistake"}, 13=>{"token"=>",", "type"=>"no_mistake"}, 14=>{"token"=>"but", "type"=>"no_mistake"}, 15=>{"token"=>"also", "type"=>"no_mistake"}, 16=>{"token"=>"we", "type"=>"no_mistake"}, 17=>{"token"=>"can", "type"=>"no_mistake"}, 18=>{"token"=>"get", "type"=>"no_mistake"}, 19=>{"token"=>"information", "type"=>"no_mistake"}, 20=>{"token"=>"from", "type"=>"no_mistake"}, 21=>{"token"=>"the", "type"=>"no_mistake"}, 22=>{"token"=>"internet", "type"=>"no_mistake"}, 23=>{"token"=>"nowadays", "type"=>"no_mistake"}, 24=>{"token"=>".", "type"=>"no_mistake"}})
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #044" do
    before do
      original_sentence = 'In the other hand, TV topic develop our relationship to provide some topics such as a news, drama, comedy, animation, and so on.'
      corrected_sentence = 'On the other hand, TV topics develop our relationship to provide some topics such as a news, drama, comedy, animation, and so on.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"In", "type"=>"word_choice_mistake"}, 1=>{"token"=>"On", "type"=>"word_choice_correction"}, 2=>{"token"=>"the", "type"=>"no_mistake"}, 3=>{"token"=>"other", "type"=>"no_mistake"}, 4=>{"token"=>"hand", "type"=>"no_mistake"}, 5=>{"token"=>",", "type"=>"no_mistake"}, 6=>{"token"=>"TV", "type"=>"no_mistake"}, 7=>{"token"=>"topic", "type"=>"pluralization_mistake"}, 8=>{"token"=>"topics", "type"=>"pluralization_correction"}, 9=>{"token"=>"develop", "type"=>"no_mistake"}, 10=>{"token"=>"our", "type"=>"no_mistake"}, 11=>{"token"=>"relationship", "type"=>"no_mistake"}, 12=>{"token"=>"to", "type"=>"no_mistake"}, 13=>{"token"=>"provide", "type"=>"no_mistake"}, 14=>{"token"=>"some", "type"=>"no_mistake"}, 15=>{"token"=>"topics", "type"=>"no_mistake"}, 16=>{"token"=>"such", "type"=>"no_mistake"}, 17=>{"token"=>"as", "type"=>"no_mistake"}, 18=>{"token"=>"a", "type"=>"no_mistake"}, 19=>{"token"=>"news", "type"=>"no_mistake"}, 20=>{"token"=>",", "type"=>"no_mistake"}, 21=>{"token"=>"drama", "type"=>"no_mistake"}, 22=>{"token"=>",", "type"=>"no_mistake"}, 23=>{"token"=>"comedy", "type"=>"no_mistake"}, 24=>{"token"=>",", "type"=>"no_mistake"}, 25=>{"token"=>"animation", "type"=>"no_mistake"}, 26=>{"token"=>",", "type"=>"no_mistake"}, 27=>{"token"=>"and", "type"=>"no_mistake"}, 28=>{"token"=>"so", "type"=>"no_mistake"}, 29=>{"token"=>"on", "type"=>"no_mistake"}, 30=>{"token"=>".", "type"=>"no_mistake"}})
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #045" do
    before do
      original_sentence = 'I carried.'
      corrected_sentence = 'I carry'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"I", "type"=>"no_mistake"}, 1=>{"token"=>"carried", "type"=>"verb_mistake"}, 2=>{"token"=>"carry", "type"=>"verb_correction"}, 3=>{"token"=>".", "type"=>"punctuation_mistake"}})
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #046" do
    before do
      original_sentence = 'I went to the store. I bought some eggs.'
      corrected_sentence = 'I went to the store.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"I", "type"=>"no_mistake"}, 1=>{"token"=>"went", "type"=>"no_mistake"}, 2=>{"token"=>"to", "type"=>"no_mistake"}, 3=>{"token"=>"the", "type"=>"no_mistake"}, 4=>{"token"=>"store", "type"=>"no_mistake"}, 5=>{"token"=>".", "type"=>"no_mistake"}, 6=>{"token"=>"I", "type"=>"unnecessary_word_mistake"}, 7=>{"token"=>"bought", "type"=>"unnecessary_word_mistake"}, 8=>{"token"=>"some", "type"=>"unnecessary_word_mistake"}, 9=>{"token"=>"eggs", "type"=>"unnecessary_word_mistake"}, 10=>{"token"=>".", "type"=>"punctuation_mistake"}})
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #047" do
    before do
      original_sentence = 'The laptop can make a lot of things such as a searching knowledge, writing down some memo, watching a movie and so on.'
      corrected_sentence = 'I can do a lot of things with the laptop such as searching knowledge, writing down some memos, watching a movie and so on.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"I", "type"=>"missing_word_mistake"}, 1=>{"token"=>"can", "type"=>"word_order_mistake"}, 2=>{"token"=>"do", "type"=>"missing_word_mistake"}, 3=>{"token"=>"make", "type"=>"unnecessary_word_mistake"}, 4=>{"token"=>"a", "type"=>"word_order_mistake"}, 5=>{"token"=>"lot", "type"=>"word_order_mistake"}, 6=>{"token"=>"of", "type"=>"word_order_mistake"}, 7=>{"token"=>"things", "type"=>"word_order_mistake"}, 8=>{"token"=>"with", "type"=>"missing_word_mistake"}, 9=>{"token"=>"the", "type"=>"word_order_mistake"}, 10=>{"token"=>"laptop", "type"=>"word_order_mistake"}, 11=>{"token"=>"such", "type"=>"no_mistake"}, 12=>{"token"=>"as", "type"=>"no_mistake"}, 13=>{"token"=>"a", "type"=>"unnecessary_word_mistake"}, 14=>{"token"=>"searching", "type"=>"no_mistake"}, 15=>{"token"=>"knowledge", "type"=>"no_mistake"}, 16=>{"token"=>",", "type"=>"no_mistake"}, 17=>{"token"=>"writing", "type"=>"no_mistake"}, 18=>{"token"=>"down", "type"=>"no_mistake"}, 19=>{"token"=>"some", "type"=>"no_mistake"}, 20=>{"token"=>"memo", "type"=>"pluralization_mistake"}, 21=>{"token"=>"memos", "type"=>"pluralization_correction"}, 22=>{"token"=>",", "type"=>"no_mistake"}, 23=>{"token"=>"watching", "type"=>"no_mistake"}, 24=>{"token"=>"a", "type"=>"no_mistake"}, 25=>{"token"=>"movie", "type"=>"no_mistake"}, 26=>{"token"=>"and", "type"=>"no_mistake"}, 27=>{"token"=>"so", "type"=>"no_mistake"}, 28=>{"token"=>"on", "type"=>"no_mistake"}, 29=>{"token"=>".", "type"=>"no_mistake"}})
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #048" do
    before do
      original_sentence = 'Actually when I attended the international meeting, or American society for surgery of hand, at the trip.'
      corrected_sentence = 'Actually, I attended the international meeting for the American Society for surgery of hand while I was on the trip.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"Actually", "type"=>"no_mistake"}, 1=>{"token"=>"when", "type"=>"unnecessary_word_mistake"}, 2=>{"token"=>",", "type"=>"missing_punctuation_correction"}, 3=>{"token"=>"I", "type"=>"no_mistake"}, 4=>{"token"=>"attended", "type"=>"no_mistake"}, 5=>{"token"=>"the", "type"=>"no_mistake"}, 6=>{"token"=>"international", "type"=>"no_mistake"}, 7=>{"token"=>"meeting", "type"=>"no_mistake"}, 8=>{"token"=>",", "type"=>"punctuation_mistake"}, 9=>{"token"=>"or", "type"=>"unnecessary_word_mistake"}, 10=>{"token"=>"for", "type"=>"missing_word_mistake"}, 11=>{"token"=>"the", "type"=>"missing_word_mistake"}, 12=>{"token"=>"American", "type"=>"no_mistake"}, 13=>{"token"=>"society", "type"=>"capitalization_mistake"}, 14=>{"token"=>"Society", "type"=>"capitalization_correction"}, 15=>{"token"=>"for", "type"=>"no_mistake"}, 16=>{"token"=>"surgery", "type"=>"no_mistake"}, 17=>{"token"=>"of", "type"=>"no_mistake"}, 18=>{"token"=>"hand", "type"=>"no_mistake"}, 19=>{"token"=>",", "type"=>"punctuation_mistake"}, 20=>{"token"=>"at", "type"=>"unnecessary_word_mistake"}, 21=>{"token"=>"while", "type"=>"missing_word_mistake"}, 22=>{"token"=>"I", "type"=>"missing_word_mistake"}, 23=>{"token"=>"was", "type"=>"missing_word_mistake"}, 24=>{"token"=>"on", "type"=>"missing_word_mistake"}, 25=>{"token"=>"the", "type"=>"no_mistake"}, 26=>{"token"=>"trip", "type"=>"no_mistake"}, 27=>{"token"=>".", "type"=>"no_mistake"}})
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  # context "example correction #049" do
  #   before do
  #     original_sentence = 'By the way, already got a demo of it working with video. maybe'
  #     corrected_sentence = 'By the way, already got a demo of it working with video, maybe we can try it sometime this week.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      # #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq([])
  #   end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  # end

  context "example correction #050" do
    before do
      original_sentence = 'This year, going back to my work at my university, I have less time to spend my private time, for example, morning conference at 7:10 on Tuesday, at 7:30 on Thursday, preparation for operation, meeting, work for outpatients and so on.'
      corrected_sentence = 'This year, going back to work at my university, I have less private time, for example, morning conference at 7:10 on Tuesday, at 7:30 on Thursday, preparation for operations, meetings, work for outpatients and so on.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"This", "type"=>"no_mistake"}, 1=>{"token"=>"year", "type"=>"no_mistake"}, 2=>{"token"=>",", "type"=>"no_mistake"}, 3=>{"token"=>"going", "type"=>"no_mistake"}, 4=>{"token"=>"back", "type"=>"no_mistake"}, 5=>{"token"=>"to", "type"=>"no_mistake"}, 6=>{"token"=>"my", "type"=>"unnecessary_word_mistake"}, 7=>{"token"=>"work", "type"=>"no_mistake"}, 8=>{"token"=>"at", "type"=>"no_mistake"}, 9=>{"token"=>"my", "type"=>"no_mistake"}, 10=>{"token"=>"university", "type"=>"no_mistake"}, 11=>{"token"=>",", "type"=>"no_mistake"}, 12=>{"token"=>"I", "type"=>"no_mistake"}, 13=>{"token"=>"have", "type"=>"no_mistake"}, 14=>{"token"=>"less", "type"=>"no_mistake"}, 15=>{"token"=>"time", "type"=>"unnecessary_word_mistake"}, 16=>{"token"=>"to", "type"=>"unnecessary_word_mistake"}, 17=>{"token"=>"spend", "type"=>"unnecessary_word_mistake"}, 18=>{"token"=>"my", "type"=>"unnecessary_word_mistake"}, 19=>{"token"=>"private", "type"=>"no_mistake"}, 20=>{"token"=>"time", "type"=>"no_mistake"}, 21=>{"token"=>",", "type"=>"no_mistake"}, 22=>{"token"=>"for", "type"=>"no_mistake"}, 23=>{"token"=>"example", "type"=>"no_mistake"}, 24=>{"token"=>",", "type"=>"no_mistake"}, 25=>{"token"=>"morning", "type"=>"no_mistake"}, 26=>{"token"=>"conference", "type"=>"no_mistake"}, 27=>{"token"=>"at", "type"=>"no_mistake"}, 28=>{"token"=>"7:10", "type"=>"no_mistake"}, 29=>{"token"=>"on", "type"=>"no_mistake"}, 30=>{"token"=>"Tuesday", "type"=>"no_mistake"}, 31=>{"token"=>",", "type"=>"no_mistake"}, 32=>{"token"=>"at", "type"=>"no_mistake"}, 33=>{"token"=>"7:30", "type"=>"no_mistake"}, 34=>{"token"=>"on", "type"=>"no_mistake"}, 35=>{"token"=>"Thursday", "type"=>"no_mistake"}, 36=>{"token"=>",", "type"=>"no_mistake"}, 37=>{"token"=>"preparation", "type"=>"no_mistake"}, 38=>{"token"=>"for", "type"=>"no_mistake"}, 39=>{"token"=>"operation", "type"=>"pluralization_mistake"}, 40=>{"token"=>"operations", "type"=>"pluralization_correction"}, 41=>{"token"=>",", "type"=>"no_mistake"}, 42=>{"token"=>"meeting", "type"=>"pluralization_mistake"}, 43=>{"token"=>"meetings", "type"=>"pluralization_correction"}, 44=>{"token"=>",", "type"=>"no_mistake"}, 45=>{"token"=>"work", "type"=>"no_mistake"}, 46=>{"token"=>"for", "type"=>"no_mistake"}, 47=>{"token"=>"outpatients", "type"=>"no_mistake"}, 48=>{"token"=>"and", "type"=>"no_mistake"}, 49=>{"token"=>"so", "type"=>"no_mistake"}, 50=>{"token"=>"on", "type"=>"no_mistake"}, 51=>{"token"=>".", "type"=>"no_mistake"}})
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  # context "example correction #051" do
  #   before do
  #     original_sentence = 'These are my things to keep healthy now.'
  #     corrected_sentence = 'These are the ways that I keep healthy now.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      # #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq("{\"0\":{\"These\":\"no_mistake\"},\"1\":{\"are\":\"no_mistake\"},\"2\":{\"my\":\"word_choice_mistake\"},\"3\":{\"things\":\"word_choice_mistake\"},\"4\":{\"to\":\"word_choice_mistake\"},\"5\":{\"the\":\"word_choice_mistake_correction\"},\"6\":{\"ways\":\"word_choice_mistake_correction\"},\"7\":{\"that\":\"word_choice_mistake_correction\"},\"8\":{\"I\":\"word_choice_mistake_correction\"},\"9\":{\"keep\":\"no_mistake\"},\"10\":{\"healthy\":\"no_mistake\"},\"11\":{\"now\":\"no_mistake\"},\"12\":{\".\":\"no_mistake\"}}")
  #   end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  # end

  context "example correction #052" do
    before do
      original_sentence = 'Her name was Dr. Cole.'
      corrected_sentence = 'Her name is Dr. Cole.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"Her", "type"=>"no_mistake"}, 1=>{"token"=>"name", "type"=>"no_mistake"}, 2=>{"token"=>"was", "type"=>"verb_mistake"}, 3=>{"token"=>"is", "type"=>"verb_correction"}, 4=>{"token"=>"Dr.", "type"=>"no_mistake"}, 5=>{"token"=>"Cole", "type"=>"no_mistake"}, 6=>{"token"=>".", "type"=>"no_mistake"}})
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #053" do
    before do
      original_sentence = 'Because gravity.'
      corrected_sentence = 'Because of gravity'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"Because", "type"=>"no_mistake"}, 1=>{"token"=>"of", "type"=>"missing_word_mistake"}, 2=>{"token"=>"gravity", "type"=>"no_mistake"}, 3=>{"token"=>".", "type"=>"punctuation_mistake"}})
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #054" do
    before do
      original_sentence = 'I gots a dog.'
      corrected_sentence = 'I have a dog.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq({0=>{"token"=>"I", "type"=>"no_mistake"}, 1=>{"token"=>"gots", "type"=>"verb_mistake"}, 2=>{"token"=>"have", "type"=>"verb_correction"}, 3=>{"token"=>"a", "type"=>"no_mistake"}, 4=>{"token"=>"dog", "type"=>"no_mistake"}, 5=>{"token"=>".", "type"=>"no_mistake"}})
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  # context "example correction #055" do
  #   before do
  #     original_sentence = "what's hapen"
  #     corrected_sentence = 'what is happen'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      # #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq("{\"0\":{\"whatƪs\":\"stylistic_choice\"},\"1\":{\"what\":\"stylistic_choice_correction\"},\"2\":{\"is\":\"stylistic_choice_correction\"},\"3\":{\"hapen\":\"spelling_mistake\"},\"4\":{\"happen\":\"spelling_mistake_correction\"}}")
  #   end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  # end

  # context "example correction #056" do
  #   before do
  #     original_sentence = 'what is happen'
  #     corrected_sentence = "what's happen"
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      # #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq("{\"0\":{\"what\":\"stylistic_choice\"},\"1\":{\"is\":\"stylistic_choice\"},\"2\":{\"whatƪs\":\"stylistic_choice_correction\"},\"3\":{\"happen\":\"no_mistake\"}}")
  #   end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  # end

  # context "example correction #057" do
  #   before do
  #     original_sentence = "That couldn't happen."
  #     corrected_sentence = 'That could not happen.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      # #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq("{\"0\":{\"That\":\"no_mistake\"},\"1\":{\"couldnƪt happen\":\"stylistic_choice\"},\"2\":{\"could not happen\":\"stylistic_choice_correction\"},\"3\":{\".\":\"no_mistake\"}}")
  #   end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  # end

  # context "example correction #058" do
  #   before do
  #     original_sentence = 'That could not happen.'
  #     corrected_sentence = "That couldn't happen."
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      # #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq("{\"0\":{\"That\":\"no_mistake\"},\"1\":{\"could not happen\":\"stylistic_choice\"},\"2\":{\"couldnƪt happen\":\"stylistic_choice_correction\"},\"3\":{\".\":\"no_mistake\"}}")
  #   end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  # end

  # context "example correction #059" do
  #   before do
  #     original_sentence = 'It was the night before Christmas.'
  #     corrected_sentence = "'Twas the night before Christmas."
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      # #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq("{\"0\":{\"It\":\"stylistic_choice\"},\"1\":{\"was\":\"stylistic_choice\"},\"2\":{\"ƪTwas\":\"stylistic_choice_correction\"},\"3\":{\"the\":\"no_mistake\"},\"4\":{\"night\":\"no_mistake\"},\"5\":{\"before\":\"no_mistake\"},\"6\":{\"Christmas\":\"no_mistake\"},\"7\":{\".\":\"no_mistake\"}}")
  #   end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  # end

  # context "example correction #060" do
  #   before do
  #     original_sentence = 'Yesterday, it was the night before Christmas.'
  #     corrected_sentence = "Yesterday, 'twas the night before Christmas."
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      # #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq("{\"0\":{\"Yesterday\":\"no_mistake\"},\"1\":{\",\":\"no_mistake\"},\"2\":{\"it\":\"stylistic_choice\"},\"3\":{\"was\":\"stylistic_choice\"},\"4\":{\"ƪtwas\":\"stylistic_choice_correction\"},\"5\":{\"the\":\"no_mistake\"},\"6\":{\"night\":\"no_mistake\"},\"7\":{\"before\":\"no_mistake\"},\"8\":{\"Christmas\":\"no_mistake\"},\"9\":{\".\":\"no_mistake\"}}")
  #   end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  # end

  # context "example correction #061" do
  #   before do
  #     original_sentence = 'Usually we orthopedic surgeon suggest to take a operation which broken fermur neck replace to prosthesis.'
  #     corrected_sentence = 'Usually we orthopedic surgeons will suggest the patient to have an operation which replaces the broken fermur neck with prosthesis.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      # #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq("{\"0\":{\"Usually\":\"no_mistake\"},\"1\":{\"we\":\"no_mistake\"},\"2\":{\"orthopedic\":\"no_mistake\"},\"3\":{\"surgeon\":\"pluralization_mistake\"},\"4\":{\"surgeons\":\"pluralization_mistake_correction\"},\"5\":{\"suggest\":\"verb_mistake\"},\"6\":{\"will suggest\":\"verb_mistake_correction\"},\"7\":{\"to\":\"word_choice_mistake\"},\"8\":{\"the\":\"word_choice_mistake_correction\"},\"9\":{\"patient\":\"missing_word_mistake\"},\"10\":{\"to\":\"missing_word_mistake\"},\"11\":{\"take\":\"verb_mistake\"},\"12\":{\"have\":\"verb_mistake_correction\"},\"13\":{\"a\":\"word_choice_mistake\"},\"14\":{\"an\":\"word_choice_mistake_correction\"},\"15\":{\"operation\":\"no_mistake\"},\"16\":{\"which\":\"no_mistake\"},\"17\":{\"replaces\":\"verb_mistake_correction\"},\"18\":{\"replace\":\"verb_mistake\"},\"19\":{\"the\":\"missing_word_mistake\"},\"20\":{\"to\":\"unnecessary_word_mistake\"},\"21\":{\"broken\":\"word_order_mistake\"},\"22\":{\"fermur\":\"word_order_mistake\"},\"23\":{\"neck\":\"word_order_mistake\"},\"24\":{\"with\":\"missing_word_mistake\"},\"25\":{\"prosthesis\":\"no_mistake\"},\"26\":{\".\":\"no_mistake\"}}")
  #   end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  # end

  # context "example correction #062" do
  #   before do
  #     original_sentence = 'and I explained the x-ray result and I let her to hospitalize my hospital.'
  #     corrected_sentence = 'I explained the x-ray result and I hospitalized her at my hospital.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      # #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq("{\"0\":{\"But\":\"no_mistake\"},\"1\":{\"she\":\"no_mistake\"},\"2\":{\"had\":\"no_mistake\"},\"3\":{\"some\":\"no_mistake\"},\"4\":{\"difficulty\":\"no_mistake\"},\"5\":{\"in\":\"no_mistake\"},\"6\":{\"her\":\"no_mistake\"},\"7\":{\"condition\":\"no_mistake\"},\"8\":{\":\":\"no_mistake\"},\"9\":{\"heart\":\"no_mistake\"},\"10\":{\"ischemia\":\"no_mistake\"},\"11\":{\"which\":\"no_mistake\"},\"12\":{\"had\":\"no_mistake\"},\"13\":{\"recently\":\"no_mistake\"},\"14\":{\"operation\":\"no_mistake\"},\"15\":{\"of\":\"no_mistake\"},\"16\":{\"PCI\":\"no_mistake\"},\"17\":{\",\":\"no_mistake\"},\"18\":{\"COPD\":\"no_mistake\"},\"19\":{\":\":\"no_mistake\"},\"20\":{\"chornic\":\"spelling_mistake\"},\"21\":{\"chronic\":\"spelling_mistake_correction\"},\"22\":{\"objective\":\"no_mistake\"},\"23\":{\"pulmpnary\":\"spelling_mistake\"},\"24\":{\"pulmonary\":\"spelling_mistake_correction\"},\"25\":{\"disease\":\"no_mistake\"},\"26\":{\",\":\"no_mistake\"},\"27\":{\"chornic\":\"spelling_mistake\"},\"28\":{\"chronic\":\"spelling_mistake_correction\"},\"29\":{\"kidney\":\"no_mistake\"},\"30\":{\"failure\":\"no_mistake\"},\"31\":{\"which\":\"no_mistake\"},\"32\":{\"had\":\"unnecessary_word_mistake\"},\"33\":{\"had treated\":\"verb_mistake\"},\"34\":{\"had been treated\":\"verb_mistake_correction\"},\"35\":{\"on\":\"word_choice_mistake\"},\"36\":{\"with\":\"word_choice_mistake_correction\"},\"37\":{\"regular\":\"no_mistake\"},\"38\":{\"hemodyalisis\":\"no_mistake\"},\"39\":{\"for\":\"no_mistake\"},\"40\":{\"some\":\"no_mistake\"},\"41\":{\"decade\":\"pluralization_mistake\"},\"42\":{\"decades\":\"pluralization_mistake_correction\"},\"43\":{\".\":\"no_mistake\"}}")
  #   end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  # end

  # context "example correction #063" do
  #   before do
  #     original_sentence = 'But she had some difficulty in her condition: heart ischemia which had recently operation of PCI, COPD: chornic objective pulmpnary disease, chornic kidney failure which had had treated on regular hemodyalisis for some decade.'
  #     corrected_sentence = 'But she had some difficulty in her condition: heart ischemia which had recently operation of PCI, COPD: chronic objective pulmonary disease, chronic kidney failure which had been treated with regular hemodyalisis for some decades.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      # #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq("{\"0\":{\"If\":\"no_mistake\"},\"1\":{\"she\":\"no_mistake\"},\"2\":{\"cannot\":\"no_mistake\"},\"3\":{\"be\":\"unnecessary_word_mistake\"},\"4\":{\"take\":\"verb_mistake\"},\"5\":{\"have\":\"verb_mistake_correction\"},\"6\":{\"the\":\"no_mistake\"},\"7\":{\"operation\":\"no_mistake\"},\"8\":{\",\":\"no_mistake\"},\"9\":{\"she\":\"no_mistake\"},\"10\":{\"usually\":\"unnecessary_word_mistake\"},\"11\":{\"cannot\":\"unnecessary_word_mistake\"},\"12\":{\"probably\":\"missing_word_mistake\"},\"13\":{\"will not be\":\"missing_word_mistake\"},\"14\":{\"able\":\"missing_word_mistake\"},\"15\":{\"to\":\"missing_word_mistake\"},\"16\":{\"walk\":\"no_mistake\"},\"17\":{\"at\":\"no_mistake\"},\"18\":{\"all\":\"no_mistake\"},\"19\":{\"and\":\"no_mistake\"},\"20\":{\"needs\":\"unnecessary_word_mistake\"},\"21\":{\"any\":\"unnecessary_word_mistake\"},\"22\":{\"other’s\":\"unnecessary_word_mistake\"},\"23\":{\"will need\":\"missing_word_mistake\"},\"24\":{\"another\":\"missing_word_mistake\"},\"25\":{\"personƪs\":\"missing_word_mistake\"},\"26\":{\"help\":\"no_mistake\"},\"27\":{\"forever\":\"no_mistake\"},\"28\":{\".\":\"no_mistake\"}}")
  #   end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  # end

  # context "example correction #064" do
  #   before do
  #     original_sentence = 'If she cannot be take the operation, she usually cannot walk at all and needs any other’s help forever.'
  #     corrected_sentence = "If she cannot have the operation, she probably will not be able to walk at all and will need another person's help forever."
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      # #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq([])
  #   end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  # end

  # context "example correction #065" do
  #   before do
  #     original_sentence = 'That is why I recommend her and her family to take the operation even if she has a lot of disease.'
  #     corrected_sentence = 'That is why I recommend her and her family to have the operation even if she has a lot of diseases.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      # #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq([])
  #   end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  # end

  # context "example correction #066" do
  #   before do
  #     original_sentence = 'But my superior boss should not to take the operation careless.'
  #     corrected_sentence = 'But my superior boss said not to take the operation carelessly.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      # #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq([])
  #   end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  # end

  # context "example correction #067" do
  #   before do
  #     original_sentence = 'The boss and group had the experience the death of a patient after the operation in 3 week.'
  #     corrected_sentence = 'The boss and group had the experience of the death of a patient 3 weeks after the operation.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq([])
  #   end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  # end

  # context "example correction #068" do
  #   before do
  #     original_sentence = 'At the time, the boss and our group was accused by sudden death.'
  #     corrected_sentence = 'At the time, the boss and our group were accused of sudden death.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq([])
  #   end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  # end

  # context "example correction #069" do
  #   before do
  #     original_sentence = 'Even if the family and the patients understood the explain, the result was bad, the family complained the result.'
  #     corrected_sentence = 'Even if the family and the patients understood the explanation, the result was bad, and the family complained about the result.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq([])
  #   end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  # end

  # context "example correction #070" do
  #   before do
  #     original_sentence = 'Me and Bill went to the store.'
  #     corrected_sentence = 'Bill and I went to the store.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #071" do
  #   before do
  #     original_sentence = 'In my situation, I feel a little anger, when my child will not ignore about our suggestion, or favors, however, I do not want to ignore about my child or beat him.'
  #     corrected_sentence = 'In my situation, I feel a little anger, when my child ignores our suggestion, or favors, however, I do not want to ignore my child or beat him.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #072" do
  #   before do
  #     original_sentence = 'in my experience, it is one of the good parents skill to endure our children trickery behavior or fretting attitude.'
  #     corrected_sentence = "In my experience, it is one of the good parents skill to endure our children's trickery or fretting attitude."
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #073" do
  #   before do
  #     original_sentence = 'When he gets tired or has a unwillingness to do, he gets anger, or not to obey my suggestion.'
  #     corrected_sentence = 'When he gets tired or has an unwillingness to do something, he gets angry, or does not obey my suggestion.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #074" do
  #   before do
  #     original_sentence = 'And I feel always to anger, I always hold his body tightly.'
  #     corrected_sentence = 'And I always feel anger, and I always hold his body tightly.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #075" do
  #   before do
  #     original_sentence = 'I think that it is difficult to be endure children rude behavior, therefore the skill to endure is one of the skill to be a good parents.'
  #     corrected_sentence = "I think that it is difficult to endure children's rude behavior, therefore the skill to endure is one of the skills to be a good parent."
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #076" do
  #   before do
  #     original_sentence = 'That is the Smiths car.'
  #     corrected_sentence = "That is the Smiths' car."
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #077" do
  #   before do
  #     original_sentence = 'That is Bens car.'
  #     corrected_sentence = "That is Ben's car."
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #078" do
  #   before do
  #     original_sentence = "Quieting is is so peaceful when you don't have to be quieted students so they sit quiets."
  #     corrected_sentence = "The quiet is so peaceful when you don't have to be quieting students so they sit quietly."
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
      #expect(@cc.correct).to eq('')
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  context "example correction #079" do
    before do
      original_sentence = nil
      corrected_sentence = nil
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect { @cc.correct }.to raise_error('You must include an Original Sentence')
    end

    it 'Reports the mistakes' do
      expect { @cc.correct }.to raise_error('You must include an Original Sentence')
    end

    it 'Counts the number of mistakes' do
      expect { @cc.correct }.to raise_error('You must include an Original Sentence')
    end

    it 'Reports the mistakes by mistake type' do
      expect { @cc.correct }.to raise_error('You must include an Original Sentence')
    end
  end

  context "example correction #080" do
    before do
      original_sentence = nil
      corrected_sentence = 'Hello world'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect { @cc.correct }.to raise_error('You must include an Original Sentence')
    end

    it 'Reports the mistakes' do
      expect { @cc.correct }.to raise_error('You must include an Original Sentence')
    end

    it 'Counts the number of mistakes' do
      expect { @cc.correct }.to raise_error('You must include an Original Sentence')
    end

    it 'Reports the mistakes by mistake type' do
      expect { @cc.correct }.to raise_error('You must include an Original Sentence')
    end
  end

  context "example correction #081" do
    before do
      original_sentence = 'Hello world'
      corrected_sentence = nil
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect { @cc.correct }.to raise_error('You must include a Corrected Sentence')
    end

    it 'Reports the mistakes' do
      expect { @cc.correct }.to raise_error('You must include a Corrected Sentence')
    end

    it 'Counts the number of mistakes' do
      expect { @cc.correct }.to raise_error('You must include a Corrected Sentence')
    end

    it 'Reports the mistakes by mistake type' do
      expect { @cc.correct }.to raise_error('You must include a Corrected Sentence')
    end
  end

  context "example correction #082" do
    before do
      original_sentence = ''
      corrected_sentence = ''
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect { @cc.correct }.to raise_error('You must include an Original Sentence')
    end

    it 'Reports the mistakes' do
      expect { @cc.correct }.to raise_error('You must include an Original Sentence')
    end

    it 'Counts the number of mistakes' do
      expect { @cc.correct }.to raise_error('You must include an Original Sentence')
    end

    it 'Reports the mistakes by mistake type' do
      expect { @cc.correct }.to raise_error('You must include an Original Sentence')
    end
  end

  context "example correction #083" do
    before do
      original_sentence = ''
      corrected_sentence = 'Hello world'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect { @cc.correct }.to raise_error('You must include an Original Sentence')
    end

    it 'Reports the mistakes' do
      expect { @cc.correct }.to raise_error('You must include an Original Sentence')
    end

    it 'Counts the number of mistakes' do
      expect { @cc.correct }.to raise_error('You must include an Original Sentence')
    end

    it 'Reports the mistakes by mistake type' do
      expect { @cc.correct }.to raise_error('You must include an Original Sentence')
    end
  end

  context "example correction #084" do
    before do
      original_sentence = 'Hello world'
      corrected_sentence = ''
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect { @cc.correct }.to raise_error('You must include a Corrected Sentence')
    end

    it 'Reports the mistakes' do
      expect { @cc.correct }.to raise_error('You must include a Corrected Sentence')
    end

    it 'Counts the number of mistakes' do
      expect { @cc.correct }.to raise_error('You must include a Corrected Sentence')
    end

    it 'Reports the mistakes by mistake type' do
      expect { @cc.correct }.to raise_error('You must include a Corrected Sentence')
    end
  end
end
