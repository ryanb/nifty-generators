require 'generators/nifty'

module Nifty
  module Generators
    class LayoutGenerator < Base
      argument :layout_name, :type => :string, :default => 'application', :banner => 'layout_name'

      class_option :haml, :desc => 'Generate HAML for view, and SASS for stylesheet.', :type => :boolean
      class_option :jquery, :desc => 'Replace the Prototype JS library with jQuery 1.4.x', :type => :boolean, :default => true

      def create_layout
        if options.haml?
          template 'layout.html.haml', "app/views/layouts/#{file_name}.html.haml"
          copy_file 'stylesheet.sass', "public/stylesheets/sass/#{file_name}.sass"
        else
          template 'layout.html.erb', "app/views/layouts/#{file_name}.html.erb"
          copy_file 'stylesheet.css', "public/stylesheets/#{file_name}.css"
        end
        if options.jquery?
          copy_file 'rails.js', 'public/javascripts/rails.js'
          if yes? "Clean up prototype files?"
            remove_file 'public/javascripts/prototype.js'
            remove_file 'public/javascripts/effects.js'
            remove_file 'public/javascripts/dragdrop.js'
            remove_file 'public/javascripts/controls.js'
          else
          end
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
