module ChatCorrect
  class Tokenize
    ABBREVIATIONS = ['adj', 'adm', 'adv', 'al', 'ala', 'alta', 'apr', 'arc', 'ariz', 'ark', 'art', 'assn', 'asst', 'attys', 'aug', 'ave', 'bart', 'bld', 'bldg', 'blvd', 'brig', 'bros', 'cal', 'calif', 'capt', 'cl', 'cmdr', 'co', 'col', 'colo', 'comdr', 'con', 'conn', 'corp', 'cpl', 'cres', 'ct', 'd.phil', 'dak', 'dec', 'del', 'dept', 'det', 'dist', 'dr', 'dr.phil', 'dr.philos', 'drs', 'e.g', 'ens', 'esp', 'esq', 'etc', 'exp', 'expy', 'ext', 'feb', 'fed', 'fla', 'ft', 'fwy', 'fy', 'ga', 'gen', 'gov', 'hon', 'hosp', 'hr', 'hway', 'hwy', 'i.e', 'ia', 'id', 'ida', 'ill', 'inc', 'ind', 'ing', 'insp', 'is', 'jan', 'jr', 'jul', 'jun', 'kan', 'kans', 'ken', 'ky', 'la', 'lt', 'ltd', 'maj', 'man', 'mar', 'mass', 'may', 'md', 'me', 'messrs', 'mex', 'mfg', 'mich', 'min', 'minn', 'miss', 'mlle', 'mm', 'mme', 'mo', 'mont', 'mr', 'mrs', 'ms', 'msgr', 'mssrs', 'mt', 'mtn', 'neb', 'nebr', 'nev', 'no', 'nos', 'nov', 'nr', 'oct', 'ok', 'okla', 'ont', 'op', 'ord', 'ore', 'p', 'pa', 'pd', 'pde', 'penn', 'penna', 'pfc', 'ph', 'ph.d', 'pl', 'plz', 'pp', 'prof', 'pvt', 'que', 'rd', 'ref', 'rep', 'reps', 'res', 'rev', 'rt', 'sask', 'sen', 'sens', 'sep', 'sept', 'sfc', 'sgt', 'sr', 'st', 'supt', 'surg', 'tce', 'tenn', 'tex', 'univ', 'usafa', 'u.s', 'ut', 'va', 'v', 'ver', 'vs', 'vt', 'wash', 'wis', 'wisc', 'wy', 'wyo', 'yuk']
    PUNCTUATION = ['。', '．', '.', '！', '!', '?', '？', '、', '¡', '¿', '„', '“', '[', ']', '"', '#', '$', '%', '&', '(', ')', '*', '+', ',' , ':', ';', '<', '=', '>', '@', '^', '_', '`', "'", '{', '|', '}', '~', '-']
    attr_reader :text
    def initialize(text:)
      @text = text
    end

    def tokenize
      return if text.nil?
      return [text] if /\A\w+\z/ =~ text
      converted_text = convert_quotes(text)
      converted_text = shift_all_punct(converted_text)
      converted_text = convert_contractions(converted_text)
      converted_text = convert_numbers_with_commas(converted_text)
      converted_text = convert_numbers_with_periods(converted_text)
      result = converted_text.split(' ')
      tokenized_array = separate_other_ending_punc(separate_full_stop(result)).map do |s|
        s.tr("\n", '').tr("\r", '').strip
      end
    end

    def tokenize_no_punct
      return if text.nil? || tokenize.nil?
      tokenize - PUNCTUATION
    end

    private

    def shift_all_punct(txt)
      converted_text = shift_multiple_dash(txt)
      converted_text = shift_comma(converted_text)
      converted_text = shift_ellipse(converted_text)
      converted_text = shift_bracket(converted_text)
      converted_text = shift_other_punct(converted_text)
      converted_text = shift_upsidedown_question_mark(converted_text)
      converted_text = shift_upsidedown_exclamation(converted_text)
      shift_special_quotes(converted_text)
    end

    def convert_quotes(txt)
      txt.gsub(/`(?!`)(?=.*\w)/o, ' ∫ ')
         .gsub(/"(?=.*\w)/o, ' ∬ ')
         .gsub(/(\W|^)'(?=.*\w)(?!twas)(?!Twas)/o) { $1 ? $1 + ' ∫ ' : ' ∫ ' }
         .gsub(/(\W|^)'(?=.*\w)/o, 'ƪ')
         .gsub(/"/, ' ∯ ')
         .gsub(/(\w|\D)'(?!')(?=\W|$)/o) { $1 + ' ∮ ' }
         .squeeze(' ').strip
    end

    def shift_multiple_dash(txt)
      txt.gsub(/--+/o, ' - ').squeeze(' ')
    end

    def shift_comma(txt)
      txt.gsub(/,(?!\d)/o, ' , ').squeeze(' ')
    end

    def shift_upsidedown_question_mark(txt)
      txt.gsub(/¿/, ' ¿ ')
    end

    def shift_upsidedown_exclamation(txt)
      txt.gsub(/¡/, ' ¡ ')
    end

    def shift_ellipse(txt)
      txt.gsub(/(\.\.\.+)/o) { ' ' + $1 + ' ' }.squeeze(' ').strip
    end

    def shift_special_quotes(txt)
      txt.gsub(/«/, ' « ').gsub(/»/, ' » ')
         .gsub(/„/, ' „ ').gsub(/“/, ' “ ')
    end

    def shift_bracket(txt)
      txt.gsub(/([\(\[\{\}\]\)])/o) { ' ' + $1 + ' ' }.squeeze(' ').strip
    end

    def shift_other_punct(txt)
      converted_text = shift_off_double_quotation_mark(txt)
      converted_text = shift_off_double_exclamation(converted_text)
      converted_text = shift_off_double_mixed_1(converted_text)
      converted_text = shift_off_double_mixed_2(converted_text)
      converted_text.gsub(/([\!\?\%;|])\s+/o) { ' ' + $1 + ' ' }.squeeze(' ').strip
    end

    def shift_off_double_quotation_mark(txt)
      txt.include?('??') ? txt.gsub(/([\?\?])\s+/o) { ' ' + $1 + ' ' } : txt
    end

    def shift_off_double_exclamation(txt)
      txt.include?('!!') ? txt.gsub(/([!!])\s+/o) { ' ' + $1 + ' ' } : txt
    end

    def shift_off_double_mixed_1(txt)
      txt.include?('?!') ? txt.gsub(/\?\!/o) { ' ? ! ' } : txt
    end

    def shift_off_double_mixed_2(txt)
      txt.include?('!?') ? txt.gsub(/\!\?/o) { ' ! ? ' } : txt
    end

    def convert_contractions(txt)
      txt.gsub(/([A-Za-z])'([dms])\b/o) { $1 + 'ƪ' + $2 }
         .gsub(/n't\b/o, 'nƪt')
         .gsub(/'(ve|ll|re)\b/o) { 'ƪ' + $1 }
    end

    def convert_numbers_with_commas(txt)
      txt.gsub(/(?<=\d),(?=\d)/, '☌')
    end

    def convert_numbers_with_periods(txt)
      txt.gsub(/(?<=\d)\.(?=\d)/, '☊')
    end

    def separate_other_ending_punc(array)
      new_array = []
      punctuation = ['。', '．', '！', '!', '?', '？']
      array.each do |a|
        counter = false
        punctuation.each do |p|
          if a.length > 1
            if a[-1] == p
              split = a.split(p)
              split.each do |b|
                new_array << b
                counter = true
              end
              new_array << p
            end
          end
        end
        if counter == false
          new_array  << a
        end
      end
      new_array
    end

    def separate_full_stop(tokens)
      words = []
      tokens.each_with_index do |_t, i|
        if tokens[i + 1] && tokens[i] =~ /\A(.+)\.\z/
          w = $1
          unless ABBREVIATIONS.include?(w.downcase) || w =~ /\A[a-z]\z/i ||
            w =~ /[a-z](?:\.[a-z])+\z/i
            words <<  w
            words << '.'
            next
          end
        end
        words << tokens[i]
      end
      if words[-1] && words[-1] =~ /\A(.*\w)\.\z/
        words[-1] = $1
        words.push '.'
      end
      words
    end
  end
end
