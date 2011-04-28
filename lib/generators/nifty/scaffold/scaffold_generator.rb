require 'generators/nifty'
require 'rails/generators/migration'
require 'rails/generators/generated_attribute'

module Nifty
  module Generators
    class ScaffoldGenerator < Base
      include Rails::Generators::Migration
      no_tasks { attr_accessor :scaffold_name, :model_attributes, :controller_actions }

      argument :scaffold_name, :type => :string, :required => true, :banner => 'ModelName'
      argument :args_for_c_m, :type => :array, :default => [], :banner => 'controller_actions and model:attributes'

      class_option :skip_model, :desc => 'Don\'t generate a model or migration file.', :type => :boolean
      class_option :skip_migration, :desc => 'Dont generate migration file for model.', :type => :boolean
      class_option :skip_timestamps, :desc => 'Don\'t add timestamps to migration file.', :type => :boolean
      class_option :skip_controller, :desc => 'Don\'t generate controller, helper, or views.', :type => :boolean
      class_option :invert, :desc => 'Generate all controller actions except these mentioned.', :type => :boolean
      class_option :namespace_model, :desc => 'If the resource is namespaced, include the model in the namespace.', :type => :boolean
      class_option :haml, :desc => 'Generate HAML views instead of ERB.', :type => :boolean

      class_option :testunit, :desc => 'Use test/unit for test files.', :group => 'Test framework', :type => :boolean
      class_option :rspec, :desc => 'Use RSpec for test files.', :group => 'Test framework', :type => :boolean
      class_option :shoulda, :desc => 'Use shoulda for test files.', :group => 'Test framework', :type => :boolean

      def initialize(*args, &block)
        super

        print_usage unless scaffold_name.underscore =~ /^[a-z][a-z0-9_\/]+$/

        @controller_actions = []
        @model_attributes = []
        @skip_model = options.skip_model?
        @namespace_model = options.namespace_model?
        @invert_actions = options.invert?

        args_for_c_m.each do |arg|
          if arg == '!'
            @invert_actions = true
          elsif arg.include?(':')
            @model_attributes << Rails::Generators::GeneratedAttribute.new(*arg.split(':'))
          else
            @controller_actions << arg
            @controller_actions << 'create' if arg == 'new'
            @controller_actions << 'update' if arg == 'edit'
          end
        end

        @controller_actions.uniq!
        @model_attributes.uniq!

        if @invert_actions || @controller_actions.empty?
          @controller_actions = all_actions - @controller_actions
        end

        if @model_attributes.empty?
          @skip_model = true # skip model if no attributes
          if model_exists?
            model_columns_for_attributes.each do |column|
              @model_attributes << Rails::Generators::GeneratedAttribute.new(column.name.to_s, column.type.to_s)
            end
          else
            @model_attributes << Rails::Generators::GeneratedAttribute.new('name', 'string')
          end
        end
      end

      def add_gems
        add_gem "mocha", :group => :test
      end

      def create_model
        unless @skip_model
          template 'model.rb', "app/models/#{model_path}.rb"
          if test_framework == :rspec
            template "tests/rspec/model.rb", "spec/models/#{model_path}_spec.rb"
            template 'fixtures.yml', "spec/fixtures/#{model_path.pluralize}.yml"
          else
            template "tests/#{test_framework}/model.rb", "test/unit/#{model_path}_test.rb"
            template 'fixtures.yml', "test/fixtures/#{model_path.pluralize}.yml"
          end
        end
      end

      def create_migration
        unless @skip_model || options.skip_migration?
          migration_template 'migration.rb', "db/migrate/create_#{model_path.pluralize.gsub('/', '_')}.rb"
        end
      end

      def create_controller
        unless options.skip_controller?
          template 'controller.rb', "app/controllers/#{plural_name}_controller.rb"

          template 'helper.rb', "app/helpers/#{plural_name}_helper.rb"

          controller_actions.each do |action|
            if %w[index show new edit].include?(action) # Actions with templates
              template "views/#{view_language}/#{action}.html.#{view_language}", "app/views/#{plural_name}/#{action}.html.#{view_language}"
            end
          end

          if form_partial?
            template "views/#{view_language}/_form.html.#{view_language}", "app/views/#{plural_name}/_form.html.#{view_language}"
          end

          namespaces = plural_name.split('/')
          resource = namespaces.pop
          route namespaces.reverse.inject("resources :#{resource}") { |acc, namespace|
            "namespace(:#{namespace}){ #{acc} }"
          }

          if test_framework == :rspec
            template "tests/#{test_framework}/controller.rb", "spec/controllers/#{plural_name}_controller_spec.rb"
          else
            template "tests/#{test_framework}/controller.rb", "test/functional/#{plural_name}_controller_test.rb"
          end
        end
      end

      private

      def form_partial?
        actions? :new, :edit
      end

      def all_actions
        %w[index show new create edit update destroy]
      end

      def action?(name)
        controller_actions.include? name.to_s
      end

      def actions?(*names)
        names.all? { |name| action? name }
      end

      def singular_name
        scaffold_name.underscore
      end

      def plural_name
        scaffold_name.underscore.pluralize
      end

      def table_name
        if scaffold_name.include?('::') && @namespace_model
          plural_name.gsub('/', '_')
        end
      end

      def class_name
        if @namespace_model
          scaffold_name.camelize
        else
          scaffold_name.split('::').last.camelize
        end
      end

      def model_path
        class_name.underscore
      end

      def plural_class_name
        plural_name.camelize
      end

      def instance_name
        if @namespace_model
          singular_name.gsub('/','_')
        else
          singular_name.split('/').last
        end
      end

      def instances_name
        instance_name.pluralize
      end

      def controller_methods(dir_name)
        controller_actions.map do |action|
          read_template("#{dir_name}/#{action}.rb")
        end.join("\n").strip
      end

      def render_form
        if form_partial?
          if options.haml?
            "= render \"form\""
          else
            "<%= render \"form\" %>"
          end
        else
          read_template("views/#{view_language}/_form.html.#{view_language}")
        end
      end

      def item_resource
        scaffold_name.underscore.gsub('/','_')
      end

      def items_path
        if action? :index
          "#{item_resource.pluralize}_path"
        else
          "root_path"
        end
      end

      def item_path(options = {})
        name = options[:instance_variable] ? "@#{instance_name}" : instance_name
        suffix = options[:full_url] ? "url" : "path"
        if options[:action].to_s == "new"
          "new_#{item_resource}_#{suffix}"
        elsif options[:action].to_s == "edit"
          "edit_#{item_resource}_#{suffix}(#{name})"
        else
          if scaffold_name.include?('::') && !@namespace_model
            namespace = singular_name.split('/')[0..-2]
            "[:#{namespace.join(', :')}, #{name}]"
          else
            name
          end
        end
      end

      def item_url
        if action? :show
          item_path(:full_url => true, :instance_variable => true)
        else
          items_url
        end
      end

      def items_url
        if action? :index
          item_resource.pluralize + '_url'
        else
          "root_url"
        end
      end

      def item_path_for_spec(suffix = 'path')
        if action? :show
          "#{item_resource}_#{suffix}(assigns[:#{instance_name}])"
        else
          if suffix == 'path'
            items_path
          else
            items_url
          end
        end
      end

      def item_path_for_test(suffix = 'path')
        if action? :show
          "#{item_resource}_#{suffix}(assigns(:#{instance_name}))"
        else
          if suffix == 'path'
            items_path
          else
            items_url
          end
        end
      end

      def model_columns_for_attributes
        class_name.constantize.columns.reject do |column|
          column.name.to_s =~ /^(id|created_at|updated_at)$/
        end
      end

      def view_language
        options.haml? ? 'haml' : 'erb'
      end

      def test_framework
        return @test_framework if defined?(@test_framework)
        if options.testunit?
          return @test_framework = :testunit
        elsif options.rspec?
          return @test_framework = :rspec
        elsif options.shoulda?
          return @test_framework = :shoulda
        else
          return @test_framework = default_test_framework
        end
      end

      def default_test_framework
        File.exist?(destination_path("spec")) ? :rspec : :testunit
      end

      def model_exists?
        File.exist? destination_path("app/models/#{singular_name}.rb")
      end

      def read_template(relative_path)
        ERB.new(File.read(find_in_source_paths(relative_path)), nil, '-').result(binding)
      end

      def destination_path(path)
        File.join(destination_root, path)
      end

      # FIXME: Should be proxied to ActiveRecord::Generators::Base
      # Implement the required interface for Rails::Generators::Migration.
      def self.next_migration_number(dirname) #:nodoc:
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
    end
  end
end
