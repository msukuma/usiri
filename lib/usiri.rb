require 'digest'
require 'clipboard'
require 'usiri/IT'
require 'usiri/msaidizi'
require 'usiri/mwisho'

module Usiri
  extend self

  def tengeneza_siri(chaguo_cli)
    chaguo = Msaidizi.chambua_chaguo chaguo_cli
    @jina = chaguo.jina
    @siti = chaguo.siti
    @siri = chaguo.siri
    @alama = chaguo.alama
    @urefu = chaguo.urefu
    @toleo = chaguo.toleo
    @id = tengeneza_id

    tengeneza
  end

  private
  def tengeneza
    tokeo = hesabu_tokeo
    kutoka = maalama if tumiya_alama?

    if tumiya_alama? and ina_alama? tokeo
      tokeo = badilisha_maalama tokeo, kutoka, hashi
    elsif tumiya_alama?
      tokeo = ingiza_alama tokeo, kutoka, hashi
    elsif ina_alama? tokeo
      kutoka = ju_chini
      tokeo = badilisha_maalama tokeo, kutoka, hashi
    end

    copi_kwenye_ubao tokeo
    kwaheri
  end

  def tengeneza_id
    @jina + @siti + @siri + @alama.to_s + @urefu.to_s + @toleo.to_s
  end

  def hesabu_tokeo
    Digest::SHA512.base64digest(@id)[0...@urefu]
  end

  def hashi
    h = 7
    @id.each_char { |chr| h = h*19 + chr.ord  }
    h
  end

  def tumiya_alama?
    @alama != :bila
  end

  def ina_alama? neno
    neno.match? REGEX[:alama]
  end

  def ni_alama? chr
    ina_alama? chr
  end

  def alama_safi
    "!#$%&*+-<=>?@[]^{}".split ""
  end

  def alama_yoyote
    [
      (33..47).to_a,
      (58..64).to_a,
      (91..96).to_a,
      (123..126).to_a,
    ].flatten.map { |e| e.chr }
  end

  def maalama
    @alama == MSINGI[:alama] ? alama_yoyote : alama_safi
  end

  def ju_chini
    [
      (65..90).to_a,
      (97..122).to_a,
    ].flatten.map { |e| e.chr }
  end

  def badilisha_maalama tokeo, kutoka, hashi
    tokeo = tokeo.split("")
    tokeo.each_with_index do |chr, sehemu|

      if ni_alama? chr
        sehemu_tokeo = ((sehemu + 1) * hashi) % kutoka.length
        alama = kutoka[sehemu_tokeo]
        tokeo[sehemu] = alama
      end
    end

    tokeo.join("")
  end

  def ingiza_alama tokeo, maalama, hashi
    herufu_tokeo = tokeo.split ""
    sehemu_tokeo = hashi % @urefu
    sehemu_alama = hashi % maalama.length
    herufu = herufu_tokeo[sehemu_tokeo]

    if maalama.include? herufu
      herufu_tokeo[@urefu - sehemu_tokeo] = maalama[sehemu_alama]
    else
      herufu_tokeo[sehemu_tokeo] = maalama[sehemu_alama]
    end

    herufu_tokeo.join
  end

  def copi_kwenye_ubao siri
    Clipboard.copy siri
  end

  def kwaheri
    IT.ondoa_line paka=1
    puts MAELEZO[:siri_copiwa] + MAELEZO[:kwaheri]
  end
end
