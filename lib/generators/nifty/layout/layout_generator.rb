require 'generators/nifty'

module Nifty
  module Generators
    class LayoutGenerator < Base
      argument :layout_name, :type => :string, :default => 'application', :banner => 'layout_name'

      class_option :haml, :desc => 'Generate HAML for view, and SASS for stylesheet.', :type => :boolean

      def create_layout
        if options.haml?
          template 'layout.html.haml', "app/views/layouts/#{file_name}.html.haml"
          copy_file 'stylesheet.sass', "public/stylesheets/sass/#{file_name}.sass"
        else
          template 'layout.html.erb', "app/views/layouts/#{file_name}.html.erb"
          copy_file 'stylesheet.css', "public/stylesheets/#{file_name}.css"
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
