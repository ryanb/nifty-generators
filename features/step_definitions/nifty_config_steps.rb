Then /^the constant (.*) should contain the following data when in the (.*) environment:$/ do |constant_name, environment, table|
  config_name = constant_name.split('_CONFIG')[0]
  load_nifty_config(config_name, environment)

  config = []
  Object.const_get(constant_name).stringify_keys.each_pair do |key, value|
    config.push({'Key' => key, 'Value' => value.to_s})
  end

  table.hashes.each { |row| config.include?(row).should be_true }
end
