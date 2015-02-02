require 'spec_helper'

RSpec.describe ChatCorrect::Punctuation do
  it 'returns true if the text is a punctuation mark #001' do
    text = '?'
    cc = ChatCorrect::Punctuation.new(text: text)
    expect(cc.is_punctuation?).to eq(true)
  end

  it 'returns true if the text is a punctuation mark #002' do
    text = '∯'
    cc = ChatCorrect::Punctuation.new(text: text)
    expect(cc.is_punctuation?).to eq(true)
  end

  it 'returns true if the text is a punctuation mark #003' do
    text = 'hello'
    cc = ChatCorrect::Punctuation.new(text: text)
    expect(cc.is_punctuation?).to eq(false)
  end
end
