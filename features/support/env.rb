require 'cucumber'
require 'rspec'

Before do
  FileUtils.rm_rf "tmp/rails_app"
end
