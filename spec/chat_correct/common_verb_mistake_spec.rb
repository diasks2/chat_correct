require 'spec_helper'

RSpec.describe ChatCorrect::CommonVerbMistake do
  it 'returns true if a common verb mistake is found #001' do
    token_a = 'freezed'
    token_b = 'froze'
    cc = ChatCorrect::CommonVerbMistake.new(token_a: token_a, token_b: token_b)
    expect(cc.exists?).to eq(true)
  end

  it 'returns true if a common verb mistake is found #002' do
    token_a = 'froze'
    token_b = 'freezed'
    cc = ChatCorrect::CommonVerbMistake.new(token_a: token_a, token_b: token_b)
    expect(cc.exists?).to eq(true)
  end

  it 'returns true if a common verb mistake is found #003' do
    token_a = 'cooked'
    token_b = 'cooks'
    cc = ChatCorrect::CommonVerbMistake.new(token_a: token_a, token_b: token_b)
    expect(cc.exists?).to eq(false)
  end
end
