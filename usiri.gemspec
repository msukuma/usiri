# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "usiri/toleo"

Gem::Specification.new do |spec|
  spec.name                   = 'usiri'
  spec.version                = Usiri::TOLEO
  spec.executables            << 'usiri'
  spec.date                   = Time.new().strftime("%Y-%m-%d")
  spec.summary                = "Manega ya maneno ya siri"
  spec.description            = "Hii ni programu raisi ya ku hifadhi maneno ya siri"
  spec.authors                = ["Itenga"]
  spec.email                  = 'itenga@protonmail.com'
  spec.files                  = `git ls-files`.split("\n")
  spec.require_paths          = ["lib"]
  spec.required_ruby_version  = '>=2.4.0'
  spec.homepage               = 'https://github.com/msukuma/usiri'
  spec.license                = 'MIT'
end
