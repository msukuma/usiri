require "colorize"

# CHAGUO = {
#   ID: [:jina, :siti, :siri],
#   SIRI: [:alama, :urefu, :toleo]
# }

MSINGI = {
  alama: :yoyote,
  urefu: 23,
  toleo: 1.0
}

ENVI = {
  jina: "JINA_USIRI"
}

AINA_MAALAMA = [MSINGI[:alama], :safi, :bila]
UREFU_WASTAN_CHINI = 16
UREFU_WASTAN_JU = 88

REGEX = {
  urefu: /^[1-7][6-9]$|^[2-7][0-9]$|^8[0-8]$/,
  toleo: /^-?[\d]+\.?[\d]*$/,
  alama: /[\W_]/,
  chaguo_cli: /^-[jsautTm]$|^--jina$|^--siti$|^--alama$|^--urefu$|^--toleo$/
}

MAELEZO = {
  karibu: ("👐🏾 "+" Karibu!").black.on_yellow +
          " Ingiza au chagua chaguozako alafu bonyeza 'enter' kuendelea".green,
  jina: "jina itayotumwika kutengeneza siri",
  siti: "siti itayotumwika kutengeneza siri",
  siri: "siri ku: ",
  chaguo_siri: "tumiya chaguo haya kutengeneza siri."+
                " Bonyeza 'spacebar' kukubali aw kukataa chaguo.",
  alama: "aina ya alama | moja katita [#{AINA_MAALAMA.join(' ,')}]",
  urefu: "urefu wa siri. msingi: #{MSINGI[:urefu]},\
  wastan wa chini: #{UREFU_WASTAN_CHINI}, wastan wa ju: #{UREFU_WASTAN_JU}",
  toleo: "toleo itayotumwika kutengeneza siri. msingi: #{MSINGI[:toleo]}",
  msaada: "Oneysha mesegi hii",
  toleo_usiri: "Oneysha toleo ya programu hii",
  jaribu_tena: "**JARIBU TENA**".black.on_red,
  siri_copiwa: "🙌🏾 "+ " Siri ime copiwa kwenye ubao. Karibu tena! ".green,
  kwaheri: "Kwaheri".green + " ✌🏾"
}
