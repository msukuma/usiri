require 'io/console'

module IT
  extend self
  def letas ondoa = false
    jibu = STDIN.noecho(&:gets)
    ondoa_line if ondoa
    jibu
  end

  def ondoa_line paka = 0
    print "\r" + ("\e[A") * paka.abs() +"\e[J"
  end
end
