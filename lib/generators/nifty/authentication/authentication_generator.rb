require 'generators/nifty'
require 'rails/generators/migration'

module Nifty
  module Generators
    class AuthenticationGenerator < Base
      include Rails::Generators::Migration

      argument :user_name, :type => :string, :default => 'user', :banner => 'user_name'
      argument :session_name, :type => :string, :default => '[[DEFAULT]]', :banner => 'sessions_controller_name'

      class_option :testunit, :desc => 'Use test/unit for test files.', :group => 'Test framework', :type => :boolean
      class_option :rspec, :desc => 'Use RSpec for test files.', :group => 'Test framework', :type => :boolean
      class_option :shoulda, :desc => 'Use shoulda for test files.', :group => 'Test framework', :type => :boolean

      class_option :haml, :desc => 'Generate HAML views instead of ERB.', :type => :boolean
      class_option :authlogic, :desc => 'Use Authlogic for authentication.', :type => :boolean

      def add_gems
        add_gem "bcrypt-ruby", :require => "bcrypt"
        add_gem "mocha", :group => :test
      end

      def create_model_files
        template 'user.rb', "app/models/#{user_singular_name}.rb"
        template 'authlogic_session.rb', "app/models/#{user_singular_name}_session.rb" if options.authlogic?
      end

      def create_controller_files
        template 'users_controller.rb', "app/controllers/#{user_plural_name}_controller.rb"
        template 'sessions_controller.rb', "app/controllers/#{session_plural_name}_controller.rb"
      end

      def create_helper_files
        template 'users_helper.rb', "app/helpers/#{user_plural_name}_helper.rb"
        template 'sessions_helper.rb', "app/helpers/#{session_plural_name}_helper.rb"
      end

      def create_view_files
        template "views/#{view_language}/signup.html.#{view_language}", "app/views/#{user_plural_name}/new.html.#{view_language}"
        template "views/#{view_language}/edit.html.#{view_language}", "app/views/#{user_plural_name}/edit.html.#{view_language}"
        template "views/#{view_language}/_form.html.#{view_language}", "app/views/#{user_plural_name}/_form.html.#{view_language}"
        template "views/#{view_language}/login.html.#{view_language}", "app/views/#{session_plural_name}/new.html.#{view_language}"
      end

      def create_lib_files
        template 'controller_authentication.rb', 'lib/controller_authentication.rb'
      end

      def create_routes
        route "resources #{user_plural_name.to_sym.inspect}"
        route "resources #{session_plural_name.to_sym.inspect}"
        route "match 'login' => '#{session_plural_name}#new', :as => :login"
        route "match 'logout' => '#{session_plural_name}#destroy', :as => :logout"
        route "match 'signup' => '#{user_plural_name}#new', :as => :signup"
        route "match '#{user_singular_name}/edit' => '#{user_plural_name}#edit', :as => :edit_current_#{user_singular_name}"
      end

      def create_migration
        migration_template 'migration.rb', "db/migrate/create_#{user_plural_name}.rb"
      end

      def load_and_include_authentication
        inject_into_class "config/application.rb", "Application", "    config.autoload_paths << \"\#{config.root}/lib\""
        inject_into_class "app/controllers/application_controller.rb", "ApplicationController", "  include ControllerAuthentication\n"
      end

      def create_test_files
        if test_framework == :rspec
          template 'fixtures.yml', "spec/fixtures/#{user_plural_name}.yml"
          template 'tests/rspec/user.rb', "spec/models/#{user_singular_name}_spec.rb"
          template 'tests/rspec/users_controller.rb', "spec/controllers/#{user_plural_name}_controller_spec.rb"
          template 'tests/rspec/sessions_controller.rb', "spec/controllers/#{session_plural_name}_controller_spec.rb"
        else
          template 'fixtures.yml', "test/fixtures/#{user_plural_name}.yml"
          template "tests/#{test_framework}/user.rb", "test/unit/#{user_singular_name}_test.rb"
          template "tests/#{test_framework}/users_controller.rb", "test/functional/#{user_plural_name}_controller_test.rb"
          template "tests/#{test_framework}/sessions_controller.rb", "test/functional/#{session_plural_name}_controller_test.rb"
        end
      end

      private

      def session_name
        @_session_name ||= @session_name == '[[DEFAULT]]' ?
          (options.authlogic? ? user_name + '_session' : 'session') :
          @session_name
      end

      def user_singular_name
        user_name.underscore
      end

      def user_plural_name
        user_singular_name.pluralize
      end

      def user_class_name
        user_name.camelize
      end

      def user_plural_class_name
        user_plural_name.camelize
      end

      def session_singular_name
        session_name.underscore
      end

      def session_plural_name
        session_singular_name.pluralize
      end

      def session_class_name
        session_name.camelize
      end

      def session_plural_class_name
        session_plural_name.camelize
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
          return @test_framework = File.exist?(destination_path('spec')) ? :rspec : :testunit
        end
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
