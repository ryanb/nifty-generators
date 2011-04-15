class NiftyScaffoldGenerator < Rails::Generator::Base
  attr_accessor :name, :attributes, :controller_actions

  def initialize(runtime_args, runtime_options = {})
    super
    usage if @args.empty?

    @name = @args.first
    @controller_actions = []
    @attributes = []

    @args[1..-1].each do |arg|
      if arg == '!'
        options[:invert] = true
      elsif arg.include? ':'
        @attributes << Rails::Generator::GeneratedAttribute.new(*arg.split(":"))
      else
        @controller_actions << arg
        @controller_actions << 'create' if arg == 'new'
        @controller_actions << 'update' if arg == 'edit'
      end
    end

    @controller_actions.uniq!
    @attributes.uniq!

    if options[:invert] || @controller_actions.empty?
      @controller_actions = all_actions - @controller_actions
    end

    if @attributes.empty?
      options[:skip_model] = true # default to skipping model if no attributes passed
      if model_exists?
        model_columns_for_attributes.each do |column|
          @attributes << Rails::Generator::GeneratedAttribute.new(column.name.to_s, column.type.to_s)
        end
      else
        @attributes << Rails::Generator::GeneratedAttribute.new('name', 'string')
      end
    end
  end

  def manifest
    record do |m|
      unless options[:skip_model]
        destination = "app/models/#{model_name.underscore}.rb"
        m.directory File.dirname(destination)
        m.template "model.rb", destination
        unless options[:skip_migration]
          m.migration_template "migration.rb", "db/migrate", :migration_file_name => "create_#{model_name.underscore.pluralize.gsub('/','_')}"
        end

        if rspec?
          destination = "spec/models/#{model_name.underscore}_spec.rb"
          m.directory File.dirname(destination)
          m.template "tests/#{test_framework}/model.rb", destination
          destination = "spec/fixtures/#{model_name.underscore.pluralize}.yml"
          m.directory File.dirname(destination)
          m.template "fixtures.yml", destination
        else
          destination = "test/unit/#{model_name.underscore}_test.rb"
          m.directory File.dirname(destination)
          m.template "tests/#{test_framework}/model.rb", destination
          destination = "test/fixtures/#{model_name.underscore.pluralize}.yml"
          m.directory File.dirname(destination)
          m.template "fixtures.yml", destination
        end
      end

      unless options[:skip_controller]
        destination = "app/controllers/#{resource_path}_controller.rb"
        m.directory File.dirname(destination)
        m.template "controller.rb", destination

        destination = "app/helpers/#{resource_path}_helper.rb"
        m.directory File.dirname(destination)
        m.template "helper.rb", destination

        m.directory "app/views/#{resource_path}"
        controller_actions.each do |action|
          if File.exist? source_path("views/#{view_language}/#{action}.html.#{view_language}")
            m.template "views/#{view_language}/#{action}.html.#{view_language}", "app/views/#{resource_path}/#{action}.html.#{view_language}"
          end
        end

        if form_partial?
          m.template "views/#{view_language}/_form.html.#{view_language}", "app/views/#{resource_path}/_form.html.#{view_language}"
        end

        sentinel = 'ActionController::Routing::Routes.draw do |map|'
        namespaces = resource_path.split('/')
        resource = namespaces.pop
        route = namespaces.reverse.inject("map.resources :#{resource}") { |acc, namespace|
          "map.namespace(:#{namespace}){|map| #{acc} }"
        }
        logger.route route
        unless options[:pretend]
          m.gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
            "#{match}\n  #{route}\n"
          end
        end

        if rspec?
          destination = "spec/controllers/#{resource_path}_controller_spec.rb"
          m.directory File.dirname(destination)
          m.template "tests/#{test_framework}/controller.rb", destination
        else
          destination = "test/functional/#{resource_path}_controller_test.rb"
          m.directory File.dirname(destination)
          m.template "tests/#{test_framework}/controller.rb", destination
        end
      end
    end
  end

  def form_partial?
    actions? :new, :edit
  end

  def all_actions
    %w[index show new create edit update destroy]
  end

  def action?(name)
    controller_actions.include? name.to_s
  end

  def actions?(*names)
    names.all? { |n| action? n.to_s }
  end

  def resource_path
    name.underscore.pluralize
  end

  def singular_model_name
    model_name.underscore
  end

  def plural_model_name
    singular_model_name.pluralize
  end

  def model_name
    if options[:namespace_model]
      name.camelize
    else
      name.split('::').last.camelize
    end
  end

  def items_path
    if action? :index
      "#{resource_path.gsub('/', '_')}_path"
    else
      "root_path"
    end
  end

  def items_url
    if action? :index
      "#{resource_path.gsub('/', '_')}_url"
    else
      "root_url"
    end
  end

  def item_path(options = {})
    if action?(:show) || options[:action]
      name = options[:instance_variable] ? "@#{singular_model_name}" : singular_model_name
      if %w(new edit).include? options[:action].to_s
        "#{options[:action].to_s}_#{resource_path.singularize.gsub('/', '_')}_path(#{name})"
      else
        if resource_path.include?('/') && !options[:namespace_model]
          namespace = resource_path.split('/')[0..-2]
          "[ :#{namespace.join(', :')}, #{name} ]"
        else
          name
        end
      end
    else
      items_path
    end
  end

  def controller_methods(dir_name)
    controller_actions.map do |action|
      read_template("#{dir_name}/#{action}.rb")
    end.join("\n").strip
  end

  def render_form
    if form_partial?
      if options[:haml]
        "= render :partial => 'form'"
      else
        "<%= render :partial => 'form' %>"
      end
    else
      read_template("views/#{view_language}/_form.html.#{view_language}")
    end
  end

  def item_path_for_spec(suffix = 'path')
    if action? :show
      "#{resource_path.singularize.gsub('/', '_')}_#{suffix}(assigns[:#{singular_model_name}])"
    else
      if suffix == 'path'
        items_path
      else
        items_url
      end
    end
  end

  def item_path_for_test(suffix = 'path')
    if action? :show
      "#{resource_path.singularize.gsub('/', '_')}_#{suffix}(assigns(:#{singular_model_name}))"
    else
      if suffix == 'path'
        items_path
      else
        items_url
      end
    end
  end

  def model_columns_for_attributes
    model_name.constantize.columns.reject do |column|
      column.name.to_s =~ /^(id|created_at|updated_at)$/
    end
  end

  def rspec?
    test_framework == :rspec
  end

