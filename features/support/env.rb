require 'cucumber'
require 'rspec'
require 'mocha'
require 'active_support/core_ext'

World(Mocha::Standalone)

Before do
  FileUtils.rm_rf "tmp/rails_app"
  mocha_setup
end

After do
  begin
    mocha_verify
  ensure
    mocha_teardown
  end
end
