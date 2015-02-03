require 'spec_helper'

RSpec.describe ChatCorrect::Pluralization do
  it 'returns true if a pluralization error is found #001' do
    token_a = 'chicken'
    token_b = 'chickens'
    cc = ChatCorrect::Pluralization.new(token_a: token_a, token_b: token_b)
    expect(cc.pluralization_error?).to eq(true)
  end

  it 'returns true if a pluralization error is found #002' do
    token_a = 'chickens'
    token_b = 'chicken'
    cc = ChatCorrect::Pluralization.new(token_a: token_a, token_b: token_b)
    expect(cc.pluralization_error?).to eq(true)
  end

  it 'returns true if a pluralization error is found #003' do
    token_a = 'goose'
    token_b = 'geese'
    cc = ChatCorrect::Pluralization.new(token_a: token_a, token_b: token_b)
    expect(cc.pluralization_error?).to eq(true)
  end

  it 'returns false if a pluralization error is not found #004' do
    token_a = 'hears'
    token_b = 'heard'
    cc = ChatCorrect::Pluralization.new(token_a: token_a, token_b: token_b)
    expect(cc.pluralization_error?).to eq(false)
  end
end
