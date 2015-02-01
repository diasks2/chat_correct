module ChatCorrect
  class CommonVerbMistake
    COMMON_VERB_MISTAKES =
      { "flied" => "flew",
        "weared" => "wore",
        "finded" => "found",
        "fighted" => "fought",
        "clinged" => "clung",
        "bleeded" => "bled",
        "bringed" => "brought",
        "catched" => "caught",
        "cutted" => "cut",
        "feeled" => "felt",
        "drived" => "drove",
        "falled" => "fell",
        "forgetted" => "forgot",
        "freezed" => "froze",
        "gived" => "gave",
        "heared" => "heard",
        "hurted" => "hurt",
        "keeped" => "kept",
        "knowed" => "knew",
        "leaved" => "left",
        "losed" => "lost",
        "meaned" => "meant",
        "quited" => "quit",
        "quitted" => "quit",
        "ridded" => "rode",
        "runned" => "ran",
        "rised" => "rose",
        "seed" => "saw",
        "singed" => "sang",
        "sitted" => "sat",
        "sited" => "sat",
        "speaked" => "spoke",
        "standed" => "stood",
        "sweared" => "swore",
        "swimmed" => "swam",
        "thinked" => "thought",
        "telled" => "told",
        "taked" => "took",
        "stringed" => "strung",
        "teached" => "taught",
        "waked" => "woke",
        "weeped" => "wept",
        "winned" => "won",
        "writed" => "wrote",
        "weaved" => "wove",
        "gots" => "have"
      }
    attr_reader :word_a, :word_b
    def initialize(word_a:, word_b:)
      @word_a = word_a
      @word_b = word_b
    end

    def exists?
      COMMON_VERB_MISTAKES[word_a].eql?(word_b) ||
      COMMON_VERB_MISTAKES[word_b].eql?(word_a)
    end
  end
end