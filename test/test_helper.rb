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

require 'rubygems'
gem 'rails', '2.0.2' # getting a Rails.configuration error with 2.1
require 'rubigen'  # gem install rubigen
require 'rubigen/helpers/generator_test_helper'
require 'rails_generator'
require 'shoulda' # gem install Shoulda
require 'mocha'

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
      options = args.pop if args.last.kind_of? Hash
      options ||= {}
      run_generator(generator.to_s, args, generator_sources, options.reverse_merge(:quiet => true))
    end
  
    def generator_sources
      [RubiGen::PathSource.new(:test, File.join(File.dirname(__FILE__), "..", "rails_generators"))]
    end
  end
  
  module ShouldaAdditions
    def rails_generator(*args)
      setup do
        run_rails_generator(*args)
      end
    end
    
    def should_generate_file(file, &block)
      should "generate file #{file}" do
        yield("foo") if block_given?
        assert_generated_file(file)
      end
    end
    
    def should_not_generate_file(file)
      should "not generate file #{file}" do
        assert !File.exists?("#{APP_ROOT}/#{file}"),"The file '#{file}' should not exist"
      end
    end
  end
end

class Thoughtbot::Shoulda::Context
  include NiftyGenerators::ShouldaAdditions
end

# Mock out what we need from AR::Base.
module ActiveRecord
  class Base
    class << self
      attr_accessor :pluralize_table_names, :columns

      def add_column(name, type = :string)
        returning ActiveRecord::ConnectionAdapters::Column.new(name, nil) do |column|
          column.type = type
          @columns ||= []
          @columns << column
        end
      end
    end
    self.pluralize_table_names = true
  end

  module ConnectionAdapters
    class Column
      attr_accessor :name, :default, :type, :limit, :null, :sql_type, :precision, :scale

      def initialize(name, default, sql_type = nil)
        @name = name
        @default = default
        @type = @sql_type = sql_type
      end

      def human_name
        @name.humanize
      end
    end
  end
end

# And what we need from ActionView
module ActionView
  module Helpers
    module ActiveRecordHelper; end
    class InstanceTag; end
  end
end
