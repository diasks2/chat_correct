require 'spec_helper'

RSpec.describe ChatCorrect::Correct do
  it 'Correctly annotates the correction #001' do
    original_sentence = ''
    corrected_sentence = ''
    cc = ChatCorrect::Correct.new(original_sentence: original_sentence, corrected_sentence: corrected_sentence)
    expect(cc.correct).to eq([])
  end
end