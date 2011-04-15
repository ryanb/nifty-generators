require File.dirname(__FILE__) + '<%= resource_path.gsub(/[^\/]+/, '/..') %>/spec_helper'

describe <%= resource_path.camelize %>Controller do
  fixtures :all
  integrate_views

  <%= controller_methods 'tests/rspec/actions' %>
end
