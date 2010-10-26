config = YAML.load File.read(Rails.root + 'config/<%= file_name %>_config.yml')
<%= constant_name %>_CONFIG = config['all'] || {}
<%= constant_name %>_CONFIG.merge! config[Rails.env] || {}
<%= constant_name %>_CONFIG.symbolize_keys!
