require 'spec_helper'

RSpec.describe ChatCorrect::Contraction do
  it 'handles nil values' do
    token_a = nil
    token_b = nil
    contraction = nil
    cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
    expect(cc.contraction?).to eq(false)
  end

  context 'contractions including not' do
    it 'returns true if it is a contraction' do
      token_a = 'am'
      token_b = 'not'
      contraction = 'ainƪt'
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction' do
      token_a = 'am'
      token_b = 'not'
      contraction = "ain't"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction' do
      token_a = 'is'
      token_b = 'not'
      contraction = "isn't"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction' do
      token_a = 'should'
      token_b = 'not'
      contraction = "shouldn't"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns false if it is a contraction' do
      token_a = 'is'
      token_b = 'not'
      contraction = "is't"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(false)
    end
  end

  context 'contractions including us' do
    it 'returns true if it is a contraction' do
      token_a = 'let'
      token_b = 'us'
      contraction = "let's"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end
  end

  context 'contractions including am' do
    it 'returns true if it is a contraction' do
      token_a = 'I'
      token_b = 'am'
      contraction = "I'm"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end
  end

  context 'contractions including are' do
    it 'returns true if it is a contraction' do
      token_a = 'You'
      token_b = 'are'
      contraction = "You're"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns false if it is a contraction' do
      token_a = 'You'
      token_b = 'are'
      contraction = "you'rre"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(false)
    end
  end

  context 'contractions including is, does, has' do
    it 'returns true if it is a contraction' do
      token_a = 'she'
      token_b = 'is'
      contraction = "she's"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction' do
      token_a = 'she'
      token_b = 'does'
      contraction = "she's"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction' do
      token_a = 'she'
      token_b = 'has'
      contraction = "she's"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns false if it is not a contraction' do
      token_a = 'she'
      token_b = 'has'
      contraction = "she'ss"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(false)
    end
  end

  context 'contractions including have' do
    it 'returns true if it is a contraction' do
      token_a = 'You'
      token_b = 'have'
      contraction = "You've"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end
  end

  context 'contractions including had, did, would' do
    it 'returns true if it is a contraction' do
      token_a = 'she'
      token_b = 'had'
      contraction = "she'd"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction' do
      token_a = 'she'
      token_b = 'did'
      contraction = "she'd"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction' do
      token_a = 'she'
      token_b = 'would'
      contraction = "she'd"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end
  end

  context 'contractions including will' do
    it 'returns true if it is a contraction' do
      token_a = 'You'
      token_b = 'will'
      contraction = "You'll"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end
  end

  context 'contractions including of' do
    it 'returns true if it is a contraction #001' do
      token_a = 'of'
      token_b = 'monkeys'
      contraction = "o' monkeys"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction #002' do
      token_a = 'of'
      token_b = nil
      contraction = "o'"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end
  end

  context 'contractions including it' do
    it 'returns true if it is a contraction' do
      token_a = 'It'
      token_b = 'was'
      contraction = "'Twas"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end
  end

  context 'contractions including them' do
    it 'returns true if it is a contraction' do
      token_a = 'leave'
      token_b = 'them'
      contraction = "leave 'em"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end
  end

  context 'irregular contractions' do
    it 'returns true if it is a contraction #001' do
      token_a = 'is'
      token_b = 'not'
      contraction = "ain't"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction #002' do
      token_a = 'madam'
      token_b = nil
      contraction = "ma'am"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction #003' do
      token_a = 'never-do-well'
      token_b = nil
      contraction = "ne'er-do-well"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction #004' do
      token_a = 'cat-of-nine-tails'
      token_b = nil
      contraction = "cat-o'-nine-tails"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction #005' do
      token_a = 'jack-of-the-lantern'
      token_b = nil
      contraction = "jack-o'-lantern"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end

    it 'returns true if it is a contraction #006' do
      token_a = 'will-of-the-wisp'
      token_b = nil
      contraction = "will-o'-the-wisp"
      cc = ChatCorrect::Contraction.new(token_a: token_a, token_b: token_b, contraction: contraction)
      expect(cc.contraction?).to eq(true)
    end
  end
end
