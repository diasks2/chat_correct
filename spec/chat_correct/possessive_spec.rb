require 'spec_helper'

RSpec.describe ChatCorrect::Possessive do
  it 'is a possessive #001' do
    word_a = 'Johnƪs'
    word_b = 'John'
    cc = ChatCorrect::Possessive.new(word_a: word_a, word_b: word_b)
    expect(cc.possessive?).to eq(true)
  end

  it 'is a possessive #002' do
    word_a = 'John∮s'
    word_b = 'John'
    cc = ChatCorrect::Possessive.new(word_a: word_a, word_b: word_b)
    expect(cc.possessive?).to eq(true)
  end

  it 'is a possessive #003' do
    word_a = 'John'
    word_b = 'Johnƪs'
    cc = ChatCorrect::Possessive.new(word_a: word_a, word_b: word_b)
    expect(cc.possessive?).to eq(true)
  end

  it 'is a possessive #004' do
    word_a = 'John'
    word_b = 'John∮s'
    cc = ChatCorrect::Possessive.new(word_a: word_a, word_b: word_b)
    expect(cc.possessive?).to eq(true)
  end
end