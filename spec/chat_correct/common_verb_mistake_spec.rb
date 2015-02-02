require 'spec_helper'

RSpec.describe ChatCorrect::CommonVerbMistake do
  it 'returns true if a common verb mistake is found #001' do
    word_a = 'freezed'
    word_b = 'froze'
    cc = ChatCorrect::CommonVerbMistake.new(word_a: word_a, word_b: word_b)
    expect(cc.exists?).to eq(true)
  end

  it 'returns true if a common verb mistake is found #002' do
    word_a = 'froze'
    word_b = 'freezed'
    cc = ChatCorrect::CommonVerbMistake.new(word_a: word_a, word_b: word_b)
    expect(cc.exists?).to eq(true)
  end

  it 'returns true if a common verb mistake is found #003' do
    word_a = 'cooked'
    word_b = 'cooks'
    cc = ChatCorrect::CommonVerbMistake.new(word_a: word_a, word_b: word_b)
    expect(cc.exists?).to eq(false)
  end
end
