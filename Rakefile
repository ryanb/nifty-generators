require 'rubygems'
require 'rake'
 
begin
  require 'echoe'

  Echoe.new('nifty-generators', '0.0.3') do |p|
    p.summary        = "A collection of Ryan's generator scripts for Rails."
    p.description    = "A collection of Ryan's generator scripts for Rails."
    p.url            = "http://github.com/ryanb/nifty-generators"
    p.author         = 'Ryan Bates'
    p.email          = "ryan@railscasts.com"
    p.ignore_pattern = ["script/*", "*.gemspec"]
  end

rescue LoadError => boom
  puts "You are missing a dependency required for meta-operations on this gem."
  puts "#{boom.to_s.capitalize}."
end
