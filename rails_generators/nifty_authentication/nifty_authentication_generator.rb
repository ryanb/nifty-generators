require File.expand_path(File.dirname(__FILE__) + "/lib/insert_commands.rb")
class NiftyAuthenticationGenerator < Rails::Generator::Base
  attr_accessor :user_name, :sessions_name
  
  def initialize(runtime_args, runtime_options = {})
    super
    
    @user_name = @args[0] || 'user'
    @sessions_name = @args[1] || 'sessions'
  end
  
  def manifest
    record do |m|
      m.directory "app/models"
      m.directory "app/controllers"
      m.directory "app/helpers"
      m.directory "app/views"
      m.directory "lib"
      m.directory "test"
      m.directory "test/fixtures"
      m.directory "test/functional"
      m.directory "test/unit"
      
      m.directory "app/views/#{user_plural_name}"
      m.template "user.rb", "app/models/#{user_singular_name}.rb"
      m.template "users_controller.rb", "app/controllers/#{user_plural_name}_controller.rb"
      m.template "users_helper.rb", "app/helpers/#{user_plural_name}_helper.rb"
      m.template "views/erb/signup.html.erb", "app/views/#{user_plural_name}/new.html.erb"
      
      m.directory "app/views/#{sessions_underscore_name}"
      m.template "sessions_controller.rb", "app/controllers/#{sessions_underscore_name}_controller.rb"
      m.template "sessions_helper.rb", "app/helpers/#{sessions_underscore_name}_helper.rb"
      m.template "views/erb/login.html.erb", "app/views/#{sessions_underscore_name}/new.html.erb"
      
      m.template "authentication.rb", "lib/authentication.rb"
      m.migration_template "migration.rb", "db/migrate", :migration_file_name => "create_#{user_plural_name}"
      
      m.route_resources user_plural_name
      m.route_resources sessions_underscore_name
      m.route_name :login, 'login', :controller => sessions_underscore_name, :action => 'new'
      m.route_name :logout, 'logout', :controller => sessions_underscore_name, :action => 'destroy'
      m.route_name :signup, 'signup', :controller => user_plural_name, :action => 'new'
      
      m.insert_into 'app/controllers/application.rb', 'include Authentication'
      
      m.template "fixtures.yml", "test/fixtures/#{user_plural_name}.yml"
      m.template "tests/testunit/user.rb", "test/unit/#{user_singular_name}_test.rb"
      m.template "tests/testunit/users_controller.rb", "test/functional/#{user_plural_name}_controller_test.rb"
      m.template "tests/testunit/sessions_controller.rb", "test/functional/#{sessions_underscore_name}_controller_test.rb"
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

  def sessions_underscore_name
    sessions_name.underscore
  end

  def sessions_class_name
    sessions_name.camelize
  end

  protected

    def banner
      <<-EOS
Creates user model and controllers to handle registration and authentication.

USAGE: #{$0} #{spec.name} [user_name] [sessions_controller_name]
EOS
    end
end
