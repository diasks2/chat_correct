require 'spec_helper'

RSpec.describe ChatCorrect::CombineMultiWordVerbs do
  it 'returns an array' do
    text = 'I would have gone to the store.'
    cc = ChatCorrect::CombineMultiWordVerbs.new(text: text)
    expect(cc.combine).to eq(["I", "would have gone", "to", "the", "store", "."])
  end

  it 'returns an array' do
    text = 'I will go to the store.'
    cc = ChatCorrect::CombineMultiWordVerbs.new(text: text)
    expect(cc.combine).to eq(["I", "will go", "to", "the", "store", "."])
  end

  it 'returns an array' do
    text = "He didn't realize that he should had changed the locks."
    cc = ChatCorrect::CombineMultiWordVerbs.new(text: text)
    expect(cc.combine).to eq(["He", "didnƪt realize", "that", "he", "should", "had changed", "the", "locks", "."])
  end

  it 'returns an array' do
    text = "He hadn't realized that he should have changed the locks."
    cc = ChatCorrect::CombineMultiWordVerbs.new(text: text)
    expect(cc.combine).to eq(["He", "hadnƪt realized", "that", "he", "should", "have changed", "the", "locks", "."])
  end
end
