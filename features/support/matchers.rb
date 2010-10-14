RSpec::Matchers.define :exist do |path|
  match do
    File.exist?(path)
  end
  failure_message_for_should { "Expected #{path} to exist but no file found" }
  failure_message_for_should_not { "Expected #{path} to not exist but file was found" }
end
