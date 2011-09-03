Given /^a new Rails app$/ do
#  FileUtils.mkdir_p("tmp")
  system("rails new tmp/rails_app/any_version").should be_true
  FileUtils.ln_s("../../../../lib/generators", "tmp/rails_app/any_version/lib/generators").should be_true
  @current_directory = File.expand_path("tmp/rails_app/any_version")
end

Given /^a new Rails (\d+)\.(\d+)\.x app$/ do |major, minor|
#  FileUtils.mkdir_p("tmp")
  system("rails _#{major}.#{minor}_ new tmp/rails_app/version_#{major}.#{minor}.x").should be_true
  FileUtils.ln_s("../../../../lib/generators", "tmp/rails_app/version_#{major}.#{minor}.x/lib/generators").should be_true
  @current_directory = File.expand_path("tmp/rails_app/version_#{major}.#{minor}.x")
end
