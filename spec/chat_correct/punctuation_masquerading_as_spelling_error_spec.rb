require 'spec_helper'

RSpec.describe ChatCorrect::PunctuationMasqueradingAsSpellingError do
  it 'identifies words where the punctuation may masquerade as a spelling error in the algorithm #001' do
    word_a = 'canƪt'
    word_b = 'cant'
    cc = ChatCorrect::PunctuationMasqueradingAsSpellingError.new(word_a: word_a, word_b: word_b)
    expect(cc.exists?).to eq(true)
  end

  it 'identifies words where the punctuation may masquerade as a spelling error in the algorithm #002' do
    word_a = 'cant'
    word_b = 'canƪt'
    cc = ChatCorrect::PunctuationMasqueradingAsSpellingError.new(word_a: word_a, word_b: word_b)
    expect(cc.exists?).to eq(true)
  end

  it 'returns false for regualr spelling mistakes' do
    word_a = 'speeling'
    word_b = 'spelling'
    cc = ChatCorrect::PunctuationMasqueradingAsSpellingError.new(word_a: word_a, word_b: word_b)
    expect(cc.exists?).to eq(false)
  end
end