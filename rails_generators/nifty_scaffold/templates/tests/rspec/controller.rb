require File.dirname(__FILE__) + '/../spec_helper'

describe <%= resource_path.pluralize.camelize %>Controller do
  fixtures :all
  integrate_views

  <%= controller_methods 'tests/rspec/actions' %>
end
