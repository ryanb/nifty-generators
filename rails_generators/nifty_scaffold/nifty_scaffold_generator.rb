class NiftyScaffoldGenerator < Rails::Generator::Base
  def initialize(runtime_args, runtime_options = {})
    super
    @name = @args.first
    
    usage if @args.empty?
  end

  def manifest
    record do |m|
      m.directory "app/controllers"
      m.directory "app/models"
      m.template "controller.rb", "app/controllers/#{controller_name}_controller.rb"
      m.template "model.rb", "app/models/#{file_name}.rb"
    end
  end
  
  def file_name
    @name.underscore
  end
  
  def controller_name
    @name.pluralize
  end

  protected
    def banner
      <<-EOS
Creates a controller and model given the name and attributes.

USAGE: #{$0} #{spec.name} name
EOS
    end
end
