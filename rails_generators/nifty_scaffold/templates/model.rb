class <%= model_name %> < ActiveRecord::Base
  <%= "set_table_name :#{plural_model_name}" if model_name.include?('::') %>
  attr_accessible <%= attributes.map { |a| ":#{a.name}" }.join(", ") %>
end
