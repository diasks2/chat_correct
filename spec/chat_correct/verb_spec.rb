require 'spec_helper'

RSpec.describe ChatCorrect::Verb do

  it 'returns true if a verb error is found #001' do
    word = 'was'
    text = 'He is awesome.'
    pos = 'v'
    cc = ChatCorrect::Verb.new(word: word, pos: pos, text: text)
    expect(cc.verb_error?).to eq(true)
  end

  it 'returns true if a verb error is found #002' do
    word = 'buy'
    text = 'He bought some shoes.'
    pos = 'v'
    cc = ChatCorrect::Verb.new(word: word, pos: pos, text: text)
    expect(cc.verb_error?).to eq(true)
  end

  it 'returns false if it is not a verb #003' do
    word = 'buy'
    text = 'He bought some shoes.'
    pos = 'n'
    cc = ChatCorrect::Verb.new(word: word, pos: pos, text: text)
    expect(cc.verb_error?).to eq(false)
  end

  it 'returns false if it is not a verb error #004' do
    word = 'threw'
    text = 'He bought some shoes.'
    pos = 'v'
    cc = ChatCorrect::Verb.new(word: word, pos: pos, text: text)
    expect(cc.verb_error?).to eq(false)
  end

  it 'returns true if a verb error is found #005' do
    word = 'eat'
    text = 'I ate dinner.'
    pos = 'v'
    cc = ChatCorrect::Verb.new(word: word, pos: pos, text: text)
    expect(cc.verb_error?).to eq(true)
  end

  it 'returns true if a verb error is found #005' do
    word = 'win'
    text = 'I won a medal.'
    pos = 'v'
    cc = ChatCorrect::Verb.new(word: word, pos: pos, text: text)
    expect(cc.verb_error?).to eq(true)
  end

  it 'returns true if a verb error is found #005' do
    word = 'file'
    text = 'I filed the papers.'
    pos = 'v'
    cc = ChatCorrect::Verb.new(word: word, pos: pos, text: text)
    expect(cc.verb_error?).to eq(true)
  end
end
