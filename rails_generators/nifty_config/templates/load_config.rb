config = YAML.load File.read(RAILS_ROOT + "/config/<%= file_name %>_config.yml")
<%= constant_name %>_CONFIG = config['all'] || {}
<%= constant_name %>_CONFIG.merge! config[RAILS_ENV] || {}
<%= constant_name %>_CONFIG.symbolize_keys!
