require 'spec_helper'

RSpec.describe ChatCorrect::PunctuationMasqueradingAsSpellingError do
  it 'identifies words where the punctuation may masquerade as a spelling error in the algorithm #001' do
    token_a = 'canƪt'
    token_b = 'cant'
    cc = ChatCorrect::PunctuationMasqueradingAsSpellingError.new(token_a: token_a, token_b: token_b)
    expect(cc.exists?).to eq(true)
  end

  it 'identifies words where the punctuation may masquerade as a spelling error in the algorithm #002' do
    token_a = 'cant'
    token_b = 'canƪt'
    cc = ChatCorrect::PunctuationMasqueradingAsSpellingError.new(token_a: token_a, token_b: token_b)
    expect(cc.exists?).to eq(true)
  end

  it 'returns false for regualr spelling mistakes' do
    token_a = 'speeling'
    token_b = 'spelling'
    cc = ChatCorrect::PunctuationMasqueradingAsSpellingError.new(token_a: token_a, token_b: token_b)
    expect(cc.exists?).to eq(false)
  end
end
