When /^I run "([^\"]*)"$/ do |command|
  system("cd #{@current_directory} && #{command}").should be_true
end

Then /^I should see file "([^\"]*)"$/ do |path|
  File.should exist(File.join(@current_directory, path))
end
