raw_config = File.read("#{Rails.root}/config/<%= file_name %>_config.yml")
<%= constant_name %>_CONFIG = YAML.load(raw_config)[Rails.env].symbolize_keys
