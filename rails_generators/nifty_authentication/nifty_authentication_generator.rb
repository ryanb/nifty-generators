require File.expand_path(File.dirname(__FILE__) + "/lib/insert_commands.rb")
class NiftyAuthenticationGenerator < Rails::Generator::Base
  attr_accessor :user_name, :session_name

  def initialize(runtime_args, runtime_options = {})
    super

    @user_name = @args[0] || 'user'
    @session_name = @args[1] || (options[:authlogic] ? @user_name + '_session' : 'session')
  end

  def manifest
    record do |m|
      m.directory "app/models"
      m.directory "app/controllers"
      m.directory "app/helpers"
      m.directory "app/views"
      m.directory "lib"

      m.directory "app/views/#{user_plural_name}"
      m.template "user.rb", "app/models/#{user_singular_name}.rb"
      m.template "authlogic_session.rb", "app/models/#{session_singular_name}.rb" if options[:authlogic]
      m.template "users_controller.rb", "app/controllers/#{user_plural_name}_controller.rb"
      m.template "users_helper.rb", "app/helpers/#{user_plural_name}_helper.rb"
      m.template "views/#{view_language}/signup.html.#{view_language}", "app/views/#{user_plural_name}/new.html.#{view_language}"

      m.directory "app/views/#{session_plural_name}"
      m.template "sessions_controller.rb", "app/controllers/#{session_plural_name}_controller.rb"
      m.template "sessions_helper.rb", "app/helpers/#{session_plural_name}_helper.rb"
      m.template "views/#{view_language}/login.html.#{view_language}", "app/views/#{session_plural_name}/new.html.#{view_language}"

      m.template "authentication.rb", "lib/authentication.rb"
      m.migration_template "migration.rb", "db/migrate", :migration_file_name => "create_#{user_plural_name}"

      m.route_resources user_plural_name
      m.route_resources session_plural_name
      m.route_name :login, 'login', :controller => session_plural_name, :action => 'new'
      m.route_name :logout, 'logout', :controller => session_plural_name, :action => 'destroy'
      m.route_name :signup, 'signup', :controller => user_plural_name, :action => 'new'

      m.insert_into "app/controllers/#{application_controller_name}.rb", 'include Authentication'

      if test_framework == :rspec
        m.directory "spec"
        m.directory "spec/fixtures"
        m.directory "spec/controllers"
        m.directory "spec/models"
        m.template "fixtures.yml", "spec/fixtures/#{user_plural_name}.yml"
        m.template "tests/rspec/user.rb", "spec/models/#{user_singular_name}_spec.rb"
        m.template "tests/rspec/users_controller.rb", "spec/controllers/#{user_plural_name}_controller_spec.rb"
        m.template "tests/rspec/sessions_controller.rb", "spec/controllers/#{session_plural_name}_controller_spec.rb"
      else
        m.directory "test"
        m.directory "test/fixtures"
        m.directory "test/functional"
        m.directory "test/unit"
        m.template "fixtures.yml", "test/fixtures/#{user_plural_name}.yml"
        m.template "tests/#{test_framework}/user.rb", "test/unit/#{user_singular_name}_test.rb"
        m.template "tests/#{test_framework}/users_controller.rb", "test/functional/#{user_plural_name}_controller_test.rb"
        m.template "tests/#{test_framework}/sessions_controller.rb", "test/functional/#{session_plural_name}_controller_test.rb"
      end
    end
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

  def application_controller_name
    Rails.version >= '2.3.0' ? 'application_controller' : 'application'
  end

protected

  def view_language
    options[:haml] ? 'haml' : 'erb'
  end

  def test_framework
    options[:test_framework] ||= File.exist?(destination_path("spec")) ? :rspec : :testunit
  end

  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on("--testunit", "Use test/unit for test files.") { options[:test_framework] = :testunit }
    opt.on("--rspec", "Use RSpec for test files.") { options[:test_framework] = :rspec }
    opt.on("--shoulda", "Use Shoulda for test files.") { options[:test_framework] = :shoulda }
    opt.on("--haml", "Generate HAML views instead of ERB.") { |v| options[:haml] = true }
    opt.on("--authlogic", "Use Authlogic for authentication.") { |v| options[:authlogic] = true }
  end

  def banner
    <<-EOS
Creates user model and controllers to handle registration and authentication.

USAGE: #{$0} #{spec.name} [user_name] [sessions_controller_name]
EOS
  end
end
