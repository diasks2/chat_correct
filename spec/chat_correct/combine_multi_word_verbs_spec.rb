require 'spec_helper'

RSpec.describe ChatCorrect::CombineMultiWordVerbs do
  it 'returns an array' do
    sentence = 'I would have gone to the store.'
    cc = ChatCorrect::CombineMultiWordVerbs.new(sentence: sentence)
    expect(cc.combine).to eq(["I", "would have gone", "have", "gone", "to", "the", "store", "."])
  end

  it 'returns an array' do
    sentence = 'I will go to the store.'
    cc = ChatCorrect::CombineMultiWordVerbs.new(sentence: sentence)
    expect(cc.combine).to eq(["I", "will go", "go", "to", "the", "store", "."])
  end
end
