Gem::Specification.new do |s|
  s.name = "nifty-generators"
  s.summary = "A collection of useful Rails generator scripts."
  s.description = "A collection of useful Rails generator scripts for scaffolding, layout files, authentication, and more."
  s.homepage = "http://github.com/ryanb/nifty-generators"
  
  s.version = "0.3.2"
  s.date = "2010-02-16"
  
  s.authors = ["Ryan Bates"]
  s.email = "ryan@railscasts.com"
  
  s.require_paths = ["lib"]
  s.files = Dir["lib/**/*"] + Dir["test/**/*"] + Dir["rails_generators/**/*"] + ["LICENSE", "README.rdoc", "Rakefile", "CHANGELOG"]
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG", "LICENSE"]
  
  s.has_rdoc = true
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "NiftyGenerators", "--main", "README.rdoc"]
  
  s.rubygems_version = "1.3.4"
  s.required_rubygems_version = Gem::Requirement.new(">= 1.2")
end
