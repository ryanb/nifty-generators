require 'rubygems'
require 'rake'
require 'cucumber'
require 'cucumber/rake/task'

include Rake::DSL

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format progress"
end

task :default => :features
