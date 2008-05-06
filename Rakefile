require 'rubygems'
require 'rake'
 
begin
  require 'echoe'

  Echoe.new('nifty_generator', '0.0.2') do |p|
    p.summary      = "A collection of Ryan's generator scripts for Rails."
    p.description  = "A collection of Ryan's generator scripts for Rails."
    p.url          = "http://github.com/ryanb/nifty_generator"
    p.author       = 'Ryan Bates'
    p.email        = "ryan@railscasts.com"
  end

rescue LoadError => boom
  puts "You are missing a dependency required for meta-operations on this gem."
  puts "#{boom.to_s.capitalize}."
end
