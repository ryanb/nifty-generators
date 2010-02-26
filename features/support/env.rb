require 'cucumber'
require 'spec'

Before do
  FileUtils.rm_rf "tmp/rails_app"
end
