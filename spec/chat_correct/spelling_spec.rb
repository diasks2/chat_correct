require 'spec_helper'

RSpec.describe ChatCorrect::Spelling do
  it 'returns true if a spelling mistake is found #001' do
    token_a = 'speeling'
    token_b = 'spelling'
    cc = ChatCorrect::Spelling.new(token_a: token_a, token_b: token_b)
    expect(cc.spelling_error?).to eq(true)
  end

  it 'returns false if a spelling mistake is not found #002' do
    token_a = 'cold'
    token_b = 'warm'
    cc = ChatCorrect::Spelling.new(token_a: token_a, token_b: token_b)
    expect(cc.spelling_error?).to eq(false)
  end

  it 'returns false if a spelling mistake is not found #003' do
    token_a = 'the'
    token_b = 'of'
    cc = ChatCorrect::Spelling.new(token_a: token_a, token_b: token_b)
    expect(cc.spelling_error?).to eq(false)
  end

  it 'returns false if a spelling mistake is not found #004' do
    token_a = '??'
    token_b = '???'
    cc = ChatCorrect::Spelling.new(token_a: token_a, token_b: token_b)
    expect(cc.spelling_error?).to eq(false)
  end

  it 'returns true if a spelling mistake is found #005' do
    token_a = 'original'
    token_b = 'originnal'
    cc = ChatCorrect::Spelling.new(token_a: token_a, token_b: token_b)
    expect(cc.spelling_error?).to eq(true)
  end

  it 'returns false if a spelling mistake is not found #006' do
    token_a = 'a'
    token_b = 'b'
    cc = ChatCorrect::Spelling.new(token_a: token_a, token_b: token_b)
    expect(cc.spelling_error?).to eq(false)
  end

  it 'returns false if a spelling mistake is not found #007' do
    token_a = 'that'
    token_b = 'this'
    cc = ChatCorrect::Spelling.new(token_a: token_a, token_b: token_b)
    expect(cc.spelling_error?).to eq(false)
  end

  it 'returns false if a spelling mistake is not found #007' do
    token_a = 'is'
    token_b = 'Is'
    cc = ChatCorrect::Spelling.new(token_a: token_a, token_b: token_b)
    expect(cc.spelling_error?).to eq(false)
  end
end
