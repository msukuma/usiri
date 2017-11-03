require 'io/console'
require "inquirer"
require "usiri/mwisho"
require "usiri/muhakikisha"

class Muombi
    attr_accessor :jina, :siti, :siri, :alama, :urefu, :toleo

    def initialize(chaguo_asili)
      @jina = leta_chaguo chaguo_asili, :jina, 'JINA_USIRI'
      @siti = leta_chaguo chaguo_asili, :siti
      @siri = leta_chaguo chaguo_asili, :siri
      @alama = leta_chaguo chaguo_asili, :alama
      @urefu = leta_chaguo(chaguo_asili, :urefu).to_i
      @toleo = leta_chaguo chaguo_asili, :toleo
    end

    private
    def leta_chaguo chaguo_asili, chaguo, jina_env = nil
      jibu = leta_chaguo_asili chaguo_asili, chaguo

      if jibu.nil?
        if not jina_env.nil?
          jibu = ENV[jina_env]
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

      jibu
    end

    def leta_chaguo_asili chaguo_asili, chaguo
      chaguo_asili.method(chaguo).call if chaguo != :siri
    end

    def omba chaguo, kosa = false
      swala = tengeneza_swala chaguo, kosa
      ombi = tengeneza_ombi chaguo

      if chaguo == :siri
        return ombi.call.strip
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
        opts[:default] = UREFU_MSINGI.to_s
      when :toleo
        opts[:default] = TOLEO_MSINGI.to_s
      end
      opts
    end

    def omba_siri
        print "Ingiza siri ku: "
        ingizo = STDIN.noecho(&:gets).strip
        clear_line
        ingizo
    end

    def clear_line
      print "\r\e[0K"
    end
end
