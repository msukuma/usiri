require 'usiri/mwisho'

module Muhakikisha
  extend self
  def siri s
    not s.empty?
  end

  def urefu u
    u.match? REGEX[:urefu]
  end

  def toleo t
    t.match? REGEX[:toleo]
  end
end
