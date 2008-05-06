class NiftyLayoutGenerator < Rails::Generator::Base
  attr_accessor :file_name
  
  def initialize(runtime_args, runtime_options = {})
    super
    @file_name = @args.first || 'application'
  end
  
  def manifest
    record do |m|
      m.directory 'app/views/layouts'
      m.directory 'public/stylesheets'

      m.template "layout.html.erb", "app/views/layouts/#{file_name}.html.erb"
      m.file     "stylesheet.css",  "public/stylesheets/#{file_name}.css"
    end
  end

  protected
    def banner
      <<-EOS
Creates layout and stylesheet files.

USAGE: #{$0} #{spec.name} application
EOS
    end
end
