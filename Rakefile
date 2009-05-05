require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('nifty-generators', '0.2.4') do |p|
  p.project        = "niftygenerators"
  p.description    = "A collection of useful generator scripts for Rails."
  p.url            = "http://github.com/ryanb/nifty-generators"
  p.author         = 'Ryan Bates'
  p.email          = "ryan (at) railscasts (dot) com"
  p.ignore_pattern = ["script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
