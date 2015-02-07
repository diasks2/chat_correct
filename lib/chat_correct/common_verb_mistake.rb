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
    attr_reader :token_a, :token_b
    def initialize(token_a:, token_b:)
      @token_a = token_a
      @token_b = token_b
    end

    def exists?
      COMMON_VERB_MISTAKES[token_a].eql?(token_b) ||
      COMMON_VERB_MISTAKES[token_b].eql?(token_a)
    end
  end
end
