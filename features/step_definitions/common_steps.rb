When /^I run "([^\"]*)"$/ do |command|
  system("cd #{@current_directory} && #{command}").should be_true
end

Then /^I should see file "([^\"]*)"$/ do |path|
  File.should exist(File.join(@current_directory, path))
end

Then /^I should see "([^\"]*)" in file "([^\"]*)"$/ do |contents, short_path|
  path = File.join(@current_directory, short_path)
  File.should exist(path)
  File.readlines(path).join.should include(contents)
end
