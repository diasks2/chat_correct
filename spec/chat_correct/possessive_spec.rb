require 'spec_helper'

RSpec.describe ChatCorrect::Possessive do
  it 'is a possessive #001' do
    token_a = 'Johnƪs'
    token_b = 'John'
    cc = ChatCorrect::Possessive.new(token_a: token_a, token_b: token_b)
    expect(cc.possessive?).to eq(true)
  end

  it 'is a possessive #002' do
    token_a = 'John∮s'
    token_b = 'John'
    cc = ChatCorrect::Possessive.new(token_a: token_a, token_b: token_b)
    expect(cc.possessive?).to eq(true)
  end

  it 'is a possessive #003' do
    token_a = 'John'
    token_b = 'Johnƪs'
    cc = ChatCorrect::Possessive.new(token_a: token_a, token_b: token_b)
    expect(cc.possessive?).to eq(true)
  end

  it 'is a possessive #004' do
    token_a = 'John'
    token_b = 'John∮s'
    cc = ChatCorrect::Possessive.new(token_a: token_a, token_b: token_b)
    expect(cc.possessive?).to eq(true)
  end
end
