require 'test_helper'

class <%= resource_path.camelize %>ControllerTest < ActionController::TestCase
  <%= controller_methods 'tests/testunit/actions' %>
end
