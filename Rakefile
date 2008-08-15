require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('nifty-generators', '0.1.7') do |p|
  p.summary        = "A collection of useful generator scripts for Rails."
  p.description    = "A collection of useful generator scripts for Rails."
  p.url            = "http://github.com/ryanb/nifty-generators"
  p.author         = 'Ryan Bates'
  p.email          = "ryan (at) railscasts (dot) com"
  p.ignore_pattern = ["script/*", "*.gemspec"]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
