require 'cucumber'
require 'spec'

After do
  FileUtils.rm_rf "tmp/rails_app"
end
