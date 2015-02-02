require 'spec_helper'

RSpec.describe ChatCorrect::CombineMultiWordVerbs do
  it 'returns an array' do
    sentence = 'hello'
    cc = ChatCorrect::CombineMultiWordVerbs.new(sentence: sentence)
    expect(cc.combine).to eq([])
  end
end
