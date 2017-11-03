require 'usiri/mwisho'

module Muhakikisha
  extend self

  def urefu u
    u.match? UREFU_REGEX
  end

  def toleo t
    t.match? TOLEO_REGEX
  end
end
