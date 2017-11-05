require 'usiri/mwisho'

module Muhakikisha
  extend self
  def siri s
    not s.empty?
  end

  def urefu u
    u.match? UREFU_REGEX
  end

  def toleo t
    t.match? TOLEO_REGEX
  end
end
