require "inquirer"
require "usiri/muhakikisha"
require "usiri/it"
require "usiri/mwisho"

class Muombi
    attr_accessor :jina, :siti, :siri, :alama, :urefu, :toleo

    def initialize(chaguo_asili)
      karibu
      leta_chaguo_id chaguo_asili
      leta_chaguo_siri chaguo_asili
    end

    private
    def karibu
      puts MAELEZO[:karibu]
    end

    def leta_chaguo_id chaguo_asili
      [:jina, :siti, :siri].each do |chaguo|
        setti_chaguo chaguo, leta_chaguo(chaguo_asili, chaguo, ENVI[chaguo])
      end
    end

    def leta_chaguo_siri chaguo_asili
      hazijasetiwa = [];

      MSINGI.each do |jina_chaguo, thamani|
        if chaguo_haijasetiwa? chaguo_asili, jina_chaguo
          hazijasetiwa.push jina_chaguo
        else
          thamani = leta_chaguo chaguo_asili, jina_chaguo
          setti_chaguo jina_chaguo, thamani
        end
      end

      maamuzi = omba_chaguo_siri hazijasetiwa.map { |e| "#{e}: #{MSINGI[e]}" }

      hazijasetiwa.each_with_index do |chaguo, sehemu|
        amekubali_msingi = maamuzi[sehemu]
        if amekubali_msingi
          setti_chaguo chaguo, MSINGI[chaguo]
        else
          setti_chaguo chaguo, leta_chaguo(chaguo_asili, chaguo)
        end
      end
    end

    def leta_chaguo chaguo_asili, chaguo, env = nil
      jibu = leta_chaguo_asili chaguo_asili, chaguo

      if jibu.nil?
        if not env.nil?
          jibu = ENV[env]
        else
          muhakikisha = tengeneza_muhakikisha chaguo
          jibu = omba chaguo

          if not muhakikisha.nil?
            while not muhakikisha.call jibu
              jibu = omba chaguo, kosa=true
            end
          end
        end
      end

      chaguo == :urefu ? jibu.to_i : jibu
    end

    def setti_chaguo chaguo, thamani
      setta = leta_setta chaguo
      self.method(setta).call(thamani)
    end

    def leta_setta chaguo
      (chaguo.to_s + "=").to_sym
    end

    def chaguo_haijasetiwa? chaguo_asili, chaguo
      leta_chaguo_asili(chaguo_asili, chaguo).nil?
    end

    def leta_chaguo_asili chaguo_asili, chaguo
      chaguo_asili.method(chaguo).call if chaguo != :siri
    end

    def omba chaguo, kosa = false
      swala = tengeneza_swala chaguo, kosa
      ombi = tengeneza_ombi chaguo

      if chaguo == :siri
        return ombi.call(swala).strip
      else
        chaguo_ombi = tengeneza_chaguo_ombi chaguo

        if chaguo == :alama
          sehemu = ombi.call swala, AINA_MAALAMA, chaguo_ombi
          return AINA_MAALAMA[sehemu]
        else
          return ombi.call(swala, chaguo_ombi).strip
        end
      end
    end

    def tengeneza_muhakikisha chaguo
      begin
        return Muhakikisha.method chaguo
      rescue NameError
        return nil
      end
    end

    def tengeneza_swala chaguo, kosa = false
      swala = MAELEZO[chaguo]

      case chaguo
      when :alama
        swala = "chagua " + swala
      else
        swala = "Ingiza " + swala
      end

      swala = "#{MAELEZO[:jaribu_tena]} " + swala if kosa
      swala
    end

    def tengeneza_ombi chaguo
      case chaguo
      when :siri then self.method :omba_siri
      when :alama then Ask.method :list
      else Ask.method :input
      end
    end

    def tengeneza_chaguo_ombi chaguo
      opts = { response: false }

      case chaguo
      when :urefu
        opts[:default] = MSINGI[:urefu].to_s
      when :toleo
        opts[:default] = MSINGI[:toleo].to_s
      end

      opts
    end

    def omba_siri swala
      print swala
      IT.letas(ondoa=true).strip
    end

    def omba_chaguo_siri msingi
      Ask.checkbox(MAELEZO[:chaguo_siri],
                    msingi,
                    default: msingi.map { |e| true },
                    response: false)
    end
end