protected

  def view_language
    options[:haml] ? 'haml' : 'erb'
  end

  def test_framework
    options[:test_framework] ||= default_test_framework
  end

  def default_test_framework
    File.exist?(destination_path("spec")) ? :rspec : :testunit
  end

  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on("--skip-model", "Don't generate a model or migration file.") { |v| options[:skip_model] = v }
    opt.on("--skip-migration", "Don't generate migration file for model.") { |v| options[:skip_migration] = v }
    opt.on("--skip-timestamps", "Don't add timestamps to migration file.") { |v| options[:skip_timestamps] = v }
    opt.on("--skip-controller", "Don't generate controller, helper, or views.") { |v| options[:skip_controller] = v }
    opt.on("--namespace-model", "If the resource is namespaced, include the model in the namespace.") { |v| options[:namespace_model] = v }
    opt.on("--invert", "Generate all controller actions except these mentioned.") { |v| options[:invert] = v }
    opt.on("--haml", "Generate HAML views instead of ERB.") { |v| options[:haml] = v }
    opt.on("--testunit", "Use test/unit for test files.") { options[:test_framework] = :testunit }
    opt.on("--rspec", "Use RSpec for test files.") { options[:test_framework] = :rspec }
    opt.on("--shoulda", "Use Shoulda for test files.") { options[:test_framework] = :shoulda }
  end

  # is there a better way to do this? Perhaps with const_defined?
  def model_exists?
    File.exist? destination_path("app/models/#{model_name.underscore}.rb")
  end

  def read_template(relative_path)
    ERB.new(File.read(source_path(relative_path)), nil, '-').result(binding)
  end

  def banner
    <<-EOS
Creates a controller and optional model given the name, actions, and attributes.

USAGE: #{$0} #{spec.name} ModelName [controller_actions and model:attributes] [options]
EOS
  end
end
