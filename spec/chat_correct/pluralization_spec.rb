require 'spec_helper'

RSpec.describe ChatCorrect::Pluralization do
  context '#capitalization_check' do
    it 'returns true if a pluralization error is found #001' do
      word_a = 'chicken'
      word_b = 'chickens'
      cc = ChatCorrect::Pluralization.new(word_a: word_a, word_b: word_b)
      expect(cc.pluralization_error?).to eq(true)
    end

    it 'returns true if a pluralization error is found #002' do
      word_a = 'chickens'
      word_b = 'chicken'
      cc = ChatCorrect::Pluralization.new(word_a: word_a, word_b: word_b)
      expect(cc.pluralization_error?).to eq(true)
    end

    it 'returns true if a pluralization error is found #003' do
      word_a = 'goose'
      word_b = 'geese'
      cc = ChatCorrect::Pluralization.new(word_a: word_a, word_b: word_b)
      expect(cc.pluralization_error?).to eq(true)
    end

    it 'returns false if a pluralization error is not found #004' do
      word_a = 'hears'
      word_b = 'heard'
      cc = ChatCorrect::Pluralization.new(word_a: word_a, word_b: word_b)
      expect(cc.pluralization_error?).to eq(false)
    end
  end
end