require 'spec_helper'

RSpec.describe ChatCorrect::Tokenize do
  it 'correctly tokenizes test sentence #001' do
    text = "Hello Ms. Piggy, this is John. We are selling a new fridge for $5,000. That is a 20% discount over the Nev. retailers. It is a 'MUST BUY', so don't hesistate."
    cc = ChatCorrect::Tokenize.new(text: text)
    expect(cc.tokenize).to eq(["Hello", "Ms.", "Piggy", ",", "this", "is", "John", ".", "We", "are", "selling", "a", "new", "fridge", "for", "$5☌000", ".", "That", "is", "a", "20", "%", "discount", "over", "the", "Nev.", "retailers", ".", "It", "is", "a", "∫", "MUST", "BUY", "∮", ",", "so", "donƪt", "hesistate", "."])
  end

  it 'correctly tokenizes test sentence #002' do
    text = "Hello Ms. Piggy, this is John. We are selling a new fridge for $5,000. That is a 20% discount over the Nev. retailers. It is a 'MUST BUY', so don't hesistate."
    cc = ChatCorrect::Tokenize.new(text: text)
    expect(cc.tokenize_no_punct).to eq(["Hello", "Ms.", "Piggy", "this", "is", "John", "We", "are", "selling", "a", "new", "fridge", "for", "$5☌000", "That", "is", "a", "20", "discount", "over", "the", "Nev.", "retailers", "It", "is", "a", "∫", "MUST", "BUY", "∮", "so", "donƪt", "hesistate"])
  end

  it 'correctly tokenizes test sentence #003' do
    text = "Lisa Raines, a lawyer and director of government relations for the Industrial Biotechnical Association, contends that a judge well-versed in patent law and the concerns of research-based industries would have ruled otherwise. And Judge Newman, a former patent lawyer, wrote in her dissent when the court denied a motion for a rehearing of the case by the full court, \'The panel's judicial legislation has affected an important high-technological industry, without regard to the consequences for research and innovation or the public interest.\' Says Ms. Raines, \'[The judgement] confirms our concern that the absence of patent lawyers on the court could prove troublesome.\'"
    cc = ChatCorrect::Tokenize.new(text: text)
    expect(cc.tokenize).to eq(["Lisa", "Raines", ",", "a", "lawyer", "and", "director", "of", "government", "relations", "for", "the", "Industrial", "Biotechnical", "Association", ",", "contends", "that", "a", "judge", "well-versed", "in", "patent", "law", "and", "the", "concerns", "of", "research-based", "industries", "would", "have", "ruled", "otherwise", ".", "And", "Judge", "Newman", ",", "a", "former", "patent", "lawyer", ",", "wrote", "in", "her", "dissent", "when", "the", "court", "denied", "a", "motion", "for", "a", "rehearing", "of", "the", "case", "by", "the", "full", "court", ",", "∫", "The", "panelƪs", "judicial", "legislation", "has", "affected", "an", "important", "high-technological", "industry", ",", "without", "regard", "to", "the", "consequences", "for", "research", "and", "innovation", "or", "the", "public", "interest", ".", "∫", "Says", "Ms.", "Raines", ",", "∫", "[", "The", "judgement", "]", "confirms", "our", "concern", "that", "the", "absence", "of", "patent", "lawyers", "on", "the", "court", "could", "prove", "troublesome", ".", "∮"])
  end

  it 'correctly tokenizes test sentence #004' do
    text = 'Whether there will be eligible to become king to you?'
    cc = ChatCorrect::Tokenize.new(text: text)
    expect(cc.tokenize).to eq(["Whether", "there", "will", "be", "eligible", "to", "become", "king", "to", "you", "?"])
  end

  it 'correctly tokenizes test sentence #005' do
    cc = ChatCorrect::Tokenize.new(text: 'Whether there will be eligible to become king to you!')
    expect(cc.tokenize).to eq(["Whether", "there", "will", "be", "eligible", "to", "become", "king", "to", "you", "!"])
  end

  it 'correctly tokenizes test sentence #006' do
    cc = ChatCorrect::Tokenize.new(text: 'Whether there will be eligible to become king to you.')
    expect(cc.tokenize).to eq(["Whether", "there", "will", "be", "eligible", "to", "become", "king", "to", "you", "."])
  end

  it 'correctly tokenizes test sentence #007' do
    cc = ChatCorrect::Tokenize.new(text: "\"Whether there will be eligible to become king to you.\"")
    expect(cc.tokenize).to eq(["∬", "Whether", "there", "will", "be", "eligible", "to", "become", "king", "to", "you", ".", "∯"])
  end

  it 'correctly tokenizes test sentence #008' do
    cc = ChatCorrect::Tokenize.new(text: 'His name is Mr. Smith.')
    expect(cc.tokenize_no_punct).to eq(['His', 'name', 'is', 'Mr.', 'Smith'])
  end

  it 'correctly tokenizes test sentence #009' do
    cc = ChatCorrect::Tokenize.new(text: 'His name is Mr. Smith.')
    expect(cc.tokenize).to eq(['His', 'name', 'is', 'Mr.', 'Smith', '.'])
  end

  it 'correctly tokenizes test sentence #010' do
    cc = ChatCorrect::Tokenize.new(text: 'His name is Col. Smith.')
    expect(cc.tokenize).to eq(['His', 'name', 'is', 'Col.', 'Smith', '.'])
  end

  it 'correctly tokenizes test sentence #011' do
    cc = ChatCorrect::Tokenize.new(text: 'She went to East Univ. to get her degree.')
    expect(cc.tokenize).to eq(['She', 'went', 'to', 'East', 'Univ.', 'to', 'get', 'her', 'degree', '.'])
  end

  it 'correctly tokenizes test sentence #012' do
    cc = ChatCorrect::Tokenize.new(text: 'He works at ABC Inc. on weekends.')
    expect(cc.tokenize).to eq(['He', 'works', 'at', 'ABC', 'Inc.', 'on', 'weekends', '.'])
  end

  it 'correctly tokenizes test sentence #013' do
    cc = ChatCorrect::Tokenize.new(text: 'He went to school in Mass. back in the day.')
    expect(cc.tokenize).to eq(['He', 'went', 'to', 'school', 'in', 'Mass.', 'back', 'in', 'the', 'day', '.'])
  end

  it 'correctly tokenizes test sentence #014' do
    cc = ChatCorrect::Tokenize.new(text: 'It is cold in Jan. they say.')
    expect(cc.tokenize).to eq(['It', 'is', 'cold', 'in', 'Jan.', 'they', 'say', '.'])
  end

  it 'correctly tokenizes test sentence #015' do
    cc = ChatCorrect::Tokenize.new(text: '1, 2, 3, etc. is the beat.')
    expect(cc.tokenize).to eq(['1', ',', '2', ',', '3', ',', 'etc.', 'is', 'the', 'beat', '.'])
  end

  it 'correctly tokenizes test sentence #016' do
    cc = ChatCorrect::Tokenize.new(text: 'Alfred E. Stone is a person.')
    expect(cc.tokenize).to eq(['Alfred', 'E.', 'Stone', 'is', 'a', 'person', '.'])
  end

  it 'correctly tokenizes test sentence #017' do
    cc = ChatCorrect::Tokenize.new(text: 'The U.S.A. is a country.')
    expect(cc.tokenize).to eq(['The', 'U.S.A.', 'is', 'a', 'country', '.'])
  end

  it 'correctly tokenizes test sentence #018' do
    cc = ChatCorrect::Tokenize.new(text: 'He works at ABC Inc.')
    expect(cc.tokenize).to eq(['He', 'works', 'at', 'ABC', 'Inc', '.'])
  end

  it 'correctly tokenizes test sentence #019' do
    cc = ChatCorrect::Tokenize.new(text: 'His name is Kevin')
    expect(cc.tokenize).to eq(%w(His name is Kevin))
  end

  it 'correctly tokenizes test sentence #020' do
    cc = ChatCorrect::Tokenize.new(text: 'He paid $10,000,000 for the new house which is equivalent to ¥1,000,000,000.')
    expect(cc.tokenize).to eq(["He", "paid", "$10☌000☌000", "for", "the", "new", "house", "which", "is", "equivalent", "to", "¥1☌000☌000☌000", "."])
  end

  it 'correctly tokenizes test sentence #021' do
    cc = ChatCorrect::Tokenize.new(text: 'Exclamation point requires both marks (Q.E.D.!).')
    expect(cc.tokenize).to eq(['Exclamation', 'point', 'requires', 'both', 'marks', '(', 'Q.E.D.', '!', ')', '.'])
  end

  it 'correctly tokenizes test sentence #022' do
    cc = ChatCorrect::Tokenize.new(text: 'An abbreviation that ends with a period must not be left hanging without it (in parentheses, e.g.), and a sentence containing a parenthesis must itself have terminal punctuation (are we almost done?).')
    expect(cc.tokenize).to eq(['An', 'abbreviation', 'that', 'ends', 'with', 'a', 'period', 'must', 'not', 'be', 'left', 'hanging', 'without', 'it', '(', 'in', 'parentheses', ',', 'e.g.', ')', ',', 'and', 'a', 'sentence', 'containing', 'a', 'parenthesis', 'must', 'itself', 'have', 'terminal', 'punctuation', '(', 'are', 'we', 'almost', 'done', '?', ')', '.'])
  end

  it 'correctly tokenizes test sentence #023' do
    cc = ChatCorrect::Tokenize.new(text: 'his name is mr. smith, king of the \'entire\' forest.')
    expect(cc.tokenize).to eq(["his", "name", "is", "mr.", "smith", ",", "king", "of", "the", "∫", "entire", "∮", "forest", "."])
  end

  it 'correctly tokenizes test sentence #024' do
    cc = ChatCorrect::Tokenize.new(text: 'Check out http://www.google.com/?this_is_a_url/hello-world.html for more info.')
    expect(cc.tokenize).to eq(['Check', 'out', 'http://www.google.com/?this_is_a_url/hello-world.html', 'for', 'more', 'info', '.'])
  end

  it 'correctly tokenizes test sentence #025' do
    cc = ChatCorrect::Tokenize.new(text: 'Check out https://www.google.com/?this_is_a_url/hello-world.html for more info.')
    expect(cc.tokenize).to eq(['Check', 'out', 'https://www.google.com/?this_is_a_url/hello-world.html', 'for', 'more', 'info', '.'])
  end

  it 'correctly tokenizes test sentence #026' do
    cc = ChatCorrect::Tokenize.new(text: 'Check out www.google.com/?this_is_a_url/hello-world.html for more info.')
    expect(cc.tokenize).to eq(['Check', 'out', 'www.google.com/?this_is_a_url/hello-world.html', 'for', 'more', 'info', '.'])
  end

  it 'correctly tokenizes test sentence #027' do
    cc = ChatCorrect::Tokenize.new(text: 'Please email example@example.com for more info.')
    expect(cc.tokenize).to eq(['Please', 'email', 'example@example.com', 'for', 'more', 'info', '.'])
  end
end
