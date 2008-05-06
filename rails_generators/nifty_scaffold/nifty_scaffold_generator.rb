class NiftyScaffoldGenerator < Rails::Generator::Base
  def initialize(runtime_args, runtime_options = {})
    super
    @name = @args.first
  end

  def manifest
    record do |m|
      m.directory "app/controllers"
      m.directory "app/models"
      m.template "controller.rb", "app/controllers/#{file_name}_controller.rb"
      m.template "model.rb", "app/models/#{file_name}.rb"
    end
  end
  
  def file_name
    @name.underscore
  end

  protected
    def banner
      <<-EOS
Creates a controller and model given the name and attributes.

USAGE: #{$0} #{spec.name} name
EOS
    end
end
