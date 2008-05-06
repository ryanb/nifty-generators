class AppLayoutGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.template "layout.html.erb",   "app/views/layouts/#{file_name}.html.erb"
      m.file     "stylesheet.css", "public/stylesheets/#{file_name}.css"
    end
  end
end
