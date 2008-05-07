class NiftyScaffoldGenerator < Rails::Generator::Base
  attr_accessor :controller_actions
  
  def initialize(runtime_args, runtime_options = {})
    super
    usage if @args.empty?
    @name = @args.first
    @controller_actions = @args[1..-1]
  end

  def manifest
    record do |m|
      m.directory "app/controllers"
      m.directory "app/models"
      m.directory "app/views/#{controller_file_name}"
      m.template "controller.rb", "app/controllers/#{controller_file_name}_controller.rb"
      m.template "model.rb", "app/models/#{file_name}.rb"
      
      controller_actions.each do |action|
        if File.exist? source_path("views/#{action}.html.erb")
          m.template "views/#{action}.html.erb", "app/views/#{controller_file_name}/#{action}.html.erb"
        end
      end
    end
  end
  
  def file_name
    @name.underscore
  end
  
  def class_name
    @name.camelize
  end
  
  def controller_file_name
    file_name.pluralize
  end
  
  def controller_class_name
    class_name.pluralize
  end
  
  def controller_methods
    controller_actions.map do |action|
      controller_method(action)
    end.join
  end
  
  def controller_method(name)
    ERB.new(File.read(source_path("actions/#{name}.rb")), nil, '-').result(binding)
  end
  
protected
  
  def banner
    <<-EOS
Creates a controller and model given the name and attributes.

USAGE: #{$0} #{spec.name} name
EOS
  end
end
