require 'rubygems'
require 'rake'
require 'rake/testtask'

desc "Run tests."
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

task :default => :test
