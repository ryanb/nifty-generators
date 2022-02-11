require 'generators/nifty'

module Nifty
  module Generators
    class LayoutGenerator < Base
      argument :layout_name, :type => :string, :default => 'application', :banner => 'layout_name'

      class_option :haml, :desc => 'Generate HAML for view, and SASS for stylesheet.', :type => :boolean
      class_option :scss, :desc => 'Generate HAML for view, and SCSS for stylesheet.', :type => :boolean

      def create_layout
        style_name = file_name
        style_path = 'public'
        if (Rails.version =~ /^3\.1/) != nil
          # For Rails 3.1 and its assets pipeline we don't want to overwrite application.css
          style_name = 'nifty_layout' if file_name == 'application'
          style_path = 'app/assets'
        end
        if options.haml?
          template 'layout.html.haml', "app/views/layouts/#{file_name}.html.haml"
          copy_file 'stylesheet.sass', "#{style_path}/stylesheets/#{style_name}.sass"
        elsif options.scss?
          template 'layout.html.haml', "app/views/layouts/#{file_name}.html.haml"
          copy_file 'stylesheet.css.scss', "#{style_path}/stylesheets/#{style_name}.css.scss"
        else
          template 'layout.html.erb', "app/views/layouts/#{file_name}.html.erb"
          copy_file 'stylesheet.css', "#{style_path}/stylesheets/#{style_name}.css"
        end
        copy_file 'layout_helper.rb', 'app/helpers/layout_helper.rb'
        copy_file 'error_messages_helper.rb', 'app/helpers/error_messages_helper.rb'
      end

      private

      def file_name
        layout_name.underscore
      end
    end
  end
end
