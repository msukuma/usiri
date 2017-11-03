require 'usiri/toleo'
require 'usiri/mwisho'

class ChaguoCLI
    attr_accessor :jina, :siti, :alama, :urefu, :toleo

    def initialize
      @jina = nil
      @siti = nil
      @alama = nil
      @urefu = nil
      @toleo = nil
      @toleo_usiri = Usiri::TOLEO
    end

    def fasili_chaguo mfasili
      mfasili.banner = 'usiri [chaguo]'

      chaguo_jina mfasili
      chaguo_siti mfasili
      chaguo_alama mfasili
      chaguo_urefu mfasili
      chaguo_toleo mfasili

      mfasili.on_tail("-m", MAELEZO[:msaada]) do
        puts mfasili
        exit
      end

      mfasili.on_tail("-T", MAELEZO[:toleo_usiri]) do
        puts @toleo_usiri
        exit
      end
    end

    private
    def chaguo_jina mfasili
      mfasili.on("-j", "--jina JINA", MAELEZO[:jina]) do |jina|
        raise kosa jina if jina.match? REGEX[:chaguo_cli]
        @jina = jina
      end
    end

    def chaguo_siti mfasili
      mfasili.on("-s", "--siti SITI", MAELEZO[:siti]) do |siti|
        raise kosa siti if siti.match? REGEX[:chaguo_cli]
        @siti = siti
      end
    end

    def chaguo_alama mfasili
      mfasili.on("-a", "--alama [AINA]", AINA_MAALAMA, MAELEZO[:alama]) do |alama|
        if AINA_MAALAMA.include? alama
          @alama = alama
        else
          @alama = MSINGI[:alama]
        end
      end
    end

    def chaguo_urefu mfasili
      mfasili.on("-u", "--urefu UREFU", REGEX[:urefu], MAELEZO[:urefu]) do |urefu|
        @urefu = urefu.to_i
      end
    end

    def chaguo_toleo mfasili
      mfasili.on("-t", "--toleo TOLEO", REGEX[:toleo], MAELEZO[:toleo]) do |toleo|
        @toleo = toleo
      end
    end

    def kosa jibu
      OptionParser::InvalidArgument.new jibu
    end

  end
