require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'cucumber'
require 'cucumber/rake/task'

desc "Run tests."
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format progress"
end

task :default => [:test, :features]
