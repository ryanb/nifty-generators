require 'test/unit'
require File.dirname(__FILE__) + '/../lib/nifty_generator'

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
      [RubiGen::PathSource.new(:test, File.join(File.dirname(__FILE__),"..", "rails_generators"))]
    end
  end
end
