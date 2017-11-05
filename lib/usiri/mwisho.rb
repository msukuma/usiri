require "colorize"

UREFU_WASTAN_CHINI = 16
UREFU_WASTAN_JU = 88
UREFU_MSINGI = 23
UREFU_REGEX = /^[1-7][6-9]$|^[2-7][0-9]$|^8[0-8]$/
TOLEO_MSINGI = 1.0
TOLEO_REGEX = /^-?[\d]+\.?[\d]*$/
ALAMA_MSINGI = :yoyote
ALAMA_REGEX = /[\W_]/
AINA_MAALAMA = [ALAMA_MSINGI, :safi, :bila]
CHAGUO_CLI_REGEX = /^-[jsautTm]$|^--jina$|^--siti$|^--alama$|^--urefu$|^--toleo$/
MAELEZO = {
  jina: "jina itayotumwika kutengeneza siri",
  siti: "siti itayotumwika kutengeneza siri",
  siri: "siri ku: ",
  alama: "aina ya alama | moja katita [#{AINA_MAALAMA.join(" ,")}]",
  urefu: "urefu wa siri. msingi: #{UREFU_MSINGI},\
  wastan wa chini: #{UREFU_WASTAN_CHINI}, wastan wa ju: #{UREFU_WASTAN_JU}",
  toleo: "toleo itayotumwika kutengeneza siri. msingi: #{TOLEO_MSINGI}",
  msaada: "Oneysha mesegi hii",
  toleo_usiri: "Oneysha toleo ya programu hii",
  jaribu_tena: "**JARIBU TENA**".black.on_red,
  siri_copiwa: "Siri ime copiwa kwenye ubao".green
}
