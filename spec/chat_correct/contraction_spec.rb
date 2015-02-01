require 'spec_helper'

RSpec.describe ChatCorrect::Contraction do
  it 'handles nil values' do
    word_a = nil
    word_b = nil
    contraction = nil
    cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
    expect(cc.contraction?).to eq(false)
  end

  context 'contractions including not' do
    it 'returns true if it is a contraction' do
      word_a = 'am'
      word_b = 'not'
      contraction = 'ainƪt'
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction' do
      word_a = 'am'
      word_b = 'not'
      contraction = "ain't"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction' do
      word_a = 'is'
      word_b = 'not'
      contraction = "isn't"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction' do
      word_a = 'should'
      word_b = 'not'
      contraction = "shouldn't"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns false if it is a contraction' do
      word_a = 'is'
      word_b = 'not'
      contraction = "is't"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(false)
    end
  end

  context 'contractions including us' do
    it 'returns true if it is a contraction' do
      word_a = 'let'
      word_b = 'us'
      contraction = "let's"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end
  end

  context 'contractions including am' do
    it 'returns true if it is a contraction' do
      word_a = 'I'
      word_b = 'am'
      contraction = "I'm"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end
  end

  context 'contractions including are' do
    it 'returns true if it is a contraction' do
      word_a = 'You'
      word_b = 'are'
      contraction = "You're"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns false if it is a contraction' do
      word_a = 'You'
      word_b = 'are'
      contraction = "you'rre"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(false)
    end
  end

  context 'contractions including is, does, has' do
    it 'returns true if it is a contraction' do
      word_a = 'she'
      word_b = 'is'
      contraction = "she's"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction' do
      word_a = 'she'
      word_b = 'does'
      contraction = "she's"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction' do
      word_a = 'she'
      word_b = 'has'
      contraction = "she's"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns false if it is not a contraction' do
      word_a = 'she'
      word_b = 'has'
      contraction = "she'ss"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(false)
    end
  end

  context 'contractions including have' do
    it 'returns true if it is a contraction' do
      word_a = 'You'
      word_b = 'have'
      contraction = "You've"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end
  end

  context 'contractions including had, did, would' do
    it 'returns true if it is a contraction' do
      word_a = 'she'
      word_b = 'had'
      contraction = "she'd"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction' do
      word_a = 'she'
      word_b = 'did'
      contraction = "she'd"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction' do
      word_a = 'she'
      word_b = 'would'
      contraction = "she'd"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end
  end

  context 'contractions including will' do
    it 'returns true if it is a contraction' do
      word_a = 'You'
      word_b = 'will'
      contraction = "You'll"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end
  end

  context 'contractions including of' do
    it 'returns true if it is a contraction #001' do
      word_a = 'of'
      word_b = 'monkeys'
      contraction = "o' monkeys"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction #002' do
      word_a = 'of'
      word_b = nil
      contraction = "o'"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end
  end

  context 'contractions including it' do
    it 'returns true if it is a contraction' do
      word_a = 'It'
      word_b = 'was'
      contraction = "'Twas"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end
  end

  context 'contractions including them' do
    it 'returns true if it is a contraction' do
      word_a = 'leave'
      word_b = 'them'
      contraction = "leave 'em"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end
  end

  context 'irregular contractions' do
    it 'returns true if it is a contraction #001' do
      word_a = 'is'
      word_b = 'not'
      contraction = "ain't"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction #002' do
      word_a = 'madam'
      word_b = nil
      contraction = "ma'am"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction #003' do
      word_a = 'never-do-well'
      word_b = nil
      contraction = "ne'er-do-well"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction #004' do
      word_a = 'cat-of-nine-tails'
      word_b = nil
      contraction = "cat-o'-nine-tails"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction #005' do
      word_a = 'jack-of-the-lantern'
      word_b = nil
      contraction = "jack-o'-lantern"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction #006' do
      word_a = 'will-of-the-wisp'
      word_b = nil
      contraction = "will-o'-the-wisp"
      cc = ChatCorrect::Contraction.new(word_a: word_a, word_b: word_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end
  end
end