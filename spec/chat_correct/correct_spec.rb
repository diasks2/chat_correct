require 'spec_helper'

RSpec.describe ChatCorrect::Correct do
  context "example correction #001 (no mistakes)" do
    before do
      original_sentence = 'There are no mistakes here.'
      corrected_sentence = 'There are no mistakes here.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      #expect(@cc.correct).to eq({0 => {'token' => 'There', 'type' => 'no_mistake'}, 1 => {'token' => 'are', 'type' => 'no_mistake'},  2 => {'token' => 'no', 'type' => 'no_mistake'},  3 => {'token' => 'mistakes', 'type' => 'no_mistake'}, 4 => {'token' => 'here', 'type' => 'no_mistake'}, 5 => {'token' => '.', 'type' => 'no_mistake'}})
      expect(@cc.correct).to eq("{\"0\":{\"There\":\"no_mistake\"},\"1\":{\"are\":\"no_mistake\"},\"2\":{\"no\":\"no_mistake\"},\"3\":{\"mistakes\":\"no_mistake\"},\"4\":{\"here\":\"no_mistake\"},\"5\":{\".\":\"no_mistake\"}}")
    end

    # it 'Reports the mistakes' do
    #   expect(@cc.mistakes).to eq({})
    # end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq(0)
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq({'missing_word' => 0, 'unnecessary_word' => 0, 'spelling' => 0, 'verb_tense' => 0, 'punctuation' => 0, 'word_order' => 0, 'capitalization' => 0, 'duplicate_word' => 0, 'word_choice' => 0, 'pluralization' => 0, 'possessive' => 0, 'stylistic_choice' => 0})
    # end
  end

  context "example correction #002" do
    before do
      original_sentence = 'is the, puncttuation are wrong.'
      corrected_sentence = 'Is the punctuation wrong?'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      #expect(@cc.correct).to eq({0 => {'token' => 'is', 'type' => 'capitalization_mistake'}, 1 => {'token' => 'Is', 'type' => 'capitalization_correction'},  2 => {'token' => 'the', 'type' => 'no_mistake'},  3 => {'token' => ',', 'type' => 'punctuation_mistake'}, 4 => {'token' => 'puncttuation', 'type' => 'spelling_mistake'}, 5 => {'token' => 'punctuation', 'type' => 'spelling_correction'}, 6 => {'token' => 'are', 'type' => 'unnecessary_word_mistake'},  7 => {'token' => 'wrong', 'type' => 'no_mistake'},  8 => {'token' => '.', 'type' => 'punctuation_mistake'},  9 => {'token' => '?', 'type' => 'punctuation_correction'}})
      expect(@cc.correct).to eq("{\"0\":{\"is\":\"capitalization_mistake\"},\"1\":{\"Is\":\"capitalization_mistake_opposite\"},\"2\":{\"the\":\"no_mistake\"},\"3\":{\",\":\"punctuation_mistake\"},\"4\":{\"puncttuation\":\"spelling_mistake\"},\"5\":{\"punctuation\":\"spelling_mistake_opposite\"},\"6\":{\"are\":\"unnecessary_word_mistake\"},\"7\":{\"wrong\":\"no_mistake\"},\"8\":{\".\":\"punctuation_mistake\"},\"9\":{\"?\":\"punctuation_mistake_opposite\"}}")
    end

    # it 'Reports the mistakes' do
    #   expect(@cc.mistakes).to eq({0 => {'position' => 0, 'error_type' => 'capitalization', 'mistake' => 'is', 'correction' => 'Is'}, 1 => {'position' => 3, 'error_type' => 'punctuation', 'mistake' => ',', 'correction' => ''}, 2 => {'position' => 4, 'error_type' => 'spelling', 'mistake' => 'puncttuation', 'correction' => 'punctuation'},  3 => {'position' => 3, 'error_type' => 'unnecessary_word', 'mistake' => 'are', 'correction' => ''},  4 => {'position' => 3, 'error_type' => 'punctuation', 'mistake' => '.', 'correction' => '?'}})
    # end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq(5)
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq({'missing_word' => 0, 'unnecessary_word' => 1, 'spelling' => 1, 'verb_tense' => 0, 'punctuation' => 2, 'word_order' => 0, 'capitalization' => 1, 'duplicate_word' => 0, 'word_choice' => 0, 'pluralization' => 0, 'possessive' => 0, 'stylistic_choice' => 0 })
    # end
  end

  context "example correction #003" do
    before do
      original_sentence = 'I need go shopping at this weekend.'
      corrected_sentence = 'I need to go shopping this weekend.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"I\":\"no_mistake\"},\"1\":{\"need\":\"no_mistake\"},\"2\":{\"to\":\"missing_word_mistake\"},\"3\":{\"go\":\"no_mistake\"},\"4\":{\"shopping\":\"no_mistake\"},\"5\":{\"at\":\"unnecessary_word_mistake\"},\"6\":{\"this\":\"no_mistake\"},\"7\":{\"weekend\":\"no_mistake\"},\"8\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #004" do
    before do
      original_sentence = 'I go trip last month.'
      corrected_sentence = 'I went on a trip last month.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"I\":\"no_mistake\"},\"1\":{\"go\":\"verb_mistake\"},\"2\":{\"went\":\"verb_mistake_opposite\"},\"3\":{\"on\":\"missing_word_mistake\"},\"4\":{\"a\":\"missing_word_mistake\"},\"5\":{\"trip\":\"no_mistake\"},\"6\":{\"last\":\"no_mistake\"},\"7\":{\"month\":\"no_mistake\"},\"8\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #005" do
    before do
      original_sentence = 'This is an exclamation.'
      corrected_sentence = 'This is an exclamation!'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"This\":\"no_mistake\"},\"1\":{\"is\":\"no_mistake\"},\"2\":{\"an\":\"no_mistake\"},\"3\":{\"exclamation\":\"no_mistake\"},\"4\":{\".\":\"punctuation_mistake\"},\"5\":{\"!\":\"punctuation_mistake_opposite\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #006" do
    before do
      original_sentence = 'what am i thinking!'
      corrected_sentence = 'What was I thinking?'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"what\":\"capitalization_mistake\"},\"1\":{\"What\":\"capitalization_mistake_opposite\"},\"2\":{\"am\":\"verb_mistake\"},\"3\":{\"was\":\"verb_mistake_opposite\"},\"4\":{\"i\":\"capitalization_mistake\"},\"5\":{\"I\":\"capitalization_mistake_opposite\"},\"6\":{\"thinking\":\"no_mistake\"},\"7\":{\"!\":\"punctuation_mistake\"},\"8\":{\"?\":\"punctuation_mistake_opposite\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #007" do
    before do
      original_sentence = 'There arre lotts of misspeellings.'
      corrected_sentence = 'There are a lot of misspellings.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"There\":\"no_mistake\"},\"1\":{\"arre\":\"spelling_mistake\"},\"2\":{\"are\":\"spelling_mistake_opposite\"},\"3\":{\"a\":\"missing_word_mistake\"},\"4\":{\"lotts\":\"spelling_mistake\"},\"5\":{\"lot\":\"spelling_mistake_opposite\"},\"6\":{\"of\":\"no_mistake\"},\"7\":{\"misspeellings\":\"spelling_mistake\"},\"8\":{\"misspellings\":\"spelling_mistake_opposite\"},\"9\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #008" do
    before do
      original_sentence = 'There arre lotts, off consecutiveee misspeellings!'
      corrected_sentence = 'There are a lot of consecutive misspellings.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"There\":\"no_mistake\"},\"1\":{\"arre\":\"spelling_mistake\"},\"2\":{\"are\":\"spelling_mistake_opposite\"},\"3\":{\"a\":\"missing_word_mistake\"},\"4\":{\"lotts\":\"spelling_mistake\"},\"5\":{\"lot\":\"spelling_mistake_opposite\"},\"6\":{\",\":\"punctuation_mistake\"},\"7\":{\"off\":\"spelling_mistake\"},\"8\":{\"of\":\"spelling_mistake_opposite\"},\"9\":{\"consecutiveee\":\"spelling_mistake\"},\"10\":{\"consecutive\":\"spelling_mistake_opposite\"},\"11\":{\"misspeellings\":\"spelling_mistake\"},\"12\":{\"misspellings\":\"spelling_mistake_opposite\"},\"13\":{\"!\":\"punctuation_mistake\"},\"14\":{\".\":\"punctuation_mistake_opposite\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #009" do
    before do
      original_sentence = 'This is a double double double word check.'
      corrected_sentence = 'This is a double word check.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"This\":\"no_mistake\"},\"1\":{\"is\":\"no_mistake\"},\"2\":{\"a\":\"no_mistake\"},\"3\":{\"double\":\"duplicate_word_mistake\"},\"4\":{\"double\":\"duplicate_word_mistake\"},\"5\":{\"double\":\"no_mistake\"},\"6\":{\"word\":\"no_mistake\"},\"7\":{\"check\":\"no_mistake\"},\"8\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #010" do
    before do
      original_sentence = 'This is and this and this is a correct double word check!'
      corrected_sentence = 'This is and this and this is a correct double word check.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"This\":\"no_mistake\"},\"1\":{\"is\":\"no_mistake\"},\"2\":{\"and\":\"no_mistake\"},\"3\":{\"this\":\"no_mistake\"},\"4\":{\"and\":\"no_mistake\"},\"5\":{\"this\":\"no_mistake\"},\"6\":{\"is\":\"no_mistake\"},\"7\":{\"a\":\"no_mistake\"},\"8\":{\"correct\":\"no_mistake\"},\"9\":{\"double\":\"no_mistake\"},\"10\":{\"word\":\"no_mistake\"},\"11\":{\"check\":\"no_mistake\"},\"12\":{\"!\":\"punctuation_mistake\"},\"13\":{\".\":\"punctuation_mistake_opposite\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #011" do
    before do
      original_sentence = 'He said, "Shhe is a crazy girl".'
      corrected_sentence = 'He said, "She is a crazy girl."'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"He\":\"no_mistake\"},\"1\":{\"said\":\"no_mistake\"},\"2\":{\",\":\"no_mistake\"},\"3\":{\"\"\":\"no_mistake\"},\"4\":{\"Shhe\":\"spelling_mistake\"},\"5\":{\"She\":\"spelling_mistake_opposite\"},\"6\":{\"is\":\"no_mistake\"},\"7\":{\"a\":\"no_mistake\"},\"8\":{\"crazy\":\"no_mistake\"},\"9\":{\"girl\":\"no_mistake\"},\"10\":{\".\":\"word_order_mistake\"},\"11\":{\"\"\":\"word_order_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #012" do
    before do
      original_sentence = 'Test the order word.'
      corrected_sentence = 'Test the word order.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"Test\":\"no_mistake\"},\"1\":{\"the\":\"no_mistake\"},\"2\":{\"word\":\"word_order_mistake\"},\"3\":{\"order\":\"word_order_mistake\"},\"4\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #013" do
    before do
      original_sentence = 'This is a double double double double word check.'
      corrected_sentence = 'This is a double word check.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"This\":\"no_mistake\"},\"1\":{\"is\":\"no_mistake\"},\"2\":{\"a\":\"no_mistake\"},\"3\":{\"double\":\"duplicate_word_mistake\"},\"4\":{\"double\":\"duplicate_word_mistake\"},\"5\":{\"double\":\"duplicate_word_mistake\"},\"6\":{\"double\":\"no_mistake\"},\"7\":{\"word\":\"no_mistake\"},\"8\":{\"check\":\"no_mistake\"},\"9\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #014" do
    before do
      original_sentence = 'I call my mom tomorrow.'
      corrected_sentence = 'I will call my mom tomorrow.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"I\":\"no_mistake\"},\"1\":{\"call\":\"verb_mistake\"},\"2\":{\"will call\":\"verb_mistake_opposite\"},\"3\":{\"my\":\"no_mistake\"},\"4\":{\"mom\":\"no_mistake\"},\"5\":{\"tomorrow\":\"no_mistake\"},\"6\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #015" do
    before do
      original_sentence = 'I flied home yesterday.'
      corrected_sentence = 'I flew home yesterday.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"I\":\"no_mistake\"},\"1\":{\"flied\":\"verb_mistake\"},\"2\":{\"flew\":\"verb_mistake_opposite\"},\"3\":{\"home\":\"no_mistake\"},\"4\":{\"yesterday\":\"no_mistake\"},\"5\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #016" do
    before do
      original_sentence = "This shouldn't be use to test contractions, but couln't it?"
      corrected_sentence = "This shouldn't be used to test contractions, but couldn't it?"
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"This\":\"no_mistake\"},\"1\":{\"shouldn't\":\"no_mistake\"},\"2\":{\"be\":\"no_mistake\"},\"3\":{\"use\":\"verb_mistake\"},\"4\":{\"used\":\"verb_mistake_opposite\"},\"5\":{\"to\":\"no_mistake\"},\"6\":{\"test\":\"no_mistake\"},\"7\":{\"contractions\":\"no_mistake\"},\"8\":{\",\":\"no_mistake\"},\"9\":{\"but\":\"no_mistake\"},\"10\":{\"couln't\":\"spelling_mistake\"},\"11\":{\"couldn't\":\"spelling_mistake_opposite\"},\"12\":{\"it\":\"no_mistake\"},\"13\":{\"?\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #017" do
    before do
      original_sentence = "This is to test, 'single quotes'."
      corrected_sentence = "This is to test, 'Single quotes.'"
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"This\":\"no_mistake\"},\"1\":{\"is\":\"no_mistake\"},\"2\":{\"to\":\"no_mistake\"},\"3\":{\"test\":\"no_mistake\"},\"4\":{\",\":\"no_mistake\"},\"5\":{\"'\":\"no_mistake\"},\"6\":{\"single\":\"capitalization_mistake\"},\"7\":{\"Single\":\"capitalization_mistake_opposite\"},\"8\":{\"quotes\":\"no_mistake\"},\"9\":{\".\":\"word_order_mistake\"},\"10\":{\"'\":\"word_order_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #018" do
    before do
      original_sentence = 'This is to test quotations "again"'
      corrected_sentence = 'This is to test quotations again'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"This\":\"no_mistake\"},\"1\":{\"is\":\"no_mistake\"},\"2\":{\"to\":\"no_mistake\"},\"3\":{\"test\":\"no_mistake\"},\"4\":{\"quotations\":\"no_mistake\"},\"5\":{\"\"\":\"punctuation_mistake\"},\"6\":{\"again\":\"no_mistake\"},\"7\":{\"\"\":\"punctuation_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #019" do
    before do
      original_sentence = 'I will call my mom yesterday.'
      corrected_sentence = 'I called my mom yesterday.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"I\":\"no_mistake\"},\"1\":{\"will call\":\"verb_mistake\"},\"2\":{\"called\":\"verb_mistake_opposite\"},\"3\":{\"my\":\"no_mistake\"},\"4\":{\"mom\":\"no_mistake\"},\"5\":{\"yesterday\":\"no_mistake\"},\"6\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #020" do
    before do
      original_sentence = 'Test run the order word with anotther mistake.'
      corrected_sentence = 'Test the word order with another simple mistake.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"Test\":\"no_mistake\"},\"1\":{\"run\":\"unnecessary_word_mistake\"},\"2\":{\"the\":\"no_mistake\"},\"3\":{\"word\":\"word_order_mistake\"},\"4\":{\"order\":\"word_order_mistake\"},\"5\":{\"with\":\"no_mistake\"},\"6\":{\"anotther\":\"spelling_mistake\"},\"7\":{\"another\":\"spelling_mistake_opposite\"},\"8\":{\"simple\":\"missing_word_mistake\"},\"9\":{\"mistake\":\"no_mistake\"},\"10\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #021" do
    before do
      original_sentence = 'This is to test quotations "again".'
      corrected_sentence = 'This is to test quotations again.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"This\":\"no_mistake\"},\"1\":{\"is\":\"no_mistake\"},\"2\":{\"to\":\"no_mistake\"},\"3\":{\"test\":\"no_mistake\"},\"4\":{\"quotations\":\"no_mistake\"},\"5\":{\"\"\":\"punctuation_mistake\"},\"6\":{\"again\":\"no_mistake\"},\"7\":{\"\"\":\"punctuation_mistake\"},\"8\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #022" do
    before do
      original_sentence = 'This is to test quotations "again"'
      corrected_sentence = 'This is to test quotations again.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"This\":\"no_mistake\"},\"1\":{\"is\":\"no_mistake\"},\"2\":{\"to\":\"no_mistake\"},\"3\":{\"test\":\"no_mistake\"},\"4\":{\"quotations\":\"no_mistake\"},\"5\":{\"\"\":\"punctuation_mistake\"},\"6\":{\"again\":\"no_mistake\"},\"7\":{\"\"\":\"punctuation_mistake\"},\"8\":{\".\":\"punctuation_mistake_opposite\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #023" do
    before do
      original_sentence = "He didn't realize that he should had changed the locks."
      corrected_sentence = "He hadn't realized that he should have changed the locks."
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"He\":\"no_mistake\"},\"1\":{\"didn't realize\":\"verb_mistake\"},\"2\":{\"hadn't realized\":\"verb_mistake_opposite\"},\"3\":{\"that\":\"no_mistake\"},\"4\":{\"he\":\"no_mistake\"},\"5\":{\"should\":\"no_mistake\"},\"6\":{\"had changed\":\"verb_mistake\"},\"7\":{\"have changed\":\"verb_mistake_opposite\"},\"8\":{\"the\":\"no_mistake\"},\"9\":{\"locks\":\"no_mistake\"},\"10\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #024" do
    before do
      original_sentence = 'I will call my mom yesterday if I had time.'
      corrected_sentence = 'I would have called my mom yesterday if I had had time.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"I\":\"no_mistake\"},\"1\":{\"will call\":\"verb_mistake\"},\"2\":{\"would have called\":\"verb_mistake_opposite\"},\"3\":{\"my\":\"no_mistake\"},\"4\":{\"mom\":\"no_mistake\"},\"5\":{\"yesterday\":\"no_mistake\"},\"6\":{\"if\":\"no_mistake\"},\"7\":{\"I\":\"no_mistake\"},\"8\":{\"had\":\"no_mistake\"},\"9\":{\"had\":\"missing_word_mistake\"},\"10\":{\"time\":\"no_mistake\"},\"11\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #025" do
    before do
      original_sentence = 'I call my mom yesterday.'
      corrected_sentence = 'I would have called my mom yesterday.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"I\":\"no_mistake\"},\"1\":{\"call\":\"verb_mistake\"},\"2\":{\"would have called\":\"verb_mistake_opposite\"},\"3\":{\"my\":\"no_mistake\"},\"4\":{\"mom\":\"no_mistake\"},\"5\":{\"yesterday\":\"no_mistake\"},\"6\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #026" do
    before do
      original_sentence = 'I singed at the karaoke bar.'
      corrected_sentence = 'I sang at the karaoke bar.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"I\":\"no_mistake\"},\"1\":{\"singed\":\"verb_mistake\"},\"2\":{\"sang\":\"verb_mistake_opposite\"},\"3\":{\"at\":\"no_mistake\"},\"4\":{\"the\":\"no_mistake\"},\"5\":{\"karaoke\":\"no_mistake\"},\"6\":{\"bar\":\"no_mistake\"},\"7\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #027" do
    before do
      original_sentence = 'I flied to California and go to zoo.'
      corrected_sentence = 'I flew to California and went to the zoo.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"I\":\"no_mistake\"},\"1\":{\"flied\":\"verb_mistake\"},\"2\":{\"flew\":\"verb_mistake_opposite\"},\"3\":{\"to\":\"no_mistake\"},\"4\":{\"California\":\"no_mistake\"},\"5\":{\"and\":\"no_mistake\"},\"6\":{\"go\":\"verb_mistake\"},\"7\":{\"went\":\"verb_mistake_opposite\"},\"8\":{\"to\":\"no_mistake\"},\"9\":{\"the\":\"missing_word_mistake\"},\"10\":{\"zoo\":\"no_mistake\"},\"11\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #028" do
    before do
      original_sentence = 'This is a double double double double double word check.'
      corrected_sentence = 'This is a double word check.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"This\":\"no_mistake\"},\"1\":{\"is\":\"no_mistake\"},\"2\":{\"a\":\"no_mistake\"},\"3\":{\"double\":\"duplicate_word_mistake\"},\"4\":{\"double\":\"duplicate_word_mistake\"},\"5\":{\"double\":\"duplicate_word_mistake\"},\"6\":{\"double\":\"duplicate_word_mistake\"},\"7\":{\"double\":\"no_mistake\"},\"8\":{\"word\":\"no_mistake\"},\"9\":{\"check\":\"no_mistake\"},\"10\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #029" do
    before do
      original_sentence = 'This is a double double double double double double word check.'
      corrected_sentence = 'This is a double word check.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"This\":\"no_mistake\"},\"1\":{\"is\":\"no_mistake\"},\"2\":{\"a\":\"no_mistake\"},\"3\":{\"double\":\"duplicate_word_mistake\"},\"4\":{\"double\":\"duplicate_word_mistake\"},\"5\":{\"double\":\"duplicate_word_mistake\"},\"6\":{\"double\":\"duplicate_word_mistake\"},\"7\":{\"double\":\"duplicate_word_mistake\"},\"8\":{\"double\":\"no_mistake\"},\"9\":{\"word\":\"no_mistake\"},\"10\":{\"check\":\"no_mistake\"},\"11\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #030" do
    before do
      original_sentence = 'If my school were located in Tokyo, situation would have quite changed.'
      corrected_sentence = 'If my school were located in Tokyo, the situation would have been quite different.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"If\":\"no_mistake\"},\"1\":{\"my\":\"no_mistake\"},\"2\":{\"school\":\"no_mistake\"},\"3\":{\"were located\":\"no_mistake\"},\"4\":{\"in\":\"no_mistake\"},\"5\":{\"Tokyo\":\"no_mistake\"},\"6\":{\",\":\"no_mistake\"},\"7\":{\"the\":\"missing_word_mistake\"},\"8\":{\"situation\":\"no_mistake\"},\"9\":{\"would have\":\"verb_mistake\"},\"10\":{\"would have been\":\"verb_mistake_opposite\"},\"11\":{\"quite\":\"no_mistake\"},\"12\":{\"changed\":\"word_choice_mistake\"},\"13\":{\"different\":\"word_choice_mistake_opposite\"},\"14\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #031" do
    before do
      original_sentence = 'However, I think a success in life comes from careful planning when it is a usual situation.'
      corrected_sentence = 'However, under normal circumstances, I think success in life comes from careful planning.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"However\":\"no_mistake\"},\"1\":{\",\":\"no_mistake\"},\"2\":{\"under\":\"missing_word_mistake\"},\"3\":{\"normal\":\"missing_word_mistake\"},\"4\":{\"circumstances\":\"missing_word_mistake\"},\"5\":{\",\":\"punctuation_mistake\"},\"6\":{\"I\":\"no_mistake\"},\"7\":{\"think\":\"no_mistake\"},\"8\":{\"a\":\"unnecessary_word_mistake\"},\"9\":{\"success\":\"no_mistake\"},\"10\":{\"in\":\"no_mistake\"},\"11\":{\"life\":\"no_mistake\"},\"12\":{\"comes\":\"no_mistake\"},\"13\":{\"from\":\"no_mistake\"},\"14\":{\"careful\":\"no_mistake\"},\"15\":{\"planning\":\"no_mistake\"},\"16\":{\"when\":\"unnecessary_word_mistake\"},\"17\":{\"it\":\"unnecessary_word_mistake\"},\"18\":{\"is\":\"unnecessary_word_mistake\"},\"19\":{\"a\":\"unnecessary_word_mistake\"},\"20\":{\"usual\":\"unnecessary_word_mistake\"},\"21\":{\"situation\":\"unnecessary_word_mistake\"},\"22\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #032" do
    before do
      original_sentence = 'He is super rad.'
      corrected_sentence = 'He is super cool!'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"He\":\"no_mistake\"},\"1\":{\"is\":\"no_mistake\"},\"2\":{\"super\":\"no_mistake\"},\"3\":{\"rad\":\"word_choice_mistake\"},\"4\":{\"cool\":\"word_choice_mistake_opposite\"},\"5\":{\".\":\"punctuation_mistake\"},\"6\":{\"!\":\"punctuation_mistake_opposite\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  context "example correction #033" do
    before do
      original_sentence = 'I was not going to the party.'
      corrected_sentence = 'I did not go to the party.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq("{\"0\":{\"I\":\"no_mistake\"},\"1\":{\"was not going\":\"verb_mistake\"},\"2\":{\"did not go\":\"verb_mistake_opposite\"},\"3\":{\"to\":\"no_mistake\"},\"4\":{\"the\":\"no_mistake\"},\"5\":{\"party\":\"no_mistake\"},\"6\":{\".\":\"no_mistake\"}}")
    end

    # it 'Counts the number of mistakes' do
    #   expect(@cc.number_of_mistakes).to eq([])
    # end

    # it 'Reports the mistakes by mistake type' do
    #   expect(@cc.mistake_report).to eq([])
    # end
  end

  # context "example correction #034" do
  #   before do
  #     original_sentence = 'I had experiences to support my opinion which a success in life comes from careful planning.'
  #     corrected_sentence = 'I had experiences which support my opinion that success in life comes from careful planning.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #035" do
  #   before do
  #     original_sentence = 'She have a good day yesterday.'
  #     corrected_sentence = 'hello world'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #036" do
  #   before do
  #     original_sentence = 'If my school were located in Tokyo, situation would have quite changed.'
  #     corrected_sentence = 'If my school had been located in Tokyo, the situation would have been quite different.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #037" do
  #   before do
  #     original_sentence = 'I have three child'
  #     corrected_sentence = 'I have three children.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #038" do
  #   before do
  #     original_sentence = 'is the bag your'
  #     corrected_sentence = 'Is the bag yours?'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #039" do
  #   before do
  #     original_sentence = 'Is the bag your'
  #     corrected_sentence = 'Is this your bag?'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #040" do
  #   before do
  #     original_sentence = 'He doesnt wear a tie.'
  #     corrected_sentence = "He doesn't wear a tie."
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #041" do
  #   before do
  #     original_sentence = 'Rather than the TV, I feel the appearance of internet to be more interrupt our communication.'
  #     corrected_sentence = 'More than TV, I feel the appearance of internet to be more likely to interrupt our communication.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #042" do
  #   before do
  #     original_sentence = 'On the other point, we have seldom watched a TV recently than in the past.'
  #     corrected_sentence = 'On the other hand, we seldom watch TV compared to the past.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #043" do
  #   before do
  #     original_sentence = 'That is the why not only we can get information from TV, but also we can get information from the internet nowadays.'
  #     corrected_sentence = 'That is the reason why not only we can get information from TV, but also we can get information from the internet nowadays.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #044" do
  #   before do
  #     original_sentence = 'In the other hand, TV topic develop our relationship to provide some topics such as a news, drama, comedy, animation, and so on.'
  #     corrected_sentence = 'On the other hand, TV topics develop our relationship to provide some topics such as a news, drama, comedy, animation, and so on.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #045" do
  #   before do
  #     original_sentence = 'I carried.'
  #     corrected_sentence = 'I carry'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #046" do
  #   before do
  #     original_sentence = 'I went to the store. I bought some eggs.'
  #     corrected_sentence = 'I went to the store.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #047" do
  #   before do
  #     original_sentence = 'The laptop can make a lot of things such as a searching knowledge, writing down some memo, watching a movie and so on.'
  #     corrected_sentence = 'I can do a lot of things with the laptop such as searching knowledge, writing down some memos, watching a movie and so on.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #048" do
  #   before do
  #     original_sentence = 'Actually when I attended the international meeting, or American society for surgery of hand, at the trip.'
  #     corrected_sentence = 'Actually, I attended the international meeting for the American Society for surgery of hand while I was on the trip.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #049" do
  #   before do
  #     original_sentence = 'By the way, already got a demo of it working with video. maybe'
  #     corrected_sentence = 'By the way, already got a demo of it working with video, maybe we can try it sometime this week.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #050" do
  #   before do
  #     original_sentence = 'This year, going back to my work at my university, I have less time to spend my private time, for example, morning conference at 7:10 on Tuesday, at 7:30 on Thursday, preparation for operation, meeting, work for outpatients and so on.'
  #     corrected_sentence = 'This year, going back to work at my university, I have less private time, for example, morning conference at 7:10 on Tuesday, at 7:30 on Thursday, preparation for operations, meetings, work for outpatients and so on.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #051" do
  #   before do
  #     original_sentence = 'These are my things to keep healthy now.'
  #     corrected_sentence = 'These are the ways that I keep healthy now.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #052" do
  #   before do
  #     original_sentence = 'Her name was Dr. Cole.'
  #     corrected_sentence = 'Her name is Dr. Cole.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #053" do
  #   before do
  #     original_sentence = 'Because gravity.'
  #     corrected_sentence = 'Because of gravity'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #054" do
  #   before do
  #     original_sentence = 'I gots a dog.'
  #     corrected_sentence = 'I have a dog.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #055" do
  #   before do
  #     original_sentence = "what's hapen"
  #     corrected_sentence = 'what is happen'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #056" do
  #   before do
  #     original_sentence = 'what is happen'
  #     corrected_sentence = "what's happen"
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #057" do
  #   before do
  #     original_sentence = "That couldn't happen."
  #     corrected_sentence = 'That could not happen.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #058" do
  #   before do
  #     original_sentence = 'That could not happen.'
  #     corrected_sentence = "That couldn't happen."
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #059" do
  #   before do
  #     original_sentence = 'It was the night before Christmas.'
  #     corrected_sentence = "'Twas the night before Christmas."
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #060" do
  #   before do
  #     original_sentence = 'Yesterday, it was the night before Christmas.'
  #     corrected_sentence = "Yesterday, 'twas the night before Christmas."
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #061" do
  #   before do
  #     original_sentence = 'Usually we orthopedic surgeon suggest to take a operation which broken fermur neck replace to prosthesis.'
  #     corrected_sentence = 'Usually we orthopedic surgeons will suggest the patient to have an operation which replaces the broken fermur neck with prosthesis.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #062" do
  #   before do
  #     original_sentence = 'and I explained the x-ray result and I let her to hospitalize my hospital.'
  #     corrected_sentence = 'I explained the x-ray result and I hospitalized her at my hospital.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #063" do
  #   before do
  #     original_sentence = 'But she had some difficulty in her condition: heart ischemia which had recently operation of PCI, COPD: chornic objective pulmpnary disease, chornic kidney failure which had had treated on regular hemodyalisis for some decade.'
  #     corrected_sentence = 'But she had some difficulty in her condition: heart ischemia which had recently operation of PCI, COPD: chronic objective pulmonary disease, chronic kidney failure which had been treated with regular hemodyalisis for some decades.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #064" do
  #   before do
  #     original_sentence = 'If she cannot be take the operation, she usually cannot walk at all and needs any other’s help forever.'
  #     corrected_sentence = "If she cannot have the operation, she probably will not be able to walk at all and will need another person's help forever."
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #065" do
  #   before do
  #     original_sentence = 'That is why I recommend her and her family to take the operation even if she has a lot of disease.'
  #     corrected_sentence = 'That is why I recommend her and her family to have the operation even if she has a lot of diseases.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #066" do
  #   before do
  #     original_sentence = 'But my superior boss should not to take the operation careless.'
  #     corrected_sentence = 'But my superior boss said not to take the operation carelessly.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #067" do
  #   before do
  #     original_sentence = 'The boss and group had the experience the death of a patient after the operation in 3 week.'
  #     corrected_sentence = 'The boss and group had the experience of the death of a patient 3 weeks after the operation.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #068" do
  #   before do
  #     original_sentence = 'At the time, the boss and our group was accused by sudden death.'
  #     corrected_sentence = 'At the time, the boss and our group were accused of sudden death.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #069" do
  #   before do
  #     original_sentence = 'Even if the family and the patients understood the explain, the result was bad, the family complained the result.'
  #     corrected_sentence = 'Even if the family and the patients understood the explanation, the result was bad, and the family complained about the result.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end

  # context "example correction #070" do
  #   before do
  #     original_sentence = 'Me and Bill went to the store.'
  #     corrected_sentence = 'Bill and I went to the store.'
  #     @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
  #   end

  #   it 'Annotates the corrections' do
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
  #     expect(@cc.correct).to eq([])
  #   end

  #   it 'Counts the number of mistakes' do
  #     expect(@cc.number_of_mistakes).to eq([])
  #   end

  #   it 'Reports the mistakes by mistake type' do
  #     expect(@cc.mistake_report).to eq([])
  #   end
  # end
end
