require 'spec_helper'

RSpec.describe ChatCorrect::Time do
  it 'returns true if the text is a time' do
    text = "10:25 AM"
    cc = ChatCorrect::Time.new(text: text)
    expect(cc.is_time?).to eq(true)
  end

  it 'returns true if the text is a time' do
    text = "23:11"
    cc = ChatCorrect::Time.new(text: text)
    expect(cc.is_time?).to eq(true)
  end

  it 'returns false if the text is not a time' do
    text = "January 1st: It's the new year."
    cc = ChatCorrect::Time.new(text: text)
    expect(cc.is_time?).to eq(false)
  end
end
