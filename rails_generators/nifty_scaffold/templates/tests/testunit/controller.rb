require 'test_helper'

class <%= resource_path.pluralize.camelize %>ControllerTest < ActionController::TestCase
  <%= controller_methods 'tests/testunit/actions' %>
end
