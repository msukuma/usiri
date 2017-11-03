require 'optparse'
require 'usiri/chaguo_cli'
require 'usiri/muombi'

module Msaidizi
  extend self

  def chambua_chaguo(chaguo_cli)
    chaguo_asili = chambua_chaguo_cli chaguo_cli
    omba_chaguo_kama_hazipo chaguo_asili
  end

  private
  def chambua_chaguo_cli chaguo_cli
    chaguo_asili = ChaguoCLI.new

    OptionParser.new do |mfasili|
      chaguo_asili.fasili_chaguo mfasili

      begin
        mfasili.parse! chaguo_cli
      rescue Exception => kosa
        onyesha_kosa kosa, mfasili
        exit
      end
    end

    chaguo_asili
  end

  def onyesha_kosa kosa, mfasili
    makosa = [
      OptionParser::AmbiguousArgument,
      OptionParser::AmbiguousOption,
      OptionParser::InvalidArgument,
      OptionParser::InvalidOption,
      OptionParser::MissingArgument,
      OptionParser::NeedlessArgument
    ]

    if makosa.include? kosa.class
      puts kosa.message
      puts mfasili
    else
      raise kosa
    end
  end

  def omba_chaguo_kama_hazipo chaguo_asili
    Muombi.new chaguo_asili
  end
end
