require 'test_helper'

class <%= plural_class_name %>ControllerTest < ActionController::TestCase
  fixtures :all
  
  <%= controller_methods :action_tests %>
end
