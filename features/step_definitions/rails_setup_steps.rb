Given /^a new Rails app$/ do
  FileUtils.mkdir_p("tmp")
  system("rails new tmp/rails_app").should be_true
  system("ln -s ../../../lib/generators tmp/rails_app/lib/generators").should be_true
  @current_directory = File.expand_path("tmp/rails_app")
end
