require 'test/unit'

# Must set before requiring generator libs.
TMP_ROOT = File.dirname(__FILE__) + "/tmp" unless defined?(TMP_ROOT)
PROJECT_NAME = "myproject" unless defined?(PROJECT_NAME)
app_root = File.join(TMP_ROOT, PROJECT_NAME)
if defined?(APP_ROOT)
  APP_ROOT.replace(app_root)
else
  APP_ROOT = app_root
end
if defined?(RAILS_ROOT)
  RAILS_ROOT.replace(app_root)
else
  RAILS_ROOT = app_root
end

begin
  require 'rubigen'
rescue LoadError
  require 'rubygems'
  require 'rubigen'
end
require 'rubigen/helpers/generator_test_helper'
require 'rails_generator'

module NiftyGenerators
  module TestHelper
    include RubiGen::GeneratorTestHelper
  
    def setup
      bare_setup
    end

    def teardown
      bare_teardown
    end
  
    protected
  
    def run_rails_generator(generator, *args)
      options = args.shift! if args.last.kind_of? Hash
      options ||= {}
      run_generator(generator.to_s, args, generator_sources, options.reverse_merge(:quiet => true))
    end
  
    def generator_sources
      [RubiGen::PathSource.new(:test, File.join(File.dirname(__FILE__), "..", "rails_generators"))]
    end
  end
end
