When /^I run "([^\"]*)"$/ do |command|
  system("cd #{@current_directory} && #{command}").should be_true
end

When /^I add "([^\"]*)" to file "([^\"]*)"$/ do |content, short_path|
  path = File.join(@current_directory, short_path)
  File.should exist(path)
  File.open(path, 'a') { |f| f.write(content) }
end

Then /^I should see file "([^\"]*)"$/ do |path|
  File.should exist(File.join(@current_directory, path))
end

Then /^I should see "([^\"]*)" in file "([^\"]*)"$/ do |content, short_path|
  path = File.join(@current_directory, short_path)
  File.should exist(path)
  File.readlines(path).join.should include(content)
end

Then /^I should see the following files$/ do |table|
  table.raw.flatten.each do |path|
    File.should exist(File.join(@current_directory, path))
  end
end

Then /^I should see the following in file "([^\"]*)"$/ do |short_path, table|
  path = File.join(@current_directory, short_path)
  File.should exist(path)
  table.raw.flatten.each do |content|
    File.readlines(path).join.should include(content)
  end
end

Then /^I should successfully run "([^\"]*)"$/ do |command|
  system("cd #{@current_directory} && #{command}").should be_true
end
