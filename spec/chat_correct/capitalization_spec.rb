require 'spec_helper'

RSpec.describe ChatCorrect::Capitalization do
  context '#capitalization_check' do
    it 'returns true if a capitalization error is found' do
      word_a = 'Hello'
      word_b = 'hello'
      cc = ChatCorrect::Capitalization.new(word_a: word_a, word_b: word_b)
      expect(cc.capitalization_error?).to eq(true)
    end

    it 'returns false if a capitalization error is not found' do
      word_a = 'Hello'
      word_b = 'Hello'
      cc = ChatCorrect::Capitalization.new(word_a: word_a, word_b: word_b)
      expect(cc.capitalization_error?).to eq(false)
    end
  end
end