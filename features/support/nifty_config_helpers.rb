module NiftyConfigHelpers
  def load_nifty_config(config_name, environment)
    Object.const_set(:Rails, mock) unless defined?(Rails)
    Rails.expects(:env).returns(environment)
    Rails.expects(:root).returns(Pathname.new(@current_directory))
    load File.expand_path("config/initializers/load_#{config_name.underscore}_config.rb", @current_directory)
  end
end

World(NiftyConfigHelpers)
