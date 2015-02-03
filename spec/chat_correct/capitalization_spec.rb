require 'spec_helper'

RSpec.describe ChatCorrect::Capitalization do
  it 'returns true if a capitalization error is found' do
    token_a = 'Hello'
    token_b = 'hello'
    cc = ChatCorrect::Capitalization.new(token_a: token_a, token_b: token_b)
    expect(cc.capitalization_error?).to eq(true)
  end

  it 'returns false if a capitalization error is not found' do
    token_a = 'Hello'
    token_b = 'Hello'
    cc = ChatCorrect::Capitalization.new(token_a: token_a, token_b: token_b)
    expect(cc.capitalization_error?).to eq(false)
  end
end
