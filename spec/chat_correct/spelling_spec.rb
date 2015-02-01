require 'spec_helper'

RSpec.describe ChatCorrect::Spelling do
  it 'returns true if a spelling mistake is found #001' do
    word_a = 'speeling'
    word_b = 'spelling'
    cc = ChatCorrect::Spelling.new(word_a: word_a, word_b: word_b)
    expect(cc.spelling_error?).to eq(true)
  end

  it 'returns false if a spelling mistake is not found #002' do
    word_a = 'cold'
    word_b = 'warm'
    cc = ChatCorrect::Spelling.new(word_a: word_a, word_b: word_b)
    expect(cc.spelling_error?).to eq(false)
  end

  it 'returns false if a spelling mistake is not found #003' do
    word_a = 'the'
    word_b = 'of'
    cc = ChatCorrect::Spelling.new(word_a: word_a, word_b: word_b)
    expect(cc.spelling_error?).to eq(false)
  end

  it 'returns false if a spelling mistake is not found #004' do
    word_a = '??'
    word_b = '???'
    cc = ChatCorrect::Spelling.new(word_a: word_a, word_b: word_b)
    expect(cc.spelling_error?).to eq(false)
  end

  it 'returns true if a spelling mistake is found #005' do
    word_a = 'original'
    word_b = 'originnal'
    cc = ChatCorrect::Spelling.new(word_a: word_a, word_b: word_b)
    expect(cc.spelling_error?).to eq(true)
  end

  it 'returns false if a spelling mistake is not found #006' do
    word_a = 'a'
    word_b = 'b'
    cc = ChatCorrect::Spelling.new(word_a: word_a, word_b: word_b)
    expect(cc.spelling_error?).to eq(false)
  end

  it 'returns false if a spelling mistake is not found #006' do
    word_a = 'that'
    word_b = 'this'
    cc = ChatCorrect::Spelling.new(word_a: word_a, word_b: word_b)
    expect(cc.spelling_error?).to eq(false)
  end
end