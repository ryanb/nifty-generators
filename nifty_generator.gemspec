Gem::Specification.new do |s|
  s.name = %q{nifty_generator}
  s.version = "0.0.1"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Bates"]
  s.date = %q{2008-05-06}
  s.description = %q{A collection of Ryan's generator scripts for Rails.}
  s.email = ["ryan@railscasts.com"]
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "PostInstall.txt", "README.txt", "website/index.txt"]
  s.files = ["History.txt", "License.txt", "Manifest.txt", "PostInstall.txt", "README.txt", "Rakefile", "config/hoe.rb", "config/requirements.rb", "lib/nifty_generator.rb", "lib/nifty_generator/version.rb", "rails_generators/nifty_layout/USAGE", "rails_generators/nifty_layout/nifty_layout_generator.rb", "rails_generators/nifty_layout/templates/layout.html.erb", "rails_generators/nifty_layout/templates/stylesheet.css", "script/console", "script/destroy", "script/generate", "script/txt2html", "setup.rb", "tasks/deployment.rake", "tasks/environment.rake", "tasks/website.rake", "test/test_generator_helper.rb", "test/test_helper.rb", "test/test_nifty_generator.rb", "test/test_nifty_layout_generator.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/ryanb/nifty_generator/}
  s.post_install_message = %q{
For more information on nifty_generator, see http://github.com/ryanb/nifty_generator/

NOTE: Change this information in PostInstall.txt 
You can also delete it if you don't want it.


}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{nifty_generator}
  s.rubygems_version = %q{1.1.1}
  s.summary = %q{A collection of Ryan's generator scripts for Rails.}
  s.test_files = ["test/test_generator_helper.rb", "test/test_helper.rb", "test/test_nifty_generator.rb", "test/test_nifty_layout_generator.rb"]
end
