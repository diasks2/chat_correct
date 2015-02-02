require 'spec_helper'

RSpec.describe ChatCorrect::Correct do
  context "example correction #001 (no mistakes)" do
    before do
      original_sentence = 'There are no mistakes here.'
      corrected_sentence = 'There are no mistakes here.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #002" do
    before do
      original_sentence = 'is the, puncttuation are wrong.'
      corrected_sentence = 'Is the punctuation wrong?'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #003" do
    before do
      original_sentence = 'I need go shopping at this weekend.'
      corrected_sentence = 'I need to go shopping this weekend.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #004" do
    before do
      original_sentence = 'I go trip last month.'
      corrected_sentence = 'I went on a trip last month.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #005" do
    before do
      original_sentence = 'This is an exclamation.'
      corrected_sentence = 'This is an exclamation!'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #006" do
    before do
      original_sentence = 'what am i thinking!'
      corrected_sentence = 'What was I thinking?'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #007" do
    before do
      original_sentence = 'There arre lotts of misspeellings.'
      corrected_sentence = 'There are a lot of misspellings.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #008" do
    before do
      original_sentence = 'There arre lotts, off consecutiveee misspeellings!'
      corrected_sentence = 'There are a lot of consecutive misspellings.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #009" do
    before do
      original_sentence = 'This is a double double double word check.'
      corrected_sentence = 'This is a double word check.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #010" do
    before do
      original_sentence = 'This is and this and this is a correct double word check!'
      corrected_sentence = 'This is and this and this is a correct double word check.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #011" do
    before do
      original_sentence = 'He said, "Shhe is a crazy girl".'
      corrected_sentence = 'He said, "She is a crazy girl."'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #012" do
    before do
      original_sentence = 'Test the order word.'
      corrected_sentence = 'Test the word order.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #013" do
    before do
      original_sentence = 'This is a double double double double word check.'
      corrected_sentence = 'This is a double word check.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #014" do
    before do
      original_sentence = 'I call my mom tomorrow.'
      corrected_sentence = 'I will call my mom tomorrow.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #015" do
    before do
      original_sentence = 'I flied home yesterday.'
      corrected_sentence = 'I flew home yesterday.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #016" do
    before do
      original_sentence = "This shouldn't be use to test contractions, but couln't it?"
      corrected_sentence = "This shouldn't be used to test contractions, but couldn't it?"
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #017" do
    before do
      original_sentence = "This is to test, 'single quotes'."
      corrected_sentence = "This is to test, 'Single quotes.'"
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #018" do
    before do
      original_sentence = 'This is to test quotations "again"'
      corrected_sentence = 'This is to test quotations again'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #019" do
    before do
      original_sentence = 'I will call my mom yesterday.'
      corrected_sentence = 'I called my mom yesterday.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #020" do
    before do
      original_sentence = 'Test run the order word with anotther mistake.'
      corrected_sentence = 'Test the word order with another simple mistake.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #021" do
    before do
      original_sentence = 'This is to test quotations "again".'
      corrected_sentence = 'This is to test quotations again.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #022" do
    before do
      original_sentence = 'This is to test quotations "again"'
      corrected_sentence = 'This is to test quotations again.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #023" do
    before do
      original_sentence = "He didn't realize that he should had changed the locks."
      corrected_sentence = "He hadn't realized that he should have changed the locks."
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #024" do
    before do
      original_sentence = 'I will call my mom yesterday if I had time.'
      corrected_sentence = 'I would have called my mom yesterday if I had had time.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #025" do
    before do
      original_sentence = 'I call my mom yesterday.'
      corrected_sentence = 'I would have called my mom yesterday.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #026" do
    before do
      original_sentence = 'I singed at the karaoke bar.'
      corrected_sentence = 'I sang at the karaoke bar.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #027" do
    before do
      original_sentence = 'I flied to California and go to zoo.'
      corrected_sentence = 'I flew to California and went to the zoo.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #028" do
    before do
      original_sentence = 'This is a double double double double double word check.'
      corrected_sentence = 'This is a double word check.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #029" do
    before do
      original_sentence = 'This is a double double double double double double word check.'
      corrected_sentence = 'This is a double word check.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #030" do
    before do
      original_sentence = 'If my school were located in Tokyo, situation would have quite changed.'
      corrected_sentence = 'If my school were located in Tokyo, the situation would have been quite different.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #031" do
    before do
      original_sentence = 'However, I think a success in life comes from careful planning when it is a usual situation.'
      corrected_sentence = 'However, under normal circumstances, I think success in life comes from careful planning.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #032" do
    before do
      original_sentence = 'He is super rad.'
      corrected_sentence = 'He is super cool!'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #033" do
    before do
      original_sentence = 'I was not going to the party.'
      corrected_sentence = 'I did not go to the party.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #034" do
    before do
      original_sentence = 'I had experiences to support my opinion which a success in life comes from careful planning.'
      corrected_sentence = 'I had experiences which support my opinion that success in life comes from careful planning.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #035" do
    before do
      original_sentence = 'She have a good day yesterday.'
      corrected_sentence = 'hello world'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #036" do
    before do
      original_sentence = 'If my school were located in Tokyo, situation would have quite changed.'
      corrected_sentence = 'If my school had been located in Tokyo, the situation would have been quite different.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #037" do
    before do
      original_sentence = 'I have three child'
      corrected_sentence = 'I have three children.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #038" do
    before do
      original_sentence = 'is the bag your'
      corrected_sentence = 'Is the bag yours?'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #039" do
    before do
      original_sentence = 'Is the bag your'
      corrected_sentence = 'Is this your bag?'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #040" do
    before do
      original_sentence = 'He doesnt wear a tie.'
      corrected_sentence = "He doesn't wear a tie."
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #041" do
    before do
      original_sentence = 'Rather than the TV, I feel the appearance of internet to be more interrupt our communication.'
      corrected_sentence = 'More than TV, I feel the appearance of internet to be more likely to interrupt our communication.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #042" do
    before do
      original_sentence = 'On the other point, we have seldom watched a TV recently than in the past.'
      corrected_sentence = 'On the other hand, we seldom watch TV compared to the past.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #043" do
    before do
      original_sentence = 'That is the why not only we can get information from TV, but also we can get information from the internet nowadays.'
      corrected_sentence = 'That is the reason why not only we can get information from TV, but also we can get information from the internet nowadays.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #044" do
    before do
      original_sentence = 'In the other hand, TV topic develop our relationship to provide some topics such as a news, drama, comedy, animation, and so on.'
      corrected_sentence = 'On the other hand, TV topics develop our relationship to provide some topics such as a news, drama, comedy, animation, and so on.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #045" do
    before do
      original_sentence = 'I carried.'
      corrected_sentence = 'I carry'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #046" do
    before do
      original_sentence = 'I went to the store. I bought some eggs.'
      corrected_sentence = 'I went to the store.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #047" do
    before do
      original_sentence = 'The laptop can make a lot of things such as a searching knowledge, writing down some memo, watching a movie and so on.'
      corrected_sentence = 'I can do a lot of things with the laptop such as searching knowledge, writing down some memos, watching a movie and so on.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #048" do
    before do
      original_sentence = 'Actually when I attended the international meeting, or American society for surgery of hand, at the trip.'
      corrected_sentence = 'Actually, I attended the international meeting for the American Society for surgery of hand while I was on the trip.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #049" do
    before do
      original_sentence = 'By the way, already got a demo of it working with video. maybe'
      corrected_sentence = 'By the way, already got a demo of it working with video, maybe we can try it sometime this week.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #050" do
    before do
      original_sentence = 'This year, going back to my work at my university, I have less time to spend my private time, for example, morning conference at 7:10 on Tuesday, at 7:30 on Thursday, preparation for operation, meeting, work for outpatients and so on.'
      corrected_sentence = 'This year, going back to work at my university, I have less private time, for example, morning conference at 7:10 on Tuesday, at 7:30 on Thursday, preparation for operations, meetings, work for outpatients and so on.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #051" do
    before do
      original_sentence = 'These are my things to keep healthy now.'
      corrected_sentence = 'These are the ways that I keep healthy now.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #052" do
    before do
      original_sentence = 'Her name was Dr. Cole.'
      corrected_sentence = 'Her name is Dr. Cole.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #053" do
    before do
      original_sentence = 'Because gravity.'
      corrected_sentence = 'Because of gravity'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #054" do
    before do
      original_sentence = 'I gots a dog.'
      corrected_sentence = 'I have a dog.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #055" do
    before do
      original_sentence = "what's hapen"
      corrected_sentence = 'what is happen'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #056" do
    before do
      original_sentence = 'what is happen'
      corrected_sentence = "what's happen"
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #057" do
    before do
      original_sentence = "That couldn't happen."
      corrected_sentence = 'That could not happen.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #058" do
    before do
      original_sentence = 'That could not happen.'
      corrected_sentence = "That couldn't happen."
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #059" do
    before do
      original_sentence = 'It was the night before Christmas.'
      corrected_sentence = "'Twas the night before Christmas."
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #060" do
    before do
      original_sentence = 'Yesterday, it was the night before Christmas.'
      corrected_sentence = "Yesterday, 'twas the night before Christmas."
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #061" do
    before do
      original_sentence = 'Usually we orthopedic surgeon suggest to take a operation which broken fermur neck replace to prosthesis.'
      corrected_sentence = 'Usually we orthopedic surgeons will suggest the patient to have an operation which replaces the broken fermur neck with prosthesis.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #062" do
    before do
      original_sentence = 'and I explained the x-ray result and I let her to hospitalize my hospital.'
      corrected_sentence = 'I explained the x-ray result and I hospitalized her at my hospital.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #063" do
    before do
      original_sentence = 'But she had some difficulty in her condition: heart ischemia which had recently operation of PCI, COPD: chornic objective pulmpnary disease, chornic kidney failure which had had treated on regular hemodyalisis for some decade.'
      corrected_sentence = 'But she had some difficulty in her condition: heart ischemia which had recently operation of PCI, COPD: chronic objective pulmonary disease, chronic kidney failure which had been treated with regular hemodyalisis for some decades.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #064" do
    before do
      original_sentence = 'If she cannot be take the operation, she usually cannot walk at all and needs any other’s help forever.'
      corrected_sentence = "If she cannot have the operation, she probably will not be able to walk at all and will need another person's help forever."
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #065" do
    before do
      original_sentence = 'That is why I recommend her and her family to take the operation even if she has a lot of disease.'
      corrected_sentence = 'That is why I recommend her and her family to have the operation even if she has a lot of diseases.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #066" do
    before do
      original_sentence = 'But my superior boss should not to take the operation careless.'
      corrected_sentence = 'But my superior boss said not to take the operation carelessly.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #067" do
    before do
      original_sentence = 'The boss and group had the experience the death of a patient after the operation in 3 week.'
      corrected_sentence = 'The boss and group had the experience of the death of a patient 3 weeks after the operation.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #068" do
    before do
      original_sentence = 'At the time, the boss and our group was accused by sudden death.'
      corrected_sentence = 'At the time, the boss and our group were accused of sudden death.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #069" do
    before do
      original_sentence = 'Even if the family and the patients understood the explain, the result was bad, the family complained the result.'
      corrected_sentence = 'Even if the family and the patients understood the explanation, the result was bad, and the family complained about the result.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #070" do
    before do
      original_sentence = 'Me and Bill went to the store.'
      corrected_sentence = 'Bill and I went to the store.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #071" do
    before do
      original_sentence = 'In my situation, I feel a little anger, when my child will not ignore about our suggestion, or favors, however, I do not want to ignore about my child or beat him.'
      corrected_sentence = 'In my situation, I feel a little anger, when my child ignores our suggestion, or favors, however, I do not want to ignore my child or beat him.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #072" do
    before do
      original_sentence = 'in my experience, it is one of the good parents skill to endure our children trickery behavior or fretting attitude.'
      corrected_sentence = "In my experience, it is one of the good parents skill to endure our children's trickery or fretting attitude."
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #073" do
    before do
      original_sentence = 'When he gets tired or has a unwillingness to do, he gets anger, or not to obey my suggestion.'
      corrected_sentence = 'When he gets tired or has an unwillingness to do something, he gets angry, or does not obey my suggestion.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #074" do
    before do
      original_sentence = 'And I feel always to anger, I always hold his body tightly.'
      corrected_sentence = 'And I always feel anger, and I always hold his body tightly.'
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #075" do
    before do
      original_sentence = 'I think that it is difficult to be endure children rude behavior, therefore the skill to endure is one of the skill to be a good parents.'
      corrected_sentence = "I think that it is difficult to endure children's rude behavior, therefore the skill to endure is one of the skills to be a good parent."
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #076" do
    before do
      original_sentence = 'That is the Smiths car.'
      corrected_sentence = "That is the Smiths' car."
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end

  context "example correction #077" do
    before do
      original_sentence = 'That is Bens car.'
      corrected_sentence = "That is Ben's car."
      @cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    end

    it 'Annotates the corrections' do
      expect(@cc.correct).to eq([])
    end

    it 'Counts the number of mistakes' do
      expect(@cc.number_of_mistakes).to eq([])
    end

    it 'Reports the mistakes by mistake type' do
      expect(@cc.mistake_report).to eq([])
    end
  end
end
